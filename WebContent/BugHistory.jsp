<%@page import="java.util.Collections"%>
<%@page import="java.util.Set"%>
<%@page import="com.sb.constants.ProgressStatus"%>
<%@page import="com.sb.constants.Status"%>
<%@page import="com.sb.pojo.Task"%>
<%@page import="com.sb.pojo.PastInformation"%>
<%@page import="com.sb.pojo.Bug"%>
<%@page import="com.sb.services.ManageTaskServlet"%>
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
<title>Here is your change log</title>
<link rel="icon" 
      type="image/png" 
      href="images\icons\common-bug.png">
</head>
<body>
    <%! MessageLogger logger = new MessageLogger(getClass()); %>
    <%
            String bugId = request.getParameter(PropertyNames.BUG_ID);
            logger.info("Selected bug ID: " + bugId);
            if (bugId == null) {
                logger.error("For null bug ID we can't display the history !!!!");
                return;
            }
            Session dbSession = ConnectionProvider.openSession();
            Bug bug = (Bug) dbSession.get(Bug.class, Long.parseLong(bugId));
            if (bug == null) {
                throw new IllegalStateException("Bug can not be null here for ID : " + bugId);
            }
            Set<PastInformation> logs = bug.getHistory().getInformations();
            logger.info("Bug history retrieved successfully");
        %>
        <table border="0" bgcolor="white" cellpadding="1" cellspacing="1" id="table-1" align="center" style="font-family:verdana;font-size:SMALL">
        <tr bgcolor="#0101DF" style="color: white">
            <th width="100">No</th>
            <th width="500">Details</th>
            <th width="100">Changed On</th>
            <th width="100">Changed BY</th>
        </tr>
        <% 
            int count = logs.size();
            String colors[] = {"white", "lightgrey"};
            for(PastInformation info : logs) { %>
        <tr bgcolor="<%=colors[count%2] %>" align="left">
            <td align="center"><%= count--%></td>
            <td width="500">&nbsp;&nbsp;<%= info.getChangeMessage() %></td>
            <td width="100">&nbsp;&nbsp;<%= info.getWhenCreated() %></td>
            <td width="100">&nbsp;&nbsp;<%= info.getUpdatedBy().getAuthorName() %></td>
        </tr>
        <% } %>
        </table>
        <div align="center"><input type="button" value="Close" onclick="window.close();"/></div>
    <%
    ConnectionProvider.closeSessionAndDissconnect(dbSession);
    %>
</body>
</html> 