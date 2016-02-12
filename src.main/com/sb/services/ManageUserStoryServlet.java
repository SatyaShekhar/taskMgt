package com.sb.services;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.sb.constants.Action;
import com.sb.constants.PropertyNames;
import com.sb.db.helper.ConnectionProvider;
import com.sb.message.log.MessageLogger;
import com.sb.pojo.Author;
import com.sb.pojo.History;
import com.sb.pojo.Iteration;
import com.sb.pojo.PastInformation;
import com.sb.pojo.UserStory;


/**
 * Servlet implementation class UpdateUserStoryServlet
 * 
 * @author satya60.shekhar@gmail.com
 */
@WebServlet("/manageUserStory")
public class ManageUserStoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static MessageLogger logger;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManageUserStoryServlet() {
        super();
        logger = new MessageLogger(getClass());
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        logger.info("1. Do get started for managing user story");
        Author loggedInUser = (Author) request.getSession().getAttribute(PropertyNames.USER);
        if (loggedInUser == null) {
            throw new IllegalStateException(
                    "Something is missing to initilize the loogged in user in session scope. Please check and fix :)");
        }
        Action action = Action.valueOf(request.getParameter(PropertyNames.USER_ACTION));
        
        if (action == null) {
            throw new IllegalStateException("This is not expected action should be provided here");
        }
        
        String usIdString = request.getParameter(PropertyNames.USERSTORY_ID);
        Session session = ConnectionProvider.openSession();
        if (Action.Delete == action) {
            Object userStoryObj = session.load(UserStory.class, Long.parseLong(usIdString));
            UserStory userStory = (UserStory) userStoryObj;
            userStory.getIteration().getHistory().addInfo(new PastInformation("User story deleted with Name " + userStory.getName() + " Description :" + userStory.getDescription(), loggedInUser));
            
            session.delete(userStoryObj);
            response.sendRedirect("helper\\SuccessMessageAndCoseWithReloadParent.jsp");
            ConnectionProvider.closeSessionAndDissconnect(session);
            return;
        }

        String userStoryName = request.getParameter(PropertyNames.USERSTORY_NAME);
        String userStoryDescription = request.getParameter(PropertyNames.USERSTORY_DESCRIPTION);
        UserStory userStory = new UserStory(userStoryName, userStoryDescription);
        if (Action.Update == action) {
            userStory = (UserStory) session.load(UserStory.class, Long.parseLong(usIdString));
            userStory.setName(userStoryName);
            userStory.setDescription(userStoryDescription);
            userStory.getHistory().addInfo(new PastInformation("User story name " + userStory.getName() + " Description " + userStory.getDescription(), loggedInUser));
        } else if (Action.Create == action) {
            userStory = new UserStory(userStoryName, userStoryDescription);
            History history = new History();
            history.addInfo(new PastInformation("New user story created with name " + userStory.getName() + " Task Description " + userStory.getDescription(), loggedInUser));
            userStory.setHistory(history);
            session.save(history);
        } else {
            throw new IllegalStateException("Action called for invalid action " + action);
        }
        String userIdString = request.getParameter(PropertyNames.USER_ID);
        String planEstimateString = request.getParameter(PropertyNames.USERSTORY_PLANESTIMATE);
        String iterationIdString = request.getParameter(PropertyNames.ITERATION_ID);
        String usPriorityString = request.getParameter(PropertyNames.USERSTORY_PRIORITY);
        
        Author author = (Author) session.load(Author.class, Long.parseLong(userIdString));
        Iteration iteration = (Iteration) session.load(Iteration.class, Long.parseLong(iterationIdString));
        logger.info("Retrieved author and iteration are " + author.getAuthorName() + " " + iteration.getName());
        
        userStory.setAuthor(author);
        userStory.setPlanEstimate(Float.parseFloat(planEstimateString));
        userStory.setIteration(iteration);
        userStory.setPriority(Byte.parseByte(usPriorityString));
        
        session.save(userStory);
        ConnectionProvider.closeSessionAndDissconnect(session);
        logger.info(action + " completed successfully" + userStory.getName());
        response.sendRedirect("helper\\SuccessMessageAndCoseWithReloadParent.jsp");
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
    }

}
