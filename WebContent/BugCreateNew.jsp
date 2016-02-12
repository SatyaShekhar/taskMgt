<%@page import="com.sb.db.helper.HqlQueryHelper"%>
<%@page import="com.sb.constants.BugStatus"%>
<%@page import="com.sb.constants.Severity"%>
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
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" session="true"
    errorPage="user\InvalidUserLogin.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create new bug</title>
<link rel="icon" type="image/png" href="images\icons\common-bug.png">
</head>
<body>
    <%
        MessageLogger logger = new MessageLogger(getClass());

        Author user = (Author) session.getAttribute(PropertyNames.USER);
        if (user == null) {
            session.setAttribute(PropertyNames.INVALID_USER_ERROR_MESSAGE, "You have to login first to access your page");
            response.sendRedirect("index.jsp");
            return;
        }
        // TODO this implementation needs confirmation
        // TODO adding to above line ... if user try to create bug with same name it should throw exception
        String message = (String) session.getAttribute(PropertyNames.BUG_ALREADY_EXISTS);
        if (message != null) {
            session.removeAttribute(PropertyNames.BUG_ALREADY_EXISTS);
        }
    %>
    <form action="manageBug">
        <%
            String userStoryId = request.getParameter(PropertyNames.USERSTORY_ID);
            Author loggedInUser = (Author) session.getAttribute(PropertyNames.USER);
            if (userStoryId == null || loggedInUser == null) {
                logger.info("Strange userStory = " + userStoryId + " loggedInUser = " + loggedInUser);
        %>
        <jsp:include page="user/InvalidUserLogin.jsp"></jsp:include>
        <%
            return;
            }
            Session dbSession = ConnectionProvider.openSession();
            UserStory userStory = (UserStory) dbSession.load(UserStory.class, Long.valueOf(userStoryId));
            List<Author> users = HqlQueryHelper.getAuthors(dbSession, user.getOrganization().getId());
            logger.info("User story and authors name retrieved");
        %>
        <table> 
            <tr>
                <td colspan="2" align="center"><b>Create New </b> <img alt="Bug" title="Bug" src="images\icons\common-bug.png"></td>
            <tr>
                <td>Name</td>
                <td><input type="text" name="<%=PropertyNames.BUG_NAME%>" size="60" placeholder="Enter bug title here"></td>
            </tr>
            <tr>
                <td valign="top">Description</td>
                <td><textarea rows="8" cols="60" name="<%=PropertyNames.BUG_DESCRIPTION%>" placeholder="Enter bug description"></textarea>
                </td>
            </tr>
            <tr>
                <td>Submitter</td>
                <td><select name="<%=PropertyNames.BUG_SUBMITTER_ID%>">
                        <%
                            String currentUserName = user.getAuthorName();
                            logger.info("Current author name retrieved " + currentUserName);
                            for (Object userObj : users) {
                                Author author = (Author) userObj;
                                System.out.print("author " + author.getAuthorId() + " , name = " + author.getAuthorName());
                                if (author.getAuthorName().equals(currentUserName)) {
                        %>
                        <option selected="selected" value="<%=author.getAuthorId()%>"><%=author.getAuthorName()%></option>
                        <%
                            break;
                                } else {
                                    continue;
                                }
                            }
                        %>
                </select></td>
            </tr>
            <tr>
                <td>Engineer</td>
                <td><select name="<%=PropertyNames.BUG_ENGINEER_ID%>">
                        <%
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
                <td><select name="<%=PropertyNames.BUG_PRIORITY%>">
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
                <td>Severity</td>
                <td><select name="<%=PropertyNames.BUG_SEVERITY%>">
                        <%
                            for (Severity severity : Severity.values()) {
                        %>
                        <option value="<%=severity.getValue()%>"><%=severity.name()%></option>
                        <%
                            }
                        %>
                </select></td>
            </tr>
            <tr>
                <td>Status</td>
                <td><select name="<%=PropertyNames.BUG_STATUS%>">
                        <%
                            for (BugStatus status : BugStatus.values()) {
                        %>
                        <option value="<%=status.getValue()%>"><%=status.name()%></option>
                        <%
                            }
                        %>
                </select></td>
            </tr>
            <tr>
                <td>User Story</td>
                <td title="Only display the selected US">
                <select name="<%=PropertyNames.USERSTORY_ID%>">
                        <option value="<%=userStory.getUserstoryId()%>"><%=userStory.getName()%></option>
                </select></td>
            </tr>
            <tr>
                <td>Planned</td>
                <td><input type="text" name="<%=PropertyNames.BUG_ESTIMATE%>" size="3" value="0.0" /> days</td>
            </tr>
            <tr>
                <td>Actual</td>
                <td><input type="text" name="<%=PropertyNames.BUG_ACTUAL%>" size="3" value="0.0" /> days</td>
            </tr>
            <tr>
                <td>Remaining</td>
                <td><input type="text" name="<%=PropertyNames.BUG_TODO%>" size="3" value="0.0" /> days</td>
            </tr>
            <tr>
                <td colspan="2" align="center"><input type="button" value="Cancel" onclick="window.close();" /> <input type="submit"
                    name="<%=PropertyNames.USER_ACTION%>" value="<%=Action.Create%>" /></td>
            </tr>
        </table>
    </form>
    <%
    ConnectionProvider.closeSessionAndDissconnect(dbSession);
    %>
</body>
</html>
