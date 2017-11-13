<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>


<html>
<head>
<title>후보등록 A_02.jsp</title>
</head>
<body>
<table cellspacing=0 WIDTH=600 border=0 align=center>
<%
		String backPage="A_01.jsp";
		String nextPage="B_01.jsp";
		out.println("<tr>");
		out.println("<td width=50 align=left ><h2><a href="+backPage+">"+"이전"+"</a>"+"</td>");
		out.println("<td width=50 align=right ><h2><a href="+nextPage+">"+"다음"+"</a>"+"</td>");
		out.println("</tr>");
%>
</table>
	<table cellspacing=3 WIDTH=600 border=1 align=center>
		<tr>
			<td width=100 align=center bgcolor="#EDDEFA"><a href="A_01.jsp">후보등록</a></td>
			<td width=100 align=center><a href="B_01.jsp">투표</a></td>
			<td width=100 align=center><a href="C_01.jsp">개표결과</a></td>
		</tr>
	</table>
<%
Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();	
	
	int ctmp = Integer.parseInt(request.getParameter("id"));	
	//out.println(ctmp);
	String sql= " delete from hubo_table where id = "+ ctmp;
	stmt.executeUpdate( sql );
	
	stmt.close();
	conn.close();
%>
<h1 align=center>후보등록 삭제 완료</h1>
</body>
</html>