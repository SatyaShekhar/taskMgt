<%@page import="com.sb.db.helper.HqlQueryHelper"%>
<%@page import="com.sb.helper.DateFormatProvider"%>
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
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" session="true"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create a new iteration</title>
</head>
<body>
<%! MessageLogger logger = new MessageLogger(getClass()); %>
<%
    Author author = (Author) session.getAttribute(PropertyNames.USER);
    if (author == null) {
        session.setAttribute(PropertyNames.INVALID_USER_ERROR_MESSAGE, "You have to login first to access any home page");
        response.sendRedirect("index.jsp");
        return;
    }
    Session sessionDB = ConnectionProvider.openSession();
    String projectIdString = request.getParameter(PropertyNames.PROJECT_ID);
%>
<form action="manageIteration" method="post">
    <table>
        <tr><td colspan="2" align="center"><b>Create new iteration</b></td>
        <tr><td>Name</td><td><input type="text" size="114" name="<%=PropertyNames.ITERATION_NAME%>" placeholder="Iteration name required"> </td></tr>
        <tr>
            <td valign="top">Description</td>
            <td><textarea rows="20" cols="114" name="<%=PropertyNames.ITERATION_DESCRIPTION%>" placeholder="Iteration description"></textarea></td>
        </tr>
       <tr><td>Start Date</td><td><input type="text" size="10" name="<%=PropertyNames.ITERATION_START_DATE%>" placeholder="<%=Constants.DATE_FORMAT%>" value="<%=  DateFormatProvider.getCurrentDay() %>"> </td></tr>
       <tr><td>End Date</td><td><input type="text" size="10" name="<%=PropertyNames.ITERATION_END_DATE%>" placeholder="<%=Constants.DATE_FORMAT%>" value="<%=  DateFormatProvider.getCurrentDay() %>"> </td></tr>
       <tr><td>Engineer</td>
           <td>
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
       <tr><td>Project</td>
           <td>
           <select name="<%=PropertyNames.PROJECT_ID%>">
                <%
                    List<Project> projects = HqlQueryHelper.getProjects(sessionDB, author.getOrganization().getId());
                    long currentProjectId = Long.parseLong(projectIdString);
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
            </select>
           </td></tr>
       <tr><td colspan="2" align="center">
            <input type="button" value="Cancel" onclick="window.close();"/>
            <input type="submit" name="<%=PropertyNames.USER_ACTION%>" value="<%=Action.Create%>" />
        </td></tr>
        
    </table>
</form>  
    <%
        ConnectionProvider.closeSessionAndDissconnect(sessionDB);
    %>
</body>
</html>