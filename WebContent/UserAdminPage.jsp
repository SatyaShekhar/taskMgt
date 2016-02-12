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
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" session="true" errorPage="user\InvalidUserLogin.jsp"%>
<!DOCTYPE html>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin your project and iteration</title>
<link rel="icon" 
      type="image/png" 
      href="images\general\drop.png">
</head>
<body>
    <%!MessageLogger logger = new MessageLogger(getClass());%>
    <%
        Author user = (Author) session.getAttribute(PropertyNames.USER);
        if (user == null) {
            session.setAttribute(PropertyNames.INVALID_USER_ERROR_MESSAGE, "You have to login first to access user home page");
            response.sendRedirect("index.jsp");
            return;
        }
        Session sessionDB = ConnectionProvider.openSession();
        List<Project> projects = HqlQueryHelper.getProjects(sessionDB, user.getOrganization().getId());
        logger.info("Total project retrieved " + projects.size());
    %>
    <jsp:include page="UserMenu.jsp"></jsp:include>
    <table border="0" bgcolor="white" cellpadding="1" cellspacing="1" id="table-1" align="center" style="font-family:verdana;font-size:SMALL">
        <tr bgcolor="#0101DF" style="color: white">
            <th width="100">No</th>
            <th width="500">Project Name</th>
            <th width="100">State</th>
            <th width="100">Iterations</th>
            <th width="100">Created</th>
            <th width="100">Engineer</th>
            <th><img width="25" title="Create new project" src="images\icons\ceate-userstory.png"
                onclick="window.open('UserCreateProject.jsp', 'newwindow', 'addressbar=no,location=100,menubar=0,toolbar=0,scrollbars=0,width=1100,height=500,left=200,top=150')">
            </th>
        </tr>
        <%
            String lightViolet = "#DBDBFF";
            int index = 1;
            for (Project project : projects) {
                List<Iteration> iterations =  HqlQueryHelper.getIterationsUnderProject(sessionDB, project.getProjectId());
                logger.info("For Project " + project.getProjectName() + " total " + iterations.size() + " has already defined.");
                String color = (index++ % 2 == 1) ? "white" : lightViolet;
        %>
        <!-- Font weight is normal but why its coming as bold here, I have added font weight as normal but think it is not required -->
        <tr bgcolor="<%=color%>" style="font-weight:normal">
            <td align="center">P<%=project.getProjectId()%></td>
            <td><%=project.getProjectName()%></td>
            <td>Defined</td>
            <td align="center">
                <b><%=iterations.size()%></b>
                (<a href="UserIterationPage.jsp?<%=PropertyNames.PROJECT_ID%>=<%=project.getProjectId()%>">Manage</a>)
                </td>
            <td><%=project.getCreationDate()%></td>
            <td><%=project.getAuthor().getAuthorName()%></td>
            <td align="right">
            <img  width="17" title="Edit project" src="images\icons\edit-pic.jpg" onclick="window.open('UserEditProject.jsp?<%=PropertyNames.PROJECT_ID + "=" + project.getProjectId()%>', 'newwindow', 'location=100,menubar=0,toolbar=0,scrollbars=0,width=1100,height=500,left=200,top=150')">
            <img width="17" title="Copy and duplicate duplicate Project" src="images\icons\copy-image.jpg">
            <% if (iterations.size() == 0) {%>
                <img width="17" 
                     title="Delete Project" 
                     src="images\icons\delete-icon.jpg"
                     onclick="window.open('manageProject?<%=PropertyNames.PROJECT_ID + "=" + project.getProjectId() + "&" + PropertyNames.USER_ACTION + "=" + Action.Delete%>', 'newwindow', 'location=100,menubar=0,toolbar=0,scrollbars=0,width=1100,height=500,left=200,top=150')">  
            <%} else { %>
            <img width="17" title="Project with iteration can not be deleted" src="images\icons\delete-icon-gray.jpg" onclick="alert('Project with iteration can not be deleted')">
            <%} %>
            </td>
        </tr>
        <%
            }
        %>
    </table>
    <%
    ConnectionProvider.closeSessionAndDissconnect(sessionDB);
    %>
</body>
</html>