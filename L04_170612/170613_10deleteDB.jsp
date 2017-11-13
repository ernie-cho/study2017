<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*" %>

<html>
<head>
</head>
<body>
<h1>레코드 삭제</h1>

<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection k20_conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement k20_stmt = k20_conn.createStatement();	

	int ctmp = Integer.parseInt(request.getParameter("twiceID"));
	//String ctmp = request.getParameter(" twiceID ");
	String sql= " delete from examtable2 where studentid = "+ ctmp;
	
	k20_stmt.executeUpdate( sql );
	
	ResultSet rset = k20_stmt.executeQuery(" select * from examtable2; ");
%>
	<table cellspacing=1 width=600 border=1>
		<tr>
			<td width=50><p align=center>이름</p></td>
			<td width=50><p align=center>학번</p></td>
			<td width=50><p align=center>국어</p></td>
			<td width=50><p align=center>영어</p></td>
			<td width=50><p align=center>수학</p></td>
		</tr>
<%
	while(rset.next()){
		out.println("<tr>");
			
			String cURL="170612_06each.jsp?key="+Integer.toString(rset.getInt(2));
			
			out.println("<td width=50><p align=center>"+"<a href="+cURL+">"+rset.getString(1)+"</a></p></td>");
			out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(2))+"</p></td>");
			out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(3))+"</p></td>");			
			out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(4))+"</p></td>");
			out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(5))+"</p></td>");
			out.println("</tr>");
	}
	rset.close();
	k20_stmt.close();
	k20_conn.close();
%>
</body>
</html>