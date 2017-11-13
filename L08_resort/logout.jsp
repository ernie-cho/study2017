<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page import="java.text.*, javax.util.*, java.io.*, java.net.*" %>

<html>
<head>
</head>
<body BACKGROUND="/L08_resort/notice.jpg">
<center>
<%
	session.invalidate();
	out.println("<h2>Logout.</h2>");
	//로그아웃 후 일반적으로 홈으로 간다(여기서는 login_test.jsp)
	out.println("<input type=button value='Login' OnClick=\"location.href='login_test.jsp'\">");
%>		
	
</center>
</body>
</html>