package com.sb.services;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;

import com.sb.constants.Action;
import com.sb.constants.PropertyNames;
import com.sb.db.helper.ConnectionProvider;
import com.sb.db.helper.HqlQueryHelper;
import com.sb.message.log.MessageLogger;
import com.sb.pojo.Iteration;

/**
 * Servlet implementation class UserMainPageAction
 * 
 * @author satya60.shekhar@gmail.com
 */
@WebServlet("/userMainPageAction")
public class UserMainPageAction extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MessageLogger logger = new MessageLogger(UserMainPageAction.class);

    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserMainPageAction() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        logger.info("Do get called....");
        String newProjectIdString = request.getParameter(PropertyNames.PROJECT_ID);
        String newIterationIdString = request.getParameter(PropertyNames.ITERATION_ID);
        HttpSession session = request.getSession(true);
        Long oldProjectID = (Long) session.getAttribute(PropertyNames.PROJECT_ID);
        Session sessionDB = ConnectionProvider.openSession();
        if (newProjectIdString == null) {
            throw new IllegalStateException("Project id can not be null here ... how it was null check !!!");
        }
        if (oldProjectID == null || (!newProjectIdString.equals(oldProjectID.toString()))) {
            logger.info("Project name changed change the iteration name");
            session.setAttribute(PropertyNames.PROJECT_ID, Long.parseLong(newProjectIdString));
            if (Action.Manage.name().equals(request.getParameter(PropertyNames.USER_ACTION))) {
                // Called to manage with proper project id and iteration id so set the iteration id and iteration can no be empty so add any logic for that
                session.setAttribute(PropertyNames.ITERATION_ID, Long.parseLong(newIterationIdString));
            } else {
                List<Iteration> iterations = HqlQueryHelper.getIterationsUnderProject(sessionDB, Integer.valueOf(newProjectIdString));
                if (iterations.isEmpty()) {
                    session.removeAttribute(PropertyNames.ITERATION_ID);
                } else {
                    session.setAttribute(PropertyNames.ITERATION_ID, iterations.get(0).getIterationId());
                }
            }
        } else if (newIterationIdString != null) {
            session.setAttribute(PropertyNames.ITERATION_ID, Long.parseLong(newIterationIdString));
        }
        logger.info("Result updated to session project id = " + session.getAttribute(PropertyNames.PROJECT_ID) + " Iteration = "
                + session.getAttribute(PropertyNames.ITERATION_ID));
        response.sendRedirect("UserMainPage.jsp");
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Do post of " + this.getClass().getName());
    }

}
