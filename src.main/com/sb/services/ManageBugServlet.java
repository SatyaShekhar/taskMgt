package com.sb.services;

import java.io.IOException;
import java.util.Date;

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
import com.sb.pojo.Bug;
import com.sb.pojo.History;
import com.sb.pojo.PastInformation;
import com.sb.pojo.UserStory;

/**
 * Servlet implementation class ManageBugServlet
 */
@WebServlet("/manageBug")
public class ManageBugServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MessageLogger logger = new MessageLogger(getClass());
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManageBugServlet() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        logger.info("START. Do get started for manage bug");
        String usId = request.getParameter(PropertyNames.USERSTORY_ID);
        String engineerId = request.getParameter(PropertyNames.BUG_ENGINEER_ID);
        String submitterId = request.getParameter(PropertyNames.BUG_SUBMITTER_ID);
        String estimateString = request.getParameter(PropertyNames.BUG_ESTIMATE);
        String actualString = request.getParameter(PropertyNames.BUG_ACTUAL);
        String todoString = request.getParameter(PropertyNames.BUG_TODO);
        String priorityString = request.getParameter(PropertyNames.BUG_PRIORITY);
        String bugStatusString = request.getParameter(PropertyNames.BUG_STATUS);
        String severity = request.getParameter(PropertyNames.BUG_SEVERITY);
        logger.info("1. Request parameters retrieved successfully");

        String userAction = request.getParameter(PropertyNames.USER_ACTION);
        String bugIdString = request.getParameter(PropertyNames.BUG_ID);

        if (userAction == null) {
            throw new IllegalStateException("Property name " + PropertyNames.USER_ACTION + " can not be null here");
        }

        Session sessionDB = ConnectionProvider.openSession();
        Action action = Action.valueOf(userAction);
        if (action == null) {
            throw new UnsupportedOperationException("Called for an unsupported type of " + userAction);
        }
        if (Action.Delete == action) {
            Object bugObj = sessionDB.load(Bug.class, Long.parseLong(bugIdString));
            logger.info("1.5 Bug found to be deleted here");
            Bug bug = (Bug) bugObj;
            UserStory userStory = bug.getUserStory();
            Author loggedInUser = (Author) request.getSession().getAttribute(PropertyNames.USER);
            if (loggedInUser == null) {
                throw new IllegalStateException(
                        "Something is missing to initilize the loogged in user in session scope. Please check and fix :)");
            }
            PastInformation info = new PastInformation("Bug(Name:" + bug.getName() + ") deleted by " + loggedInUser.getAuthorName() + " which was created by " + bug.getCreatedBy().getFullName() + "(" + bug.getCreatedBy().getAuthorName() + ")", loggedInUser);
            
            userStory.getHistory().addInfo(info );
            sessionDB.delete(bugObj);
            response.sendRedirect("helper\\SuccessMessageAndCoseWithReloadParent.jsp");
            ConnectionProvider.closeSessionAndDissconnect(sessionDB);
            return;
        }
        Author engineer = (Author) sessionDB.load(Author.class, Long.parseLong(engineerId));
        Author submitter = (Author) sessionDB.load(Author.class, Long.parseLong(submitterId));
        // If not delete can be create new or save as action
        UserStory userStory = (UserStory) sessionDB.load(UserStory.class, Long.parseLong(usId));
        logger.info("2. Author and User story and submitter retrieved successfully" + engineer + ", " + userStory + " Submitter " + submitter);
        String bugName = request.getParameter(PropertyNames.BUG_NAME);
        String bugDesc = request.getParameter(PropertyNames.BUG_DESCRIPTION);
        Bug bug = null;
        if (Action.Create == action) {
            logger.info("1.6 Create new task action");
            bug = new Bug(bugName, bugDesc);

        } else if (Action.Update == action) {
            logger.info("1.7 Create new task action");
            bug = (Bug) sessionDB.load(Bug.class, Long.parseLong(bugIdString));
            bug.setName(bugName);
            bug.setDescription(bugDesc);
        } else {
            throw new IllegalStateException("Invalid action selected may be action (" + action + ") not supported yet");
        }
        
        bug.setEngineer(engineer);
        bug.setCreatedBy(submitter);
        bug.setUserStory(userStory);
        bug.setActual(Float.parseFloat(actualString));
        bug.setRemaining(Float.parseFloat(todoString));
        bug.setEstimate(Float.parseFloat(estimateString));
        bug.setPriority(Byte.parseByte(priorityString));
        bug.setStatus(Byte.parseByte(bugStatusString));
        bug.setSeverity(Byte.valueOf(severity));
        bug.setCreationTime(new Date());
        bug.setComment("");
        History history = null;
        if (action == Action.Update) {
            // History should be present just add new past info
            history = bug.getHistory();
            System.out.println("Old history used for bug with " + bug.getHistory().getInformations().size() + " entries previously.");
        } else {
            history = new History();
            System.out.println("New history created for bug " + bug.getBugId());
        }
        PastInformation info = new PastInformation("Bug Name : " + bug.getName() + " \n Bug Description: " + bug.getDescription(), submitter);
        history.addInfo(info);
        sessionDB.save(info);
        sessionDB.save(history);
        bug.setHistory(history);
        sessionDB.save(bug);
        ConnectionProvider.closeSessionAndDissconnect(sessionDB);
        logger.info("END. Task creation completed successfully");
        response.sendRedirect("helper\\SuccessMessageAndCoseWithReloadParent.jsp");

    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
    }

}
