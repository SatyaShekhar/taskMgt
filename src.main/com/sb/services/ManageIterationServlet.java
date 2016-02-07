package com.sb.services;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.sb.constants.Action;
import com.sb.constants.Constants;
import com.sb.constants.PropertyNames;
import com.sb.db.helper.ConnectionProvider;
import com.sb.message.log.MessageLogger;
import com.sb.pojo.Author;
import com.sb.pojo.History;
import com.sb.pojo.Iteration;
import com.sb.pojo.PastInformation;
import com.sb.pojo.Project;

/**
 * Servlet implementation class ManageIterationServlet
 */
@WebServlet("/manageIteration")
public class ManageIterationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static MessageLogger logger = new MessageLogger(ManageIterationServlet.class);
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManageIterationServlet() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        logger.warning("Do get called so redirecting to post.. better to use post method");
        doPost(request, response);
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        logger.info("Do post started for iteration managerment");
        Action action = Action.valueOf(request.getParameter(PropertyNames.USER_ACTION));
        if (action == null) {
            throw new IllegalStateException("Action should not be nll here");
        }
        Author loggedInUser = (Author) request.getSession(true).getAttribute(PropertyNames.USER);
        
        if (loggedInUser == null) {
            throw new IllegalStateException(
                    "Something is missing to initilize the loogged in user in session scope. Please check and fix :)");
        }
        Session session = ConnectionProvider.openSession();
        String itertionIdString = request.getParameter(PropertyNames.ITERATION_ID);
        if (Action.Delete == action) {
            Iteration iteration = (Iteration)session.load(Iteration.class, Long.parseLong(itertionIdString));
            iteration.getProject().getHistory().addInfo(new PastInformation("Iteration deleted. Name " + iteration.getName() + " Description :" + iteration.getDescription(), loggedInUser));
            session.save(iteration.getProject()); // TODO is this save required..i guess the delete after this will update this one as well
            session.delete(iteration);
            ConnectionProvider.closeSessionAndDissconnect(session);
            response.sendRedirect("helper\\SuccessMessageAndCoseWithReloadParent.jsp");
            return;
        }
        String iterationName = request.getParameter(PropertyNames.ITERATION_NAME);
        String iterationDesc = request.getParameter(PropertyNames.ITERATION_DESCRIPTION);
        Iteration iteration = new Iteration(iterationName, iterationDesc);
        if (Action.Create == action) { // TODO  better to use switch if fisible
            // Do nothing already new iteration with name and description is created
            History history = new History();
            history.addInfo(new PastInformation("New iteration created with name " + iterationName + " Description " + iterationDesc, loggedInUser));
            iteration.setHistory(history);
            session.save(history);
        } else if (Action.Update == action) {
            iteration = (Iteration) session.load(Iteration.class, Long.parseLong(itertionIdString));
            iteration.setName(iterationName);
            iteration.setDescription(iterationDesc);
            iteration.getHistory().addInfo(new PastInformation("New iteration created with name " + iterationName + " Description " + iterationDesc, loggedInUser));
            
        } else {
            throw new IllegalStateException("No other action are support this time ... need to cross check !!!!");
        }
        String authorIdString = request.getParameter(PropertyNames.USER_ID);
        String projectIdString = request.getParameter(PropertyNames.PROJECT_ID);
        String strartDateString = request.getParameter(PropertyNames.ITERATION_START_DATE);
        String endDateString = request.getParameter(PropertyNames.ITERATION_END_DATE);
        
        Author author = (Author) session.load(Author.class, Long.parseLong(authorIdString));
        Project project = (Project) session.load(Project.class, Long.parseLong(projectIdString));
        SimpleDateFormat formatter = new SimpleDateFormat(Constants.DATE_FORMAT);
        
        try {
            Date startDate = formatter.parse(strartDateString);
            Date endDate = formatter.parse(endDateString);
            iteration.setStartDate(startDate);
            iteration.setEndDate(endDate);
        } catch (ParseException e) {
            throw new IllegalStateException("Both start and end date should be in correct format ");
        }
        
        iteration.setAuthor(author);
        iteration.setProject(project);
        
        session.save(iteration);
        ConnectionProvider.closeSessionAndDissconnect(session);
        response.sendRedirect("helper\\SuccessMessageAndCoseWithReloadParent.jsp");
        logger.info(action + " completed successuflly");
    }

}
