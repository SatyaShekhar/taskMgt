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
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create a new project</title>
<link rel="icon" 
      type="image/png" 
      href="images\icons\ceate-userstory.jpg">
</head>
<body>
<%! MessageLogger logger = new MessageLogger(getClass()); %>
<%
    String userName = (String) session.getAttribute(PropertyNames.USER_NAME);
    if (userName == null) {
        session.setAttribute(PropertyNames.INVALID_USER_ERROR_MESSAGE, "You have to login first to access project home page");
        response.sendRedirect("index.jsp");
        return;
    }
    Session sessionDB = ConnectionProvider.openSession();
%>
<form action="manageProject">
<table align="left">
    <tr><td colspan="2" align="center"><b>Create new project</b></td>
    <tr><td >Name</td><td><input type="text" size="129" name="<%=PropertyNames.PROJECT_NAME%>" placeholder="Project description"> </td></tr>
    <tr valign="top"><td>Description </td>
    <td>
    <textarea rows="20" cols="114" name="<%=PropertyNames.PROJECT_DESCRIPTION%>" placeholder="Project description"></textarea>
    </td></tr>
    <tr><td >Engineer</td><td>
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