<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page import="java.text.*, javax.util.*, java.io.*, java.net.*" %>

<html>
<head>
</head>
<body BACKGROUND="/L08_resort/notice.jpg">
<%
	String jump = request.getParameter("jump");
%>
	<center>
	<h2>ADMIN MODE</h2>
	<form method="post" action="loginck.jsp">
	<table border=1>
		<tr>
			<td>ID</td>
			<td><input type="text" name="id" maxlength=15 ></td>
		</tr>
		<tr>
			<td>PASSWORD</td>
			<td><input type="password" name="passwd" maxlength=15 ></td>
		</tr>
		<tr>
			<td colspan=2 align=center><input type="submit" value="Login"></td>
		</tr>
	</table>
	<input type="hidden" name="jump" value='<%=jump%>'>
	</form>
	
	
	
</center>
</body>
</html>