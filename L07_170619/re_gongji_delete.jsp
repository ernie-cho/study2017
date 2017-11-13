<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>
<html>
<head>
</head>
<body>
<hr></hr>
<h2 align=center>삭제완료<h2>
<hr></hr>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();
	int newID = Integer.parseInt(request.getParameter("view"));
	
	
	String sql= " delete from re_gongji where id ="+newID+" ";
	stmt.executeUpdate( sql );
	
	stmt.close();
	conn.close();
%>

<table cellspacing=0 WIDTH=600 border=0 align=center>
	<tr>
	<td  align=center><input type="button" value="목록으로" onClick="location.href='re_gongji_list.jsp'"></td>
	</tr>
</table>

</body>
</html>	