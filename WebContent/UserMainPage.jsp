<%@page import="com.sb.constants.BugStatus"%>
<%@page import="com.sb.constants.Severity"%>
<%@page import="com.sb.constants.Priority"%>
<%@page import="com.sb.helper.UserStoryStatusHelper"%>
<%@page import="com.sb.constants.ProgressStatus"%>
<%@page import="com.sb.message.log.MessageLogger"%>
<%@page import="com.sb.constants.Action"%>
<%@page import="com.sb.pojo.Task"%>
<%@page import="com.sb.pojo.Bug"%>
<%@page import="com.sb.db.helper.ConnectionProvider"%>
<%@page import="com.sb.pojo.UserStory"%>
<%@page import="com.sb.pojo.Iteration"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.hibernate.Session"%>
<%@page import="com.sb.db.helper.ConnectionProvider"%>
<%@page import="com.sb.db.helper.HibernateQueryHelper"%>
<%@page import="com.sb.pojo.Project"%>
<%@page import="java.util.List"%>
<%@page import="com.sb.constants.PropertyNames"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin your User story and Task here</title>
<script type="text/javascript">
    var table = document.getElementById('table-1');
    var tableDnD = new TableDnD();
    tableDnD.init(table);
</script>
<script type="text/javascript" src="jquery.min.js"> </script>
<script type="text/javascript" src="jquery.jeditable.js"> </script>
<script type="text/javascript" charset="utf-8">
$(document).ready(function() {
    $('.dblclick').editable('http://localhost:8088/taskMgt/inlineEditTaskManager', {
        indicator : '<img src="images/edit/indicator.gif">',
        tooltip   : 'Click to edit...',
        style  : "inherit",
        event     : "dblclick",
        onblur : "submit"
    });
    $('.dblclick_area').editable('http://localhost:8088/taskMgt/inlineEditTaskManager', {
        type      : 'textarea',
        cancel    : 'Cancel',
        submit    : 'OK',
        event     : "dblclick",
        indicator : '<img src="images/edit/indicator.gif">',
        tooltip   : 'Click to edit...'
    });
});
</script>
<script type="text/javascript">


    function toggle_visibility(usId, lnkid) {
        if (document.getElementsByTagName) {
            var tables = document.getElementsByTagName('table');
             for ( var i = 0; i < tables.length; i++) {
                if (tables[i].id == 'table-1') {
                    var trs = tables[i].getElementsByTagName('tr');
                    
                    for ( var j = 0; j < trs.length; j += 1) {
                        if (trs[j].id != usId) {
                            continue;
                        }
                        if (trs[j].style.display == 'none') {
                            trs[j].style.display = '';
                        } else {
                            trs[j].style.display = 'none';
                        }
                   }
                }
            }
        }
        var x = document.getElementById(lnkid);
        if (x.innerHTML == '[+] Expand ')
            x.innerHTML = '[-] Collapse ';
        else
            x.innerHTML = '[+] Expand ';
    }
