<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="true" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="icon" 
      type="image/png" 
      href="images\general\drop.png">
</head>
<body >
<div align="center">
    <a href="index.jsp">
    <img alt="Invalid User" src="images/error/key_error.png">
     <b> OOPs!! you does not have enough privilege please login again</b></a>
     
     <textarea rows="10" cols="114" readonly="readonly">
        <%=exception.fillInStackTrace()%>
     </textarea>
</div>

</body>
</html>