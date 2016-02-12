<%@page import="com.sb.db.helper.HqlQueryHelper"%>
<%@page import="com.sb.constants.Action"%>
<%@page import="com.sb.pojo.Author"%>
<%@page import="java.util.List"%>
<%@page import="com.sb.db.helper.ConnectionProvider"%>
<%@page import="org.hibernate.Session"%>
<%@page import="com.sb.message.log.MessageLogger"%>
<%@page import="com.sb.constants.PropertyNames"%>
<%@page import="java.util.HashSet"%>
<%@page import="com.sb.pojo.Project"%>
<%@page import="java.util.Set"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" session="true"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create a new project</title>
</head>
<body>
<%! MessageLogger logger = new MessageLogger(getClass()); %>
<%
    Author author = (Author) session.getAttribute(PropertyNames.USER);
    if (author == null) {
        session.setAttribute(PropertyNames.INVALID_USER_ERROR_MESSAGE, "You have to login first to access project edit page");
        response.sendRedirect("index.jsp");
        return;
    }
    Session sessionDB = ConnectionProvider.openSession();
    String projectId = request.getParameter(PropertyNames.PROJECT_ID);
    logger.info("ProjectId = " + Long.parseLong(projectId));
    Project project = (Project) sessionDB.get(Project.class, Long.parseLong(projectId));
%>
<form action="manageProject">
<input type="hidden" name="<%=PropertyNames.PROJECT_ID%>" value="<%=projectId%>">
<table>
    <tr><td colspan="2" align="center"><b>Update project</b></td>
    <tr><td>Name</td><td><input type="text" size="114" name="<%=PropertyNames.PROJECT_NAME%>" value="<%=project.getProjectName()%>"> </td></tr>
    <tr><td valign="top">Description </td>
    <td>
    <textarea rows="20" cols="114" name="<%=PropertyNames.PROJECT_DESCRIPTION%>" placeholder="Project description"><%=project.getProjectDescription()%></textarea>
    </td></tr>
    <tr><td>Engineer</td><td>
     <select name="<%=PropertyNames.USER_ID%>">
            <%
                String currentUserName = author.getAuthorName();
                logger.info("Current author name retrieved " + currentUserName);
                List<Author> users = HqlQueryHelper.getAuthors(sessionDB, author.getOrganization().getId());
                for (Author user : users) {
                    if (user.getAuthorName().equals(currentUserName)) {
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
        </select>
    </td></tr>
    <tr><td colspan="2" align="center">
        <input type="button" value="Cancel" onclick="window.close();"/>
        <input type="submit" name="<%=PropertyNames.USER_ACTION%>" value="<%=Action.Update%>" />
    </td></tr>
</table>
</form>
 <%
    ConnectionProvider.closeSessionAndDissconnect(sessionDB);
    %>
</body>
</html>