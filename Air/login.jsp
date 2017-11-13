<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page import="java.text.*, javax.util.*, java.io.*, java.net.*" %>

<html>
<head>
</head>
<body BACKGROUND="image/bg11.png">
<%
	String jump = "main.jsp";
%>
	<center>
	<h2>로 그 인</h2>
	<form method="post" action="loginck.jsp">
	<table border=1>
		<tr>
			<td>아이디</td>
			<td><input type="text" name="id" maxlength=15 required></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="passwd" maxlength=15 required></td>
		</tr>
		<tr>
			<td colspan=2 align=center><input type="submit" value="로그인"></td>
		</tr>
	</table>
	<input type="hidden" name="jump" value='<%=jump%>'>
	</form>
	
	
	
</center>
</body>
</html>