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
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" session="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create new bug</title>
<link rel="icon" 
      type="image/png" 
      href="images\icons\common-bug.png">
</head>
<body>
    <%
        // TODO this implementation needs confirmation
        String message = (String) session.getAttribute(PropertyNames.BUG_ALREADY_EXISTS); 
        if (message != null) {
            session.removeAttribute(PropertyNames.BUG_ALREADY_EXISTS);
        }
    %>
    <form action="manageBug">
        <%
            MessageLogger.info("BugCreateNew.jps started", getClass());
            String userStoryId = request.getParameter(PropertyNames.USERSTORY_ID);
            if (userStoryId == null) {
                MessageLogger.error("This was not expected as there should be one US", getClass());
                return;
            }
            Session dbSession = ConnectionProvider.openSession();
            String query = "from UserStory where userstoryId = '" + userStoryId + "'";
            MessageLogger.info(query, getClass());
            UserStory userStory = (UserStory) dbSession.createQuery(query).list().get(0);
            List users = dbSession.createQuery("from Author").list();
            MessageLogger.info("User story and authors name retrieved", getClass());
        %>
        
   <table align="left">
        <tr><td colspan="2" align="center"><b>Create New </b> <img alt="Bug" title="Bug" src="images\icons\common-bug.png"> </td>
    
      <tr><td>Name </td><td><input type="text" name="<%=PropertyNames.BUG_NAME%>" size="60" placeholder="Enter bug title here"> </td></tr>
      <tr><td valign="top">Description</td><td> <textarea rows="8" cols="60" name="<%=PropertyNames.BUG_DESCRIPTION%>" placeholder="Enter bug description"></textarea> </td></tr>
       
       
       <tr><td>Submitter</td>
            <td>
                <select name="<%=PropertyNames.BUG_SUBMITTER_ID%>" >
                <%
                    String currentUserName = (String) session.getAttribute(PropertyNames.USER_NAME);
                    MessageLogger.info("Current author name retrieved " + currentUserName, getClass());
                    for (Object userObj : users) {
                        Author author = (Author) userObj;
                        System.out.print("author " + author.getAuthorId() + " , name = " + author.getAuthorName());
                        if (author.getAuthorName().equals(currentUserName)) {
                            System.out.print("########################## author " + author.getAuthorId() + " , name = " + author.getAuthorName());
                %>
                <option selected="selected" value="<%=author.getAuthorId()%>"><%=author.getAuthorName()%></option>
                <%
                break;
                    } else {
                        continue;
                    }
                    }
                %>
                </select>
            </td></tr>
            
        <tr><td>Engineer</td>
            <td>
                <select name="<%=PropertyNames.BUG_ENGINEER_ID%>">
                <%
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
        
        
       <tr><td>Priority</td>
            <td>
             <select name="<%=PropertyNames.BUG_PRIORITY%>">
                <% for(Priority priority : Priority.values()) {
                %>
                <option value="<%=priority.getValue()%>"><%=priority.name()%></option>
                <%} %>
                </select>
            </td></tr>
        <tr><td>Severity</td>
            <td>
             <select name="<%=PropertyNames.BUG_SEVERITY%>">
                <% for(Severity severity : Severity.values()) {
                %>
                <option value="<%=severity.getValue()%>"><%=severity.name()%></option>
                <%} %>
                </select>
            </td>
          </tr>
            
        <tr><td>Status</td>
            <td>
             <select name="<%=PropertyNames.BUG_STATUS%>">
                <% 
                for(BugStatus status : BugStatus.values()) {
                %>
                <option value="<%=status.getValue()%>"><%=status.name()%></option>
                <%} %>
                </select>
            </td></tr>
        <tr><td>User Story</td>
            <td>
                 <select name="<%=PropertyNames.USERSTORY_ID%>">
                    <option value="<%=userStory.getUserstoryId()%>"><%=userStory.getName()%></option>
                 </select>
            </td></tr>
        <tr><td>Planned </td><td><input type="text" name="<%=PropertyNames.BUG_ESTIMATE%>" size="3" value="0.0"/> days</td></tr>
        <tr><td>Actual</td><td><input type="text" name="<%=PropertyNames.BUG_ACTUAL%>" size="3" value="0.0"/> days</td></tr>
        <tr><td>Remaining </td><td><input type="text" name="<%=PropertyNames.BUG_TODO%>" size="3" value="0.0"/> days</td></tr>
         
        <tr><td colspan="2" align="center">
             <input type="button" value="Cancel" onclick="window.close();"/>
             <input type="submit" name="<%=PropertyNames.USER_ACTION%>" value="<%=Action.Create%>" />
        </td></tr>
    </table>
    
    
    </form>
    
    <%
    ConnectionProvider.closeSessionAndDissconnect(dbSession);
    %>
</body>
</html> 