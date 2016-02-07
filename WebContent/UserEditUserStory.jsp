<%@page import="com.sb.constants.Priority"%>
<%@page import="com.sb.message.log.MessageLogger"%>
<%@page import="com.sb.constants.Action"%>
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
<title>Edit this user story</title>
</head>
<body>
    <%! MessageLogger logger = new MessageLogger(getClass()); %>
    <form action="manageUserStory">
        <%
            String userStoryId = request.getParameter(PropertyNames.USERSTORY_ID);
            if (userStoryId == null) {
                return;
            }
            Session dbSession = ConnectionProvider.openSession();
            UserStory userStory = (UserStory) dbSession.load(UserStory.class, Long.parseLong(userStoryId));
            List<Author> users = dbSession.createQuery("from Author").list();
        %>
        
        <input type="hidden" name="<%=PropertyNames.USERSTORY_ID%>" value="<%=userStory.getUserstoryId()%>">
            
        <table align="left">
        <tr><td colspan="2" align="center"><b>Update user story</b></td>
        <tr><td bgcolor="#E6E6E6">US<%=userStoryId%>: </td><td><input type="text" name="<%=PropertyNames.USERSTORY_NAME%>" value="<%=userStory.getName()%>" size="150"></td></tr>
        <tr bgcolor="#E6E6E6">
            <td>User Story Description :</td>
            <td><textarea rows="20" cols="114" name="<%=PropertyNames.USERSTORY_DESCRIPTION%>"><%=userStory.getDescription()%></textarea></td>
        </tr>
        <tr><td bgcolor="#E6E6E6">Engineer : </td><td>
        <select name="<%=PropertyNames.USER_ID%>">
            <%
                Long selectedAuthorId = userStory.getAuthor().getAuthorId();
                logger.info("User story author id " + selectedAuthorId);
                
                for (Author author : users) {
                    if (author.getAuthorId() == selectedAuthorId) {
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
         <tr><td bgcolor="#E6E6E6">Plan Estimate : </td><td><input type="text" name="<%=PropertyNames.USERSTORY_PLANESTIMATE%>" value="<%=userStory.getPlanEstimate()%>"> </td></tr>
        <tr><td bgcolor="#E6E6E6">Priority : </td><td>
        
        <select name="<%=PropertyNames.USERSTORY_PRIORITY%>">
            <%
            int usPriority = userStory.getPriority();
                for (Priority priority : Priority.values()) {
                    if (usPriority == priority.getValue()) {
            %>
            <option value="<%=priority.getValue()%>" selected="selected"><%=priority.name()%></option>
            <%
                } else {
            %>
            <option value="<%=priority.getValue()%>"><%=priority.name()%></option>
            <%
                }
                }
            %>
        </select>
        
         </td></tr>
       
        <tr><td bgcolor="#E6E6E6">Iteration :</td><td>
          <select name="<%=PropertyNames.ITERATION_ID%>">
            <%
            long projectId = userStory.getIteration().getProject().getProjectId();
            List<Iteration> iterations = dbSession.createQuery("from Iteration where project.projectId = '" + projectId + "'").list();
                for (Iteration iteration : iterations) {
                    if (iteration.getIterationId() == userStory.getIteration().getIterationId()) {
            %>
            <option value="<%=iteration.getIterationId()%>" selected="selected"><%=iteration.getName()%></option>
            <%
                } else {
            %>
            <option value="<%=iteration.getIterationId()%>" ><%=iteration.getName()%></option>
            <%
                }
                }
            %>
        </select>
        </td></tr>
        <tr><td colspan="2" align="center">
            <input type="button" value="Cancel" onclick="window.close();"/>
            <input type="submit" name="<%=PropertyNames.USER_ACTION%>" value="<%=Action.Update%>"/>
            <input type="button" name="<%=PropertyNames.USER_ACTION%>" value="Save As" onclick="alert('Not supported yet');"/>
        </td></tr>
    </table>
    </form>
    
    <%
    ConnectionProvider.closeSessionAndDissconnect(dbSession);
    %>
</body>
</html> 