<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.sb.message.log.MessageLogger"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.sb.constants.PropertyNames"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" session="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Page</title>
<link rel="icon" 
      type="image/png" 
      href="images\general\drop.png">
</head>
<body>
    <%! MessageLogger logger = new MessageLogger(getClass()); %>
    <form action="userLogin" method="post">
        <table bgcolor="#DAEEEF" align="center" >
            <tr valign="middle">
                <th colspan="2">Login page</th>
            </tr>
            <tr>
                <td>User Name</td>
                <td><input type="text" name="<%=PropertyNames.USER_NAME%>" value="Satya (TM)"></td>
            </tr>
            <tr>
                <td>Password</td>
                <td><input type="password" name="<%=PropertyNames.PASSWORD%>" value="password@12345"></td>
            </tr>
            <tr>
                <td colspan="2" align="right"><input type="submit" name="Login"></td>
            </tr>
             <tr>
                <td colspan="2" align="right">
                    <% String errorMessage = (String) session.getAttribute(PropertyNames.INVALID_USER_ERROR_MESSAGE);
                    
                    if (errorMessage != null) {
                        %>
                      <font color="red"><%= errorMessage %></font>  
                        <%
                    }
                    logger.info("Total number of session attributes are : " );
                    Enumeration<String> enumeration = session.getAttributeNames();
                    List<String> attributes = new ArrayList<String>();
                    while(enumeration.hasMoreElements()) {
                        String attr = enumeration.nextElement();
                        attributes.add(attr);
                    }
                    session.removeAttribute(PropertyNames.INVALID_USER_ERROR_MESSAGE);
                    session.removeAttribute(PropertyNames.PROJECT_ID);
                    session.removeAttribute(PropertyNames.ITERATION_ID);
                    %>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>