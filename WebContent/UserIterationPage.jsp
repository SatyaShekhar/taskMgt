<%@page import="com.sb.constants.Constants"%>
<%@page import="java.text.SimpleDateFormat"%>
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
<title>Admin your project and iteration</title>
</head>
<body>
    <jsp:include page="UserMenu.jsp"></jsp:include>
    <%!MessageLogger logger = new MessageLogger(getClass()); SimpleDateFormat  dateFormat = new SimpleDateFormat(Constants.DATE_FORMAT);%>
    <%
        String userName = (String) session.getAttribute(PropertyNames.USER_NAME);
        if (userName == null) {
            session.setAttribute(PropertyNames.INVALID_USER_ERROR_MESSAGE, "You have to login first to access user home page");
            response.sendRedirect("index.jsp");
            return;
        }
        Session sessionDB = ConnectionProvider.openSession();
        String projectIdString = request.getParameter(PropertyNames.PROJECT_ID); 
        Project project = (Project)sessionDB.get(Project.class, Long.parseLong(projectIdString));
        List<Iteration> iterations = sessionDB.createQuery("from Iteration where project.projectId = '" + projectIdString + "'").list();
        logger.info("Total project retrieved " + iterations.size());
    %>
    <table border="0" bgcolor="white" cellpadding="1" cellspacing="1" id="table-1" align="center" style="font-family:verdana;font-size:SMALL">
        <tr bgcolor="#0101DF" style="color: white">
            <th width="100">No</th>
            <th width="500">Iteration Name</th>
            <th width="100">State</th>
            <th width="100">User Stories</th>
            <th width="100">From</th>
            <th width="100">To</th>
            <th width="100">Engineer</th>
            <th> Action </th>
        </tr>
        <tr style="color: blue">
            <td width="100" colspan="7" align="left"><b>Project Name : </b> <%=project.getProjectName()%></td>
            <td align="center"><img width="25" title="Create new Iteration" src="images\icons\ceate-userstory.jpg"
                onclick="window.open('UserIterationCreatePage.jsp?<%=PropertyNames.PROJECT_ID + "=" + projectIdString%>', 'newwindow', 'location=100,menubar=0,toolbar=0,scrollbars=0,width=1100,height=555,left=200,top=120')">
            </td>
        </tr>
        
        <%
            String lightViolet = "#DBDBFF";
            int index = 1;
            for (Iteration iteration : iterations) {
                List<UserStory> userStories = sessionDB.createQuery("from UserStory where iteration.iterationId ='" + iteration.getIterationId() + "'").list();
                logger.info("For Iteration " + iteration.getName() + " total " + userStories.size() + " user stories has already defined.");
                String color = (index++ % 2 == 1) ? "white" : lightViolet;
                
        %>
        <!-- Font weight is normal but why its coming as bold here, I have added font weight as normal but think it is not required -->
        <tr bgcolor="<%=color%>" style="font-weight:normal">
            <td align="center">ITR<%=iteration.getIterationId()%></td>
            <td><%=iteration.getName()%></td>
            <td>Defined</td>
            <td>
                (<B><%=userStories.size()%></B>)
                <a href="userMainPageAction?<%=PropertyNames.USER_ACTION+"="+Action.Manage+"&"+PropertyNames.PROJECT_ID + "=" + project.getProjectId() + "&" + PropertyNames.ITERATION_ID + "=" + iteration.getIterationId()%>">Manage</a>
                </td>
            <th><%=dateFormat.format(iteration.getStartDate())%></th>
            <th><%=dateFormat.format(iteration.getEndDate())%></th>
            <td><%=iteration.getAuthor().getAuthorName()%></td>
            <td>
            <img width="17" title="Edit Iteration" src="images\icons\edit-pic.jpg"
            onclick="window.open('UserIterationEditPage.jsp?<%=PropertyNames.ITERATION_ID + "=" + iteration.getIterationId()%>', 'newwindow', 'location=100,menubar=0,toolbar=0,scrollbars=0,width=1100,height=555,left=200,top=120')">
            <img width="17" title="Copy or duplicate Iteration" src="images\icons\copy-image.jpg">  
            <% if (userStories.size() == 0) {%>
                <img width="17" 
                     title="Delete Iteration" 
                     src="images\icons\delete-icon.jpg"
                     onclick="window.open('manageIteration?<%=PropertyNames.ITERATION_ID + "=" + iteration.getIterationId() + "&" + PropertyNames.USER_ACTION + "=" + Action.Delete%>', 'newwindow', 'location=100,menubar=0,toolbar=0,scrollbars=0,width=1100,height=500,left=200,top=150')">  
            <%} else { %>
            <img width="17" title="Project with iteration can not be deleted" src="images\icons\delete-icon-gray.jpg" onclick="alert('Iteration with user stories can not be deleted')">
            <%} %>
            
            </td>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>