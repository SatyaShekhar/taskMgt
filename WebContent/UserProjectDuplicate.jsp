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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Duplicate project</title>
</head>
<body>
<%! MessageLogger logger = new MessageLogger(getClass()); %>
<%
    String userName = (String) session.getAttribute(PropertyNames.USER_NAME);
    if (userName == null) {
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
<table align="left">
    <tr><td colspan="2" align="center"><b>Duplicate Project : All iterations and tasks under this project will be  copied to the new project (except bugs)</b></td>
    <tr><td bgcolor="#E6E6E6">Project Name : </td><td><input type="text" size="150" name="<%=PropertyNames.PROJECT_NAME%>" value="<%="Copy of >> "+ project.getProjectName()%>"> </td></tr>
    <tr><td bgcolor="#E6E6E6">Engineer</td><td>
     <select name="<%=PropertyNames.USER_ID%>">
            <%
                String currentUserName = (String) session.getAttribute(PropertyNames.USER_NAME);
                logger.info("Current author name retrieved " + currentUserName);
                List<Author> users = sessionDB.createQuery("from Author").list();
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
    <tr bgcolor="#E6E6E6"><td>Project description </td>
    <td>
    <textarea rows="20" cols="114" name="<%=PropertyNames.PROJECT_DESCRIPTION%>" placeholder="Project description"><%=project.getProjectDescription()%></textarea>
    </td></tr>
    <tr><td colspan="2" align="center">
        <input type="button" value="cancel" onclick="window.close();"/>
        <input type="submit" name="<%=PropertyNames.USER_ACTION%>" value="<%=Action.Duplicate%>" />
    </td></tr>
</table>
</form>
 <%
    ConnectionProvider.closeSessionAndDissconnect(sessionDB);
    %>
</body>
</html>