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
import com.sb.pojo.PastInformation;
import com.sb.pojo.Task;
import com.sb.pojo.UserStory;

/**
 * Servlet implementation class CreateNewTaskServlet
 */
@WebServlet("/manageTask")
public class ManageTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MessageLogger logger = new MessageLogger(getClass());
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManageTaskServlet() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        logger.info("START. Do get started to create a new task");
        String usId = request.getParameter(PropertyNames.USERSTORY_ID);
        String userId = request.getParameter(PropertyNames.USER_ID);
        String estimateString = request.getParameter(PropertyNames.TASK_ESTIMATE);
        String actualString = request.getParameter(PropertyNames.TASK_ACTUAL);
        String todoString = request.getParameter(PropertyNames.TASK_TODO);
        String priorityString = request.getParameter(PropertyNames.TASK_PRIORITY);
        String progressStatusString = request.getParameter(PropertyNames.TASK_STATUS);
        String userAction = request.getParameter(PropertyNames.USER_ACTION);
        String taskIdString = request.getParameter(PropertyNames.TASK_ID);
        logger.info("1. Request parameter retrieved successfully");
        
        if (userAction == null) {
            throw new IllegalStateException("Property name " + PropertyNames.USER_ACTION + " can not be null here");
        }
        
        Session sessionDB = ConnectionProvider.openSession();
        Action action = Action.valueOf(userAction);
        if (action == null) {
            throw new UnsupportedOperationException("Called for an unsupported type of " + userAction);
        }
        Author loggedInUser = (Author) request.getSession(true).getAttribute(PropertyNames.USER);
        if (loggedInUser == null) {
            throw new IllegalStateException(
                    "Something is missing to initilize the loogged in user in session scope. Please check and fix :)");
        }
        
        if (Action.Delete == action) {
            Object taskObj = sessionDB.load(Task.class, Long.parseLong(taskIdString) );
            Task task = (Task) taskObj;
            logger.info("1.5 Task found to be deleted here");
            
            task.getUserStory().getHistory().addInfo(new PastInformation("Task Deleted with Name " + task.getName() + " Description :" + task.getDescription(), loggedInUser));
            sessionDB.delete(taskObj);
            response.sendRedirect("helper\\SuccessMessageAndCoseWithReloadParent.jsp");
            ConnectionProvider.closeSessionAndDissconnect(sessionDB);
            return;
        }
        // If not delete can be create new or save as action
        Author author = (Author) sessionDB.load(Author.class, Long.parseLong(userId));
        UserStory userStory = (UserStory) sessionDB.load(UserStory.class, Long.parseLong(usId));
        logger.info("2. Author and User story retrieved successfully" + author + ", " + userStory);
        String taskName = request.getParameter(PropertyNames.TASK_NAME);
        String taskDesc = request.getParameter(PropertyNames.TASK_DESCRIPTION);
        Task task = null;
        if (Action.Create == action) {
            logger.info("1.6 Create new task action");
            // already initialized above line = new Task(taskName, taskDesc);
            task = new Task(taskName, taskDesc);
            History history = new History();
            history.addInfo(new PastInformation("New TASK created with name " + task.getName() + " Task Description " + task.getDescription(), loggedInUser));
            task.setHistory(history);
            sessionDB.save(history);
        } else if (Action.Update == action) {
            logger.info("1.7 Create new task action");
            task = (Task) sessionDB.load(Task.class, Long.parseLong(taskIdString));
            task.setName(taskName);
            task.setDescription(taskDesc);
            task.getHistory().addInfo(new PastInformation("New TASK updated with name " + task.getName() + " Task Description " + task.getDescription(), loggedInUser));
        }
        task.setAuthor(author);
        task.setUserStory(userStory);
        task.setActual(Float.parseFloat(actualString));
        task.setRemaining(Float.parseFloat(todoString));
        task.setTaskEstimate(Float.parseFloat(estimateString));
        task.setPriority(Byte.parseByte(priorityString));
        task.setStatus(Byte.parseByte(progressStatusString));
        
        sessionDB.save(task);
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
