<%@page import="com.sb.db.helper.HqlQueryHelper"%>
<%@page import="com.sb.pojo.Author"%>
<%@page import="com.sb.constants.Action"%>
<%@page import="com.sb.pojo.Iteration"%>
<%@page import="com.sb.pojo.UserStory"%>
<%@page import="com.sb.message.log.MessageLogger"%>
<%@page import="com.sb.pojo.Project"%>
<%@page import="java.util.List"%>
<%@page import="com.sb.db.helper.ConnectionProvider"%>
<%@page import="org.hibernate.Session"%>
<%@page import="com.sb.constants.PropertyNames"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" session="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Here is my account</title>
<link rel="icon" type="image/png" href="images\general\drop.png">
</head>
<body>
    <jsp:include page="UserMenu.jsp"></jsp:include>
    <%!MessageLogger logger = new MessageLogger(getClass());%>
    <%
        Author user = (Author) session.getAttribute(PropertyNames.USER);
        if (user == null) {
            session.setAttribute(PropertyNames.INVALID_USER_ERROR_MESSAGE, "You have to login first to access user account page");
            response.sendRedirect("index.jsp");
            return;
        }
        Session sessionDB = ConnectionProvider.openSession();
        List<Project> projects = HqlQueryHelper.getProjects(sessionDB, user.getOrganization().getId());
        logger.info("Total project retrieved " + projects.size());
    %>
    <h1>
        Welcome
        <%=user.getFullName()%></h1>
    <p>
        Here is your account information <font color="red"> and edit support is going to be provided soon</font>
    </p>
    <table cellspacing="5" style="">
        <tr>
            <td>Account Name</td>
            <td><%=user.getAuthorName()%></td>
        </tr>
        <tr>
            <td>Organization name</td>
            <td><%=user.getOrganization().getName()%></td>
        </tr>
        <tr>
            <td>Account Created</td>
            <td><%=user.getCreationTime()%></td>
        </tr>
    </table>
    <fieldset title="Configure your preference settings">
        <legend>Account Preference</legend>
        <address>Select and update project and iteration to be displayed when you login to your page for the first time</address>
    </fieldset>
    <%
        logger.info("Going to close connection for my session");
        ConnectionProvider.closeSessionAndDissconnect(sessionDB);
    %>
</body>
</html>