</script>
</head>
<body bgcolor="#D8D8D8">
    <%!MessageLogger logger = new MessageLogger(getClass());
    UserStoryStatusHelper usHelper = new UserStoryStatusHelper();%>
    <jsp:include page="UserMenu.jsp"></jsp:include>
    <%
        String userName = (String) session.getAttribute(PropertyNames.USER_NAME);
        if (userName == null) {
            session.setAttribute(PropertyNames.INVALID_USER_ERROR_MESSAGE, "You have to login first to access your page");
            response.sendRedirect("index.jsp");
            return;
        }

        Long projectId = (Long) session.getAttribute(PropertyNames.PROJECT_ID);
        Long iterationId = (Long) session.getAttribute(PropertyNames.ITERATION_ID);
        logger.info("Initially Project ID : " + projectId + " Iteration ID : " + iterationId);
        Session session2 = ConnectionProvider.openSession();

        Project project = null;
        if (projectId != null) {
            project = (Project) session2.get(Project.class, projectId);
        }
        List<Project> projects = session2.createQuery("from Project").list();
        List<Iteration> iterations = new ArrayList<Iteration>();
        if (project == null && (!projects.isEmpty())) {
            project = projects.get(0);
            projectId = project.getProjectId();
            logger.info(projects.size() + " projects present and retireved project is " + project.getProjectName());
            session.setAttribute(PropertyNames.PROJECT_ID, project.getProjectId());
        }
        Iteration iteration = null;
        if (iterationId != null) {
            iteration = (Iteration) session2.get(Iteration.class, iterationId);
        }
        if (project != null) {
            logger.info("Project found and going to intialize the iterations");
            iterations = session2.createQuery("from Iteration where  project.projectId = '" + project.getProjectId() + "'").list();
            if (iterationId == null && (!iterations.isEmpty())) {
                iteration = (Iteration) iterations.get(0);
                iterationId = iteration.getIterationId();
                session.setAttribute(PropertyNames.ITERATION_ID, iteration.getIterationId());
            }
            logger.info(iterations.size() + " iterations present and retrieved iteration is " + iteration.getName());
        }
    %>
    <form action="userMainPageAction">
        <b>Project Name :</b> <select onchange="this.form.submit();" name="<%=PropertyNames.PROJECT_ID%>">
            <%
                for (Project project2 : projects) {
                    if (project.getProjectId() == project2.getProjectId()) {
            %>
            <option selected="selected" value="<%=project2.getProjectId()%>"><%=project2.getProjectName()%></option>
            <%
                } else {
            %>
            <option value="<%=project2.getProjectId()%>"><%=project2.getProjectName()%></option>
            <%
                }
                }
            %>
        </select> <br> <b>Iteration Name :</b> <select name="<%=PropertyNames.ITERATION_ID%>" onchange="this.form.submit();">
            <%
                for (Iteration iteration2 : iterations) {
                    if (iteration2.getIterationId() == iteration.getIterationId()) {
            %>
            <option selected="selected" value="<%=iteration2.getIterationId()%>"><%=iteration2.getName()%></option>
            <%
                } else {
            %>
            <option value="<%=iteration2.getIterationId()%>"><%=iteration2.getName()%></option>
            <%
                }
                }
            %>
        </select>
    </form>
    <table border="0" bgcolor="white" cellpadding="1" cellspacing="1" id="table-1" name="table-1" align="center"
        style="font-family: verdana; font-size: SMALL">
        <tr bgcolor="#0101DF" style="color: white">
            <th>View</th>
            <th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
            <th>ID</th>
            <th width="300">Name</th>
            <th>Status</th>
            <th>Plan Est</th>
            <th>Task Est</th>
            <th>To Do</th>
            <th>Engineer</th>
            <th>Priority</th>
            <th>Action</th>
        </tr>
        <tr>
            <td colspan="11" align="right">
                <img width="25" title="Create new user story" src="images\icons\ceate-userstory.jpg"
                onclick="window.open('UserStoryCreateNew.jsp?<%=PropertyNames.ITERATION_ID + "=" + iterationId%>', 'newwindow', 'location=100,menubar=0,toolbar=0,scrollbars=0,width=1100,height=550,left=200,top=150')">
            </td>
        </tr>
        <%
            // Get all user stories by project and iteration name and display
            String query = "from UserStory where  iteration.iterationId = '" + iterationId + "' and iteration.project.projectId = '"
                    + projectId + "'";
            List<UserStory> userStories = session2.createQuery(query).list();
            logger.info("Hello " + query + "\nResult is " + userStories);
            int index = 0;
            String selectedStyle = "background-color: green; color: white";
            for (UserStory userStory : userStories) {
                ProgressStatus userStoryProgressStatus = usHelper.getProgressStatus(session2, userStory);
                String queryStringReadTaskByUS = "from Task where userStory.userstoryId = '" + userStory.getUserstoryId() + "'";
                List<Task> tasksForUS = session2.createQuery(queryStringReadTaskByUS).list();
                String queryStringReadBugByUS = "from Bug where userStory.userstoryId = '" + userStory.getUserstoryId() + "'";
                List<Bug> bugsForUS = session2.createQuery(queryStringReadBugByUS).list();
        %>
        <!-- Row to display user story one row per US -->
        <tr ondragover="" ondrop="" draggable="true" dropzone="">
            <td><a href="javascript:toggle_visibility('<%=userStory.getUserstoryId()%>','lnk1<%=userStory.getUserstoryId()%>');">
                    <div align="right" id="lnk1<%=userStory.getUserstoryId()%>" name="lnk1<%=userStory.getUserstoryId()%>">[+] Expand
                    </div>
            </a></td>
            <td align="center"><img alt="User Story" title="User Story" src="images\icons\userstory.jpg" width="15" height="15"></td>
            <td>US<%=userStory.getUserstoryId()%></td>
            <td class="dblclick_area"><%=userStory.getName().trim()%></td>
            <td style="font-weight: bold">
                <table border="0" cellpadding="0" cellspacing="4">
                    <tr>
                        <td style="<%=(userStoryProgressStatus == ProgressStatus.Defined) ? selectedStyle : ""%>">D</td>
                        <td style="<%=(userStoryProgressStatus == ProgressStatus.Progress) ? selectedStyle : ""%>">P</td>
                        <td style="<%=(userStoryProgressStatus == ProgressStatus.Complete) ? selectedStyle : ""%>">C</td>
                        <td style="<%=(userStoryProgressStatus == ProgressStatus.Accepted) ? selectedStyle : ""%>">A</td>
                    </tr>
                </table>
            </td>
            <td align="center"><%=userStory.getPlanEstimate()%></td>
            <td align="center"><%=usHelper.getTotalEstimate(tasksForUS, session2)%></td>
            <th><%=usHelper.getTotalTodo(tasksForUS, session2)%></th>
            <td><%=userStory.getAuthor().getAuthorName()%></td>
            <td align="center"><%=Priority.valueOf(userStory.getPriority())%></td>
            <td width="130" align="right">
                <img width="17" title="Create new task" src="images\icons\Create.png"
                onclick="window.open('TaskCreateNew.jsp?<%=PropertyNames.USERSTORY_ID + "=" + userStory.getUserstoryId()%>', 'newwindow', 'location=100,menubar=0,toolbar=0,scrollbars=0,width=1110,height=510,left=200,top=150')">
                
                <img width="17" title="Create new bug" src="images\icons\common-bug.png"
                onclick="window.open('BugCreateNew.jsp?<%=PropertyNames.USERSTORY_ID + "=" + userStory.getUserstoryId()%>', 'newwindow', 'location=100,menubar=0,toolbar=0,scrollbars=0,width=1110,height=510,left=200,top=150')">
                
                <img width="17" title="Edit the user story" src="images\icons\edit-pic.png"
                onclick="window.open('UserEditUserStory.jsp?<%=PropertyNames.USERSTORY_ID + "=" + userStory.getUserstoryId()%>', 'newwindow', 'location=100,menubar=0,toolbar=0,scrollbars=0,width=1110,height=550,left=200,top=120')">
                
                <img width="17" title="Copy or duplicate user story" src="images\icons\copy-image.jpg"> 
                <img width="17" title="Show history" src="images\icons\history.jpg"
                onclick="window.open('UserStoryHistory.jsp?<%=PropertyNames.USERSTORY_ID + "=" + userStory.getUserstoryId()%>', 'newwindow', 'location=100,menubar=0,toolbar=0,scrollbars=0,width=1110,height=550,left=200,top=120')">
                
                <img width="17" title="Delete user story" src="images\icons\delete-icon.jpg"
                onclick="window.open('manageUserStory?<%=PropertyNames.USERSTORY_ID + "=" + userStory.getUserstoryId() + "&" + PropertyNames.USER_ACTION + "="
                        + Action.Delete%>', 'newwindow', 'location=100,menubar=0,toolbar=0,scrollbars=0,width=1100,height=500,left=200,top=150')">
        </tr>
        <tr bgcolor="blue">
            <td colspan="11" height="0" bordercolor="WHITE"></td>
        </tr>
        <!-- Logic to display tasks per user story -->
        <%
            for (Task task : tasksForUS) {
                    ProgressStatus progressStatus = ProgressStatus.valueOf(task.getStatus());
        %>
        <tr bgcolor="#D8D8D8" id="<%=userStory.getUserstoryId()%>" style="display: none;">
            <!-- bgcolor="#DAEEEF" -->
            <th></th>
            <td align="center"><img alt="Task" title="Task" src="images\icons\task.jpg" width="15" height="15"></td>
            <td align="right">TA<%=task.getTaskId()%></td>
            <td class="dblclick" id="<%=task.getTaskId()%>"><%=task.getName()%></div></td>
            <td style="font-weight: bold">
                <table>
                    <tr>
                        <td style="<%=(progressStatus == ProgressStatus.Defined) ? selectedStyle : ""%>">D</td>
                        <td style="<%=(progressStatus == ProgressStatus.Progress) ? selectedStyle : ""%>">P</td>
                        <td style="<%=(progressStatus == ProgressStatus.Complete) ? selectedStyle : ""%>">C</td>
                    </tr>
                </table>
            </td>
            <td align="center">&nbsp;</td>
            <td align="center"><%=task.getTaskEstimate()%></td>
            <th><%=task.getRemaining()%></th>
            <td><%=task.getAuthor().getAuthorName()%></td>
            <td align="center"><%=Priority.valueOf(task.getPriority())%></td>
            <td align="right">
                <img width="17" title="Edit task" src="images\icons\edit-pic.png"
                    onclick="window.open('TaskEdit.jsp?<%=PropertyNames.TASK_ID + "=" + task.getTaskId()%>', 'newwindow', 'location=100,menubar=0,toolbar=0,scrollbars=0,width=800,height=800')">
                <img width="17" title="Copy or duplicate task" src="images\icons\copy-image.jpg"> 
                <img width="17" title="History" src="images\icons\history.jpg"
                    onclick="window.open('TaskHistory.jsp?<%=PropertyNames.TASK_ID + "=" + task.getTaskId()%>', 'newwindow', 'location=100,menubar=0,toolbar=0,scrollbars=0,width=1100,height=500,left=200,top=150')">
                <img width="17" title="Delete Task" src="images\icons\delete-icon.jpg"
                    onclick="window.open('manageTask?<%=PropertyNames.TASK_ID + "=" + task.getTaskId() + "&" + PropertyNames.USER_ACTION + "=" + Action.Delete%>', 'newwindow', 'location=100,menubar=0,toolbar=0,scrollbars=0,width=1100,height=500,left=200,top=150')">
            </td>
        </tr>
        <%
            }
        %>
        
        <!-- Logic to display bugs per user story -->
        <%
            for (Bug bug : bugsForUS) {
                BugStatus bugStatus = BugStatus.valueOf(bug.getStatus());
        %>
        <tr bgcolor="#D8D8D8" id="<%=userStory.getUserstoryId()%>" style="display: none;">
            <th></th>
            <td align="center"><img alt="Bug" title="Bug" src="images\icons\common-bug.png" width="15" height="15"></td>
            <td align="right">BUG(<%=bug.getBugId()%>)</td>
            <td class="dblclick" id="<%=bug.getBugId()%>"><%=bug.getName()%></div></td>
            <td style="font-weight: bold">
                <table>
                    <tr>
                        <td colspan="3" ><%= bugStatus %></td>
                    </tr>
                </table>
            </td>
            <td align="center">&nbsp;</td>
            <td align="center"><%=bug.getEstimate()%></td>
            <th><%=bug.getRemaining()%></th>
            <td><%=bug.getEngineer().getAuthorName()%></td>
            <td align="center"><%=Severity.valueOf(bug.getSeverity())%></td>
            <td align="right">
                <img width="17" title="Edit task" src="images\icons\edit-pic.png"
                    onclick="window.open('BugEdit.jsp?<%=PropertyNames.BUG_ID + "=" + bug.getBugId()%>', 'newwindow', 'location=100,menubar=0,toolbar=0,scrollbars=0,width=800,height=800')">
                <img width="17" title="Copy or duplicate bug" src="images\icons\copy-image.jpg">
                <img width="17" title="Bug history" src="images\icons\history.jpg"
                    onclick="window.open('BugHistory.jsp?<%=PropertyNames.BUG_ID + "=" + bug.getBugId()%>', 'newwindow', 'location=100,menubar=0,toolbar=0,scrollbars=0,width=1100,height=500,left=200,top=150')">
                <img width="17" title="Delete bug" src="images\icons\delete-icon.jpg"
                    onclick="window.open('manageBug?<%=PropertyNames.BUG_ID + "=" + bug.getBugId() + "&" + PropertyNames.USER_ACTION + "=" + Action.Delete%>', 'newwindow', 'location=100,menubar=0,toolbar=0,scrollbars=0,width=1100,height=500,left=200,top=150')">
            </td>
        </tr>
        <%
            }
        %>
        <%
            }
        %>
    </table>
    <%
        ConnectionProvider.closeSessionAndDissconnect(session2);
    %>
</body>
</html>
