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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create new task</title>
<link rel="icon" 
      type="image/png" 
      href="images\icons\task.jpg">
</head>
<body>
    <%
        String message = (String) session.getAttribute(PropertyNames.TASK_ALREADY_EXISTS); 
        if (message != null) {
            session.removeAttribute(PropertyNames.TASK_ALREADY_EXISTS);
        }
    %>
    <form action="manageTask">
        <%
            MessageLogger.info("CreateNew task jps started", getClass());
            String userStoryId = request.getParameter(PropertyNames.USERSTORY_ID);
            if (userStoryId == null) {
                return;
            }
            Session dbSession = ConnectionProvider.openSession();
            String query = "from UserStory where userstoryId = '" + userStoryId + "'";
            MessageLogger.info(query, getClass());
            UserStory userStory = (UserStory) dbSession.createQuery(query).list()
                    .get(0);
            List users = dbSession.createQuery("from Author").list();
            MessageLogger.info("User story and authors name retrieved", getClass());
        %>
        
   <table align="left">
        <tr><td colspan="2" align="center"><b>Create new task</b></td>
    
      <tr><td bgcolor="#E6E6E6">Name :</td><td><input type="text" name="<%=PropertyNames.TASK_NAME%>" size="60" placeholder="Enter a task title here"> </td></tr>
      <tr><td bgcolor="#E6E6E6">Task Description :  </td><td> <textarea rows="8" cols="60" name="<%=PropertyNames.TASK_DESCRIPTION%>" placeholder="Enter a task description here"></textarea> </td></tr>
       
       
        <tr><td bgcolor="#E6E6E6">Engineer :</td>
            <td>
                <select name="<%=PropertyNames.USER_ID%>">
                <%
                    String currentUserName = (String) session.getAttribute(PropertyNames.USER_NAME);
                    MessageLogger.info("Current author name retrieved " + currentUserName, getClass());
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
                </select>
            </td></tr>
        
        
        <tr><td bgcolor="#E6E6E6">Priority : </td>
            <td>
             <select name="<%=PropertyNames.TASK_PRIORITY%>">
                <% for(Priority priority : Priority.values()) {
                %>
                <option value="<%=priority.getValue()%>"><%=priority.name()%></option>
                <%} %>
                </select>
            </td></tr>
        <tr><td bgcolor="#E6E6E6">Status : </td>
            <td>
             <select name="<%=PropertyNames.TASK_STATUS%>">
                <% 
                for(ProgressStatus pStatus : ProgressStatus.values()) {
                %>
                <option value="<%=pStatus.getValue()%>"><%=pStatus.name()%></option>
                <%} %>
                </select>
            </td></tr>
        <tr><td bgcolor="#E6E6E6">User Story : </td>
            <td>
                 <select name="<%=PropertyNames.USERSTORY_ID%>">
                    <option value="<%=userStory.getUserstoryId()%>"><%=userStory.getName()%></option>
                 </select>
            </td></tr>
        <tr><td bgcolor="#E6E6E6">Task Estimate : </td><td><input type="text" name="<%=PropertyNames.TASK_ESTIMATE%>" size="3" value="0.0"/> </td></tr>
        <tr><td bgcolor="#E6E6E6">Actual : </td><td><input type="text" name="<%=PropertyNames.TASK_ACTUAL%>" size="3" value="0.0"/> </td></tr>
        <tr><td bgcolor="#E6E6E6">Todo  : </td><td><input type="text" name="<%=PropertyNames.TASK_TODO%>" size="3" value="0.0"/> </td></tr>
         
        <tr><td colspan="2" align="center">
             <input type="button" value="cancel" onclick="window.close();"/>
             <input type="submit" name="<%=PropertyNames.USER_ACTION%>" value="<%=Action.Create%>" />
        </td></tr>
    </table>
    
    
    </form>
    
    <%
    ConnectionProvider.closeSessionAndDissconnect(dbSession);
    %>
</body>
</html> 