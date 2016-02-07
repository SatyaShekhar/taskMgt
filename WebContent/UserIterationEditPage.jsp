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
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" session="true"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create a new iteration</title>
</head>
<body>
<%! MessageLogger logger = new MessageLogger(getClass()); SimpleDateFormat dateFormat = new SimpleDateFormat(Constants.DATE_FORMAT);%>
<%
String userName = (String) session.getAttribute(PropertyNames.USER_NAME);
if (userName == null) {
    session.setAttribute(PropertyNames.INVALID_USER_ERROR_MESSAGE, "You have to login first to access any home page");
    response.sendRedirect("index.jsp");
    return;
}
Session sessionDB = ConnectionProvider.openSession();
String iterationIdString = request.getParameter(PropertyNames.ITERATION_ID);
if (iterationIdString == null) {
    throw new IllegalStateException("Iteration id cannot be null here");
}
Iteration iteration = (Iteration)sessionDB.get(Iteration.class, Long.parseLong(iterationIdString));
%>
<form action="manageIteration" method="post">
    <input type="hidden" name="<%=PropertyNames.ITERATION_ID%>" value="<%=iteration.getIterationId()%>">
    <table align="left">
        <tr><td colspan="2" align="center"><b>Update Iteration</b></td>
        <tr><td bgcolor="#E6E6E6">ITR <%=iteration.getIterationId()%> : </td><td><input type="text" size="150" name="<%=PropertyNames.ITERATION_NAME%>" value="<%=iteration.getName()%>"  vaplaceholder="Iteration name required"> </td></tr>
        <tr bgcolor="#E6E6E6">
            <td>Iteration Description : </td>
            <td><textarea rows="20" cols="114" name="<%=PropertyNames.ITERATION_DESCRIPTION%>"  placeholder="Iteration description"><%=iteration.getDescription()%></textarea></td>
        </tr>
       <tr><td bgcolor="#E6E6E6">Start Date : </td><td><input type="text" size="150" value="<%=dateFormat.format(iteration.getStartDate())%>" name="<%=PropertyNames.ITERATION_START_DATE%>" placeholder="<%=Constants.DATE_FORMAT%>"> </td></tr>
       <tr><td bgcolor="#E6E6E6">End Date : </td><td><input type="text" size="150" value="<%=dateFormat.format(iteration.getEndDate())%>" name="<%=PropertyNames.ITERATION_END_DATE%>" placeholder="<%=Constants.DATE_FORMAT%>"> </td></tr>
       <tr><td bgcolor="#E6E6E6">Engineer : </td>
           <td>
           <select name="<%=PropertyNames.USER_ID%>">
                <%
                    String currentUserName = (String) iteration.getAuthor().getAuthorName();
                    logger.info("Current selected author name is " + currentUserName);
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
       <tr><td bgcolor="#E6E6E6">Project : </td>
           <td>
           <select name="<%=PropertyNames.PROJECT_ID%>">
                <%
                    List<Project> projects = sessionDB.createQuery("from Project").list();
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
            </select>
           </td></tr>
       <tr><td colspan="2" align="center">
            <input type="button" value="cancel" onclick="window.close();"/>
            <input type="submit" name="<%=PropertyNames.USER_ACTION%>" value="<%=Action.Update%>" />
        </td></tr>
        
    </table>
</form>  
    <%
        ConnectionProvider.closeSessionAndDissconnect(sessionDB);
    %>
</body>
</html>