<%@ page language="java" contentType="text/html; charset=ISO-8859-1" session="true"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script src="tablednd.js">
</script>
</head>
<body>
<!-- Ref link http://isocra.com/2007/07/dragging-and-dropping-table-rows-in-javascript/ -->
<table id="table-1" >
    <tr> <td> This is a sample text </td></tr>
    <tr> <td> This is a sample text 1 </td></tr>
    <tr> <td> This is a sample text 2</td></tr>
    <tr> <td> This is a sample text 3</td></tr>
    <tr> <td> This is a sample text 4</td></tr>
    <tr> <td> This is a sample text 5</td></tr>
    <tr> <td> This is a sample text 6</td></tr>
    <tr> <td> This is a sample text 7</td></tr>
</table>
</body>
<script type="text/javascript">
var table = document.getElementById('table-1');
var tableDnD = new TableDnD();
tableDnD.init(table);
</script>
</html>