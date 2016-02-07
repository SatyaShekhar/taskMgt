<%@page import="com.sb.constants.ProgressStatus"%>
<%@page import="com.sb.constants.Status"%>
<%@page import="com.sb.pojo.Task"%>
<%@page import="com.sb.services.ManageTaskServlet"%>
<%@page import="com.sb.constants.Action"%>
<%@page import="com.sb.constants.Priority"%>
<%@page import="com.sb.message.log.MessageLogger"%>
<%@page import="com.sb.pojo.Iteration"%>
<%@page import="com.sb.pojo.Author"%>
<%@page import="java.util.List"%>
<%@page import="com.sb.pojo.UserStory"%>
<%@page import="com.sb.db.helper.ConnectionProvider"%>
<%@page import="org.hibernate.Session"%>
<%@page import="com.sb.constants.PropertyNames"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" session="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit this Task</title>
<link rel="icon" 
      type="image/png" 
      href="images\icons\task.jpg">
</head>
<body>
    <%! MessageLogger logger = new MessageLogger(getClass()); %>
    <%
       /* TODO validation check needs to be adopted here String message = (String) session.getAttribute(PropertyNames.TASK_ALREADY_EXISTS); 
        if (message != null) {
            session.removeAttribute(PropertyNames.TASK_ALREADY_EXISTS);
        } */
    %>
    <form action="manageTask">
        <%
            String taskId = request.getParameter(PropertyNames.TASK_ID);
            logger.info("Update task for task" + taskId);
            if (taskId == null) {
                logger.info("Strance task id is null here !!!!");
                return;
            }
            Session dbSession = ConnectionProvider.openSession();
            Task task = (Task) dbSession.get(Task.class, Long.parseLong(taskId));
            if (task == null) {
                throw new IllegalStateException("Task can not be null here for ID : " + taskId);
            }
            List<Author> users = dbSession.createQuery("from Author").list();
            List<UserStory> userStories = dbSession.createQuery("from UserStory where iteration.iterationId ='" + task.getUserStory().getIteration().getIterationId() + "'").list();
            logger.info("Task id and author name name retrieved");
        %>
        <input type="hidden" name="<%=PropertyNames.TASK_ID%>" value="<%=taskId%>">
           <table align="left">
        <tr><td colspan="2" align="center"><b>Update task</b></td>
    
      <tr><td bgcolor="#E6E6E6">TA <%=PropertyNames.TASK_ID%> </td><td><input type="text" name="<%=PropertyNames.TASK_NAME%>" value="<%=task.getName()%>" size="60" placeholder="Enter a task title here"> </td></tr>
      <tr><td bgcolor="#E6E6E6">Task Description :  </td><td> <textarea rows="8" cols="60" name="<%=PropertyNames.TASK_DESCRIPTION%>" placeholder="Enter a task description here"><%=task.getDescription()%></textarea> </td></tr>
       
       
        <tr><td bgcolor="#E6E6E6">Engineer :</td>
            <td>
                <select name="<%=PropertyNames.USER_ID%>">
                    <%
                        long currentUserId = task.getAuthor().getAuthorId();
                                    logger.info("Current author id retrieved " + currentUserId);
                                    for (Object userObj : users) {
                                        Author author = (Author) userObj;
                                        if (author.getAuthorId() == currentUserId) {
                    %>
                    <option value="<%=author.getAuthorId()%>" selected="selected"><%=author.getAuthorName()%></option>
                    <%
                        } else {
                    %>
                    <option value="<%=author.getAuthorId()%>"><%=author.getAuthorName()%></option>
                    <%
                        }
                                    }
                    %>
                </select>
            </td></tr>
        
        
        <tr><td bgcolor="#E6E6E6">Priority : </td>
            <td>
             <select name="<%=PropertyNames.TASK_PRIORITY%>">
                <%
                    Priority taskPriority = Priority.valueOf(task.getPriority()) ;
                        for(Priority priority : Priority.values()) {
                            if (taskPriority == priority) {
                %>
                <option value="<%=priority.getValue()%>" selected="selected"><%=priority.name()%></option>
                <%
                    }
                            else {
                %>
                        <option value="<%=priority.getValue()%>"><%=priority.name()%></option>
                        <%
                            }
                                }
                        %>
                </select>
            </td></tr>
        <tr><td bgcolor="#E6E6E6">Status : </td>
            <td>
             <select name="<%=PropertyNames.TASK_STATUS%>">
                <%
                    ProgressStatus taskstatus = ProgressStatus.valueOf(task.getStatus());
                        for(ProgressStatus pStatus : ProgressStatus.values()) {
                            if (taskstatus == pStatus) {
                %>
                <option value="<%=pStatus.getValue()%>" selected="selected" ><%=pStatus.name()%></option>
                <%
                    } else {
                %>
                        <option value="<%=pStatus.getValue()%>" ><%=pStatus.name()%></option>
                        <%
                            }
                                    }
                        %>
                </select>
            </td></tr>
            
        <tr><td bgcolor="#E6E6E6">User Story : </td>
            <td>
              <select name="<%=PropertyNames.USERSTORY_ID%>">
                <%
                    UserStory taskUserStory = task.getUserStory();
                        long userStoryId = taskUserStory.getUserstoryId();
                        // Filter all user sotries comming under same iteration, movement of task accorss iteration is not allowed
                        for(UserStory userStory : userStories) {
                            if (userStory.getUserstoryId() == userStoryId) {
                %>
                        <option value="<%=userStory.getUserstoryId()%>" selected="selected"><%=userStory.getName()%></option>
                        <%
                    } else {
                %>
                <option value="<%=userStory.getUserstoryId()%>"><%=userStory.getName()%></option>
                <% }
                } %>
            </select>
            </td></tr>
        <tr><td bgcolor="#E6E6E6">Task Estimate : </td><td><input type="text" name="<%=PropertyNames.TASK_ESTIMATE%>" size="3" value="<%=task.getTaskEstimate()%>"/> </td></tr>
        <tr><td bgcolor="#E6E6E6">Actual : </td><td><input type="text" name="<%=PropertyNames.TASK_ACTUAL%>" size="3" value="<%=task.getActual()%>"/> </td></tr>
        <tr><td bgcolor="#E6E6E6">Todo  : </td><td><input type="text" name="<%=PropertyNames.TASK_TODO%>" size="3" value="<%=task.getRemaining()%>"/> </td></tr>
         
        <tr><td colspan="2" align="center">
             <input type="button" value="cancel" onclick="window.close();"/>
            <input type="submit" name="<%=PropertyNames.USER_ACTION%>" value="<%=Action.Update%>" />
        </td></tr>
    </table>
    </form>
    
    <%
    ConnectionProvider.closeSessionAndDissconnect(dbSession);
    %>
</body>
</html> 