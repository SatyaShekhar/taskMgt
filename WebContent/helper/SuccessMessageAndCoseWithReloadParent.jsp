<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" session="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript">
	function reloadParentAndClose() {
		window.opener.location.href = window.opener.location.href;
		if (window.opener.progressWindow) {
			window.opener.progressWindow.close()
		}
		window.close();
	}
</script>
</head>
<body>
    <h3 style='color: green' align="center">Action completed successfully. Click close to return to main page.</h3>
    <br>
    <div align="center">
        <input type='button' value='close' onclick='reloadParentAndClose();' align="middle" />
    </div>
</body>
</html>