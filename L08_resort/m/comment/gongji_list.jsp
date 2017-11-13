<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>


<html>
<head>
</head>
<body background="image/yellow.png">
<hr></hr>
<h2 align=center>RESORT NEWS<h2>
<hr></hr>
<form action=gongji_view.jsp method=post>
<table cellspacing=0  border=1 align=center>
	<tr>
		<td align=center>No.</a></td>					
		<td align=center>TITLE</a></td>
		<td align=center>DATE</a></td>	
	</tr>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();	
	ResultSet rset = stmt.executeQuery(" select * from gongji order by id desc ");
	String title="", getDate ="",content="";
	
	int idCnt = 0;
	while(rset.next()) {
		idCnt = rset.getInt(1);
		title =	rset.getString(2);
		title = title.replaceAll("<", "&lt;");
		title = title.replaceAll(">", "&gt;");
		getDate = rset.getString(3);
		
%>	
<input type=hidden name=aa value=<%=idCnt%>>
	<tr>
		<td align=center><%=idCnt%></a></td>					
		<td align=left><a href="gongji_view.jsp?name=<%=idCnt%> "><%=title%></a></td>
		<td align=center><%=getDate%></a></td>	
		
	</tr>
<%
	}
%>
</table>
<table cellspacing=0 border=0 align=center>
	<tr>
	<td colspan=3 align=right><input type="button" value="WRITE" onClick="location.href='gongji_insert.jsp'"></td>
	</tr>
</table>
</form>

</body>
</html>