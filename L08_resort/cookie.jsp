<%@ page contentType="text/html; charset=UTF-8" %>
	<%
	String myName = "resort.SJCU";
	Cookie cookieName = new Cookie("name", myName);
	cookieName.setMaxAge(-1);
	response.addCookie(cookieName);
	%>
<html>
<head>
<title>쿠키 저장</title>
</head>
<body>JSP쿠키사용</body>
</html>
