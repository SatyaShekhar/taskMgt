<%@page import="com.sb.db.helper.HqlQueryHelper"%>
<%@page import="com.sb.constants.Priority"%>
<%@page import="com.sb.constants.Action"%>
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
<title>Create a new user story</title>
</head>
<body>
    <%!MessageLogger logger = new MessageLogger(getClass());%>
    <%
        logger.info("Create newser story called");
        Author author = (Author) session.getAttribute(PropertyNames.USER);
        if (author == null) {
            session.setAttribute(PropertyNames.INVALID_USER_ERROR_MESSAGE, "You have to login first to access your page");
            response.sendRedirect("index.jsp");
            return;
        }
        String message = (String) session.getAttribute(PropertyNames.USERSTORY_ALREADY_EXISTS);
        if (message != null) {
            session.removeAttribute(PropertyNames.USERSTORY_ALREADY_EXISTS);
        }
    %>
    <h1 style="color: red"></h1>
    <form action="manageUserStory">
        <%
            String iterationIdString = request.getParameter(PropertyNames.ITERATION_ID);
            if (iterationIdString == null) {
                logger.error("Iteration id is not expected to be null here");
                return;
            }
            Session dbSession = ConnectionProvider.openSession();
            Iteration iteration = (Iteration) dbSession.get(Iteration.class, Long.parseLong(iterationIdString));
            List<Iteration> iterations = HqlQueryHelper.getIterationsUnderProject(dbSession, iteration.getProject().getProjectId());
            List<Author> users = HqlQueryHelper.getAuthors(dbSession, author.getOrganization().getId());
        %>
        <table>
            <tr>
                <td colspan="2" align="center"><b>Create new user story</b></td>
            <tr>
                <td>Name</td>
                <td><input type="text" size="114" name="<%=PropertyNames.USERSTORY_NAME%>" placeholder="User story name required">
                </td>
            </tr>
            <tr>
                <td valign="top">Description</td>
                <td><textarea rows="20" cols="114" name="<%=PropertyNames.USERSTORY_DESCRIPTION%>" placeholder="User story description"></textarea></td>
            </tr>
            <tr>
                <td>Engineer</td>
                <td><select name="<%=PropertyNames.USER_ID%>">
                        <%
                            for (Author user : users) {
                                if (user.getAuthorName().equals(author.getAuthorName())) {
                        %>
                        <option value="<%=user.getAuthorId()%>" selected="selected"><%=user.getAuthorName()%></option>
                        <%
                            } else {
                        %>
                        <option value="<%=user.getAuthorId()%>"><%=user.getAuthorName()%></option>
                        <%
                            }
                            }
                        %>
                </select></td>
            </tr>
            <tr>
                <td>Estimate</td>
                <td><input type="text" size="4" name="<%=PropertyNames.USERSTORY_PLANESTIMATE%>" value="0"></td>
            </tr>
            <tr>
                <td>Priority</td>
                <td><select name="<%=PropertyNames.USERSTORY_PRIORITY%>">
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
                <td>Iteration</td>
                <td><select name="<%=PropertyNames.ITERATION_ID%>">
                        <%
                            logger.info("Current iteration name " + iteration.getIterationId());
                            for (Iteration itr : iterations) {
                                if (itr.getIterationId() == iteration.getIterationId()) {
                        %>
                        <option value="<%=itr.getIterationId()%>" selected="selected"><%=itr.getName()%></option>
                        <%
                            } else {
                        %>
                        <option value="<%=itr.getIterationId()%>"><%=itr.getName()%></option>
                        <%
                            }
                            }
                        %>
                </select></td>
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
