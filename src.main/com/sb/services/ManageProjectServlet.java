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
import com.sb.pojo.Project;

/**
 * Servlet implementation class ManageProjectServlet
 */
@WebServlet("/manageProject")
public class ManageProjectServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static MessageLogger logger = new MessageLogger(ManageProjectServlet.class);

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManageProjectServlet() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        logger.info("Do get started for managing project ....");
        String userAction = request.getParameter(PropertyNames.USER_ACTION);
        Action action = Action.valueOf(userAction);
        if (action == null) {
            throw new IllegalStateException("User action can not be null here !!!!");
        }
        String projectIdString = request.getParameter(PropertyNames.PROJECT_ID);
        Session sessionDB = ConnectionProvider.openSession();

        Author loggedInUser = (Author) request.getSession(true).getAttribute(PropertyNames.USER);
        System.out.println("User id is " + request.getSession(true).getAttribute(PropertyNames.USER_NAME));
        if (loggedInUser == null) {
            throw new IllegalStateException(
                    "Something is missing to initilize the loogged in user in session scope. Please check and fix :)");
        }

        if (Action.Delete == action) {
            if (projectIdString == null) {
                throw new IllegalStateException("Project Id can not be null here.");
            }
            Project project = (Project) sessionDB.load(Project.class, Long.parseLong(projectIdString));
            /*TODO this is to be done when there will be separate admin page to create the organization and user with one admin user created at run time
             *loggedInUser.getHistory().addInfo(new PastInformation("Deleted the project " + project.getProjectName() + " Description " + project.getProjectDescription(), loggedInUser));
             **/
            sessionDB.delete(project);
            response.sendRedirect("helper\\SuccessMessageAndCoseWithReloadParent.jsp");
            ConnectionProvider.closeSessionAndDissconnect(sessionDB);
            return;
        }
        String userId = request.getParameter(PropertyNames.USER_ID);
        String projectName = request.getParameter(PropertyNames.PROJECT_NAME);
        String projectDescription = request.getParameter(PropertyNames.PROJECT_DESCRIPTION);

        Author author = (Author) sessionDB.load(Author.class, Long.parseLong(userId));
        logger.info("2. Author and Project details retrieved successfully" + author + ", " + projectName + " " + projectDescription);

        Project project = new Project(projectName, projectDescription);
        if (Action.Create == action) {
            logger.info("1.6 Create new Project action");
            // already initialized above line
            History history = new History();
            history.addInfo(new PastInformation(
                    "New Project created with name " + project.getProjectName() + "\n Description " + project.getProjectDescription(),
                    loggedInUser));
            project.setHistory(history);
            sessionDB.save(history);
        } else if (Action.Update == action) {
            logger.info("1.7 Update project action");
            project = (Project) sessionDB.load(Project.class, Long.parseLong(projectIdString));
            project.setProjectName(projectName);
            project.setProjectDescription(projectDescription);
            project.getHistory().addInfo(new PastInformation("Name " + projectName + "\n Description " + projectDescription, loggedInUser));
        } else if (Action.Duplicate == action) {
            project = (Project) sessionDB.get(Project.class, Long.parseLong(projectIdString));
            try {
                project = (Project) project.clone();
            } catch (CloneNotSupportedException e) {
                throw new IllegalStateException("Duplication action failed to clone the project");
            }
            project.setProjectName(projectName);
            project.setProjectDescription(projectDescription);
            History history = new History();
            history.addInfo(new PastInformation(
                    "New Project created with name " + project.getProjectName() + "\n Description " + project.getProjectDescription(),
                    loggedInUser));
            project.setHistory(history);
            sessionDB.save(history);
        } else {
            throw new IllegalStateException("Action called for invalid action");
        }
        project.setAuthor(author);
        sessionDB.save(project);
        ConnectionProvider.closeSessionAndDissconnect(sessionDB);
        response.sendRedirect("helper\\SuccessMessageAndCoseWithReloadParent.jsp");
        logger.info("All actions completed successfully for managing project ....");
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
    }

}
