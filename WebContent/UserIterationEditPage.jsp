<%@page import="com.sb.db.helper.HqlQueryHelper"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.sb.pojo.Iteration"%>
<%@page import="com.sb.constants.Constants"%>
<%@page import="com.sb.pojo.Project"%>
<%@page import="com.sb.pojo.Author"%>
<%@page import="java.util.List"%>
<%@page import="com.sb.db.helper.ConnectionProvider"%>
<%@page import="org.hibernate.Session"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.sb.constants.Action"%>
<%@page import="com.sb.constants.PropertyNames"%>
<%@page import="com.sb.message.log.MessageLogger"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" session="true" pageEncoding="ISO-8859-1" errorPage=""%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create a new iteration</title>
<link rel="icon" 
      type="image/png" 
      href="images\general\drop.png">
</head>
<body>
    <%!MessageLogger logger = new MessageLogger(getClass());
    SimpleDateFormat dateFormat = new SimpleDateFormat(Constants.DATE_FORMAT);%>
    <%
        Author user = (Author) session.getAttribute(PropertyNames.USER);
        if (user == null) {
            session.setAttribute(PropertyNames.INVALID_USER_ERROR_MESSAGE, "You have to login first to access any home page");
            response.sendRedirect("index.jsp");
            return;
        }
        Session sessionDB = ConnectionProvider.openSession();
        String iterationIdString = request.getParameter(PropertyNames.ITERATION_ID);
        if (iterationIdString == null) {
            throw new IllegalStateException("Iteration id cannot be null here");
        }
        Iteration iteration = (Iteration) sessionDB.get(Iteration.class, Long.parseLong(iterationIdString));
    %>
    <form action="manageIteration" method="post">
        <input type="hidden" name="<%=PropertyNames.ITERATION_ID%>" value="<%=iteration.getIterationId()%>">
        <table >
            <tr>
                <td colspan="2" align="center"><b>Update Iteration</b></td>
            <tr>
                <td>ITR <%=iteration.getIterationId()%></td>
                <td><input type="text" size="114" name="<%=PropertyNames.ITERATION_NAME%>" value="<%=iteration.getName()%>"
                    placeholder="Iteration name required"></td>
            </tr>
            <tr>
                <td valign="top">Description</td>
                <td><textarea rows="20" cols="114" name="<%=PropertyNames.ITERATION_DESCRIPTION%>" placeholder="Iteration description"><%=iteration.getDescription()%></textarea></td>
            </tr>
            <tr>
                <td>Start Date</td>
                <td><input type="text" size="10" value="<%=dateFormat.format(iteration.getStartDate())%>"
                    name="<%=PropertyNames.ITERATION_START_DATE%>" placeholder="<%=Constants.DATE_FORMAT%>"></td>
            </tr>
            <tr>
                <td>End Date</td>
                <td><input type="text" size="10" value="<%=dateFormat.format(iteration.getEndDate())%>"
                    name="<%=PropertyNames.ITERATION_END_DATE%>" placeholder="<%=Constants.DATE_FORMAT%>"></td>
            </tr>
            <tr>
                <td>Engineer</td>
                <td><select name="<%=PropertyNames.USER_ID%>">
                        <%
                            String currentUserName = (String) iteration.getAuthor().getAuthorName();
                            logger.info("Current selected author name is " + currentUserName);
                            List<Author> users = HqlQueryHelper.getAuthors(sessionDB, user.getOrganization().getId());
                            for (Author author : users) {
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
                <td>Project</td>
                <td><select name="<%=PropertyNames.PROJECT_ID%>">
                        <%
                            List<Project> projects = HqlQueryHelper.getProjects(sessionDB, user.getOrganization().getId()) ;
                            long currentProjectId = iteration.getProject().getProjectId();
                            for (Project project : projects) {
                                if (project.getProjectId() == currentProjectId) {
                        %>
                        <option value="<%=project.getProjectId()%>" selected="selected"><%=project.getProjectName()%></option>
                        <%
                            } else {
                        %>
                        <option value="<%=project.getProjectId()%>"><%=project.getProjectName()%></option>
                        <%
                            }
                            }
                        %>
                </select></td>
            </tr>
            <tr>
                <td colspan="2" align="center"><input type="button" value="Cancel" onclick="window.close();" /> <input type="submit"
                    name="<%=PropertyNames.USER_ACTION%>" value="<%=Action.Update%>" /></td>
            </tr>
        </table>
    </form>
    <%
        ConnectionProvider.closeSessionAndDissconnect(sessionDB);
    %>
</body>
</html>