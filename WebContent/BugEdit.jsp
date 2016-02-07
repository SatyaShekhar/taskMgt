<%@page import="com.sb.constants.BugStatus"%>
<%@page import="com.sb.constants.Severity"%>
<%@page import="com.sb.constants.ProgressStatus"%>
<%@page import="com.sb.constants.Status"%>
<%@page import="com.sb.pojo.Bug"%>
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
<title>Edit this Bug</title>
<link rel="icon" 
      type="image/png" 
      href="images\icons\common-bug.png">
</head>
<body>
    <%! MessageLogger logger = new MessageLogger(getClass()); %>
    <form action="manageBug">
        <%
            String bugId = request.getParameter(PropertyNames.BUG_ID);
            logger.info("Update bug of id " + bugId);
            if (bugId == null) {
                logger.info("Strange bug id is null here !!!!");
                return;
            }
            Session dbSession = ConnectionProvider.openSession();
            Bug bug = (Bug) dbSession.get(Bug.class, Long.parseLong(bugId));
            if (bug == null) {
                throw new IllegalStateException("Bug can not be null here for ID : " + bugId);
            }
            List<Author> users = dbSession.createQuery("from Author").list();
            List<UserStory> userStories = dbSession.createQuery("from UserStory where iteration.iterationId ='" + bug.getUserStory().getIteration().getIterationId() + "'").list();
            logger.info("Bug id and author name retrieved");
        %>
        <input type="hidden" name="<%=PropertyNames.BUG_ID%>" value="<%=bugId%>">
           <table align="left">
        <tr><td colspan="2" align="center"><b>Change the following bug details</b></td>
    
      <tr><td>BUG (<%=bug.getBugId()%>) </td><td><input type="text" name="<%=PropertyNames.BUG_NAME%>" value="<%=bug.getName()%>" size="60" placeholder="Edit bug title here"> </td></tr>
      <tr><td valign="top">Description </td><td> <textarea rows="8" cols="60" name="<%=PropertyNames.BUG_DESCRIPTION%>" placeholder="Edit bug description here"><%=bug.getDescription()%></textarea> </td></tr>
       
       
        <tr><td>Submitter</td> <td>
                <select name="<%=PropertyNames.BUG_SUBMITTER_ID%>" >
                    <option value="<%=bug.getCreatedBy().getAuthorId()%>" selected="selected"><%=bug.getCreatedBy().getAuthorName()%></option>
                </select>
            </td>
        </tr>

        <tr><td>Engineer</td>
            <td>
                <select name="<%=PropertyNames.BUG_ENGINEER_ID%>">
                    <%
                        long currentUserId = bug.getEngineer().getAuthorId();
                                    logger.info("Current author id retrieved " + currentUserId);
                                    for (Object userObj : users) {
                                        Author author = (Author) userObj;
                                        if (author.getAuthorId() == bug.getEngineer().getAuthorId()) {
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
        <tr><td>Priority</td>
            <td>
             <select name="<%=PropertyNames.BUG_PRIORITY%>">
                <%
                    Priority bugPriority = Priority.valueOf(bug.getPriority()) ;
                        for(Priority priority : Priority.values()) {
                            if (bugPriority == priority) {
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
        <tr><td>Severity</td>
            <td>
             <select name="<%=PropertyNames.BUG_SEVERITY%>">
                        <%
                            for (Severity severity : Severity.values()) {
                                if (severity.getValue() == bug.getSeverity()) {
                        %>
                        <option value="<%=severity.getValue()%>" selected="selected"><%=severity.name()%></option>
                        <%
                            } else {
                        %>
                        <option value="<%=severity.getValue()%>"><%=severity.name()%></option>
                        <%
                            }
                            }
                        %>
                </select>
                </td>
          </tr>
            <tr>
                <td>Status</td>
                <td><select name="<%=PropertyNames.BUG_STATUS%>">
                        <%
                            BugStatus bugStatus = BugStatus.valueOf(bug.getStatus());
                            for (BugStatus status : BugStatus.values()) {
                                if (bugStatus == status) {
                        %>
                        <option value="<%=status.getValue()%>" selected="selected"><%=status.name()%></option>
                        <%
                            } else {
                        %>
                        <option value="<%=status.getValue()%>"><%=status.name()%></option>
                        <%
                            }
                            }
                        %>
                </select></td>
            </tr>
            <tr><td>User Story</td>
            <td>
              <select name="<%=PropertyNames.USERSTORY_ID%>">
                <%
                    UserStory bugUserStory = bug.getUserStory();
                        long userStoryId = bugUserStory.getUserstoryId();
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
        <tr><td>Planned</td><td><input type="text" name="<%=PropertyNames.BUG_ESTIMATE%>" size="3" value="<%=bug.getEstimate()%>"/> </td></tr>
        <tr><td>Actual</td><td><input type="text" name="<%=PropertyNames.BUG_ACTUAL%>" size="3" value="<%=bug.getActual()%>"/> </td></tr>
        <tr><td>Remaining</td><td><input type="text" name="<%=PropertyNames.BUG_TODO%>" size="3" value="<%=bug.getRemaining()%>"/> </td></tr>
         
        <tr><td colspan="2" align="center">
             <input type="button" value="Cancel" onclick="window.close();"/>
            <input type="submit" name="<%=PropertyNames.USER_ACTION%>" value="<%=Action.Update%>" />
        </td></tr>
    </table>
    </form>
    
    <%
    ConnectionProvider.closeSessionAndDissconnect(dbSession);
    %>
</body>
</html> 