<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>
<html>
<head>
</head>
<body>
<hr></hr>
<h2 align=center>게시판 실습<h2>
<hr></hr>
<form action=re_gongji_view.jsp method=post>
<table cellspacing=0 WIDTH=600 border=1 align=center>
	<tr>
		<td width=80 align=center>번호</a></td>					
		<td width=600 align=center>제목</a></td>
		<td width=100 align=center>조회수</a></td>
		<td width=150 align=center>등록일</a></td>	
	</tr>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();	
	ResultSet rset = stmt.executeQuery(" select * from re_gongji order by id desc ");
	String title="", getDate ="",content="";
	
	int idCnt = 0, viewCnt=0;
	while(rset.next()) {
		idCnt = rset.getInt(1);
		title =	rset.getString(2);
		title = title.replaceAll("<", "&lt;");
		title = title.replaceAll(">", "&gt;");
		getDate = rset.getString(3);
		viewCnt = rset.getInt(7);
%>	
<input type=hidden name=aa value=<%=idCnt%>>
	<tr>
		<td width=80 align=center><%=idCnt%></a></td>					
		<td width=600 align=left><a href="re_gongji_view.jsp?name=<%=idCnt%> "><%=title%></a></td>
		<td width=80 align=center><%=viewCnt%></a></td>
		<td width=150 align=center><%=getDate%></a></td>	
		
	</tr>
<%
	}
%>
</table>
<table cellspacing=0 WIDTH=600 border=0 align=center>
	<tr>
	<td colspan=3 align=right><input type="button" value="신규" onClick="location.href='re_gongji_insert.jsp'"></td>
	</tr>
</table>
</form>

</body>
</html>