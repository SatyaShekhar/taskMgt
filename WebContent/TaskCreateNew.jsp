<%@page import="com.sb.db.helper.HqlQueryHelper"%>
<%@page import="com.sb.constants.ProgressStatus"%>
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
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" src="angular.min.js"></script>
<title>Create new task</title>
<link rel="icon" 
      type="image/png" 
      href="images\icons\task.jpg">

<style>
input.ng-invalid, textarea.ng-invalid {
    border-color:red;
}
input.ng-valid {
    border-color:white;
}
textarea.ng-invalid {
    border-color:red;
}
textarea.ng-valid {
    border-color:white;
}
</style>

</head>
<body ng-app="">
    <%
    MessageLogger logger = new MessageLogger(getClass());
        String message = (String) session.getAttribute(PropertyNames.TASK_ALREADY_EXISTS); 
        if (message != null) {
            session.removeAttribute(PropertyNames.TASK_ALREADY_EXISTS);
        }
    %>
    <form action="manageTask" name="manageTask" novalidate="novalidate">
        <%
            logger.info("CreateNew task jps started");
            String userStoryId = request.getParameter(PropertyNames.USERSTORY_ID);
            if (userStoryId == null) {
                return;
            }
            Session dbSession = ConnectionProvider.openSession();
            UserStory userStory = (UserStory) dbSession.load(UserStory.class, Long.valueOf(userStoryId));
            List<Author> users = HqlQueryHelper.getAuthors(dbSession);
            logger.info("User story and authors name retrieved");
        %>
            <table>
                <tr>
                    <td colspan="2" align="center"><b>Create new task</b></td>
                <tr>
                    <td>Name</td>
                    <td><input type="text" ng-model="name" required name="<%=PropertyNames.TASK_NAME%>" size="60" placeholder="Task name required">
                    </td>
                </tr>
                <tr>
                    <td valign="top">Description</td>
                    <td><textarea rows="8" cols="60" name="<%=PropertyNames.TASK_DESCRIPTION%>"
                            placeholder="Enter a task description here" required></textarea></td>
                </tr>
                <tr>
                    <td>Engineer</td>
                    <td><select name="<%=PropertyNames.USER_ID%>">
                            <%
                                String currentUserName = (String) session.getAttribute(PropertyNames.USER_NAME);
                                logger.info("Current author name retrieved " + currentUserName);
                                for (Object userObj : users) {
                                    Author author = (Author) userObj;
                                    if (author.getAuthorName().equals(currentUserName)) {
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
                    </select></td>
                </tr>
                <tr>
                    <td>Priority</td>
                    <td><select name="<%=PropertyNames.TASK_PRIORITY%>">
                            <%
                                for (Priority priority : Priority.values()) {
                            %>
                            <option value="<%=priority.getValue()%>"><%=priority.name()%></option>
                            <%
                                }
                            %>
                    </select></td>
                </tr>
                <tr>
                    <td>Status</td>
                    <td><select name="<%=PropertyNames.TASK_STATUS%>">
                            <%
                                for (ProgressStatus pStatus : ProgressStatus.values()) {
                            %>
                            <option value="<%=pStatus.getValue()%>"><%=pStatus.name()%></option>
                            <%
                                }
                            %>
                    </select></td>
                </tr>
                <tr>
                    <td>User Story</td>
                    <td><select name="<%=PropertyNames.USERSTORY_ID%>">
                            <option value="<%=userStory.getUserstoryId()%>"><%=userStory.getName()%></option>
                    </select></td>
                </tr>
                <tr>
                    <td>Estimate</td>
                    <td><input type="text" name="<%=PropertyNames.TASK_ESTIMATE%>" size="3" value="0.0" /> Days</td>
                </tr>
                <tr>
                    <td>Actual</td>
                    <td><input type="text" name="<%=PropertyNames.TASK_ACTUAL%>" size="3" value="0.0" /> Days</td>
                </tr>
                <tr>
                    <td>Remaining</td>
                    <td><input type="text" name="<%=PropertyNames.TASK_TODO%>" size="3" value="0.0" /> Days</td>
                </tr>
                <tr>
                    <td colspan="2" align="center"><input type="button" value="Cancel" onclick="window.close();" /> <input
                        type="submit" name="<%=PropertyNames.USER_ACTION%>" value="<%=Action.Create%>" /></td>
                </tr>
            </table>
        </div>
    </form>

    <%
    ConnectionProvider.closeSessionAndDissconnect(dbSession);
    %>
</body>
</html> 