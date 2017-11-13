<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>
<html>
<head>
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();	
	
	String titlePrint = request.getParameter("insertTitle");
	String titleRead = new String(titlePrint.getBytes("8859_1"),"utf-8");
	String contentPrint = request.getParameter("insertText");
	String contentRead = new String(contentPrint.getBytes("8859_1"),"utf-8");

	String sql= " insert into gongji(title, date, content) values('"+titleRead+"',date(now()),'"+contentRead+"') ";
	stmt.executeUpdate( sql );
	
	stmt.close();
	conn.close();
%>
<hr></hr>
<h2 align=center>SUCCESS<h2>
<hr></hr>
<table cellspacing=0 border=0 align=center>
	<tr>
	<td colspan=3 align=center><input type="button" value="처음으로" onClick="location.href='gongji_list.jsp'"></td>
	</tr>
	</table>
</body>
</html>

