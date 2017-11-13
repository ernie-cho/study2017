<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page import="java.text.*, javax.util.*, java.io.*, java.net.*" %>

<html>
<head>
<script>
function aa(){
	parent.top_frame.location.href="top.jsp";
	parent.main.location.href="main.jsp";
}
</script>
</head>
<body BACKGROUND="image/bg11.png">
<center>
<%
	session.invalidate();
%>		
<script>aa();</script>
</center>
</body>
</html>