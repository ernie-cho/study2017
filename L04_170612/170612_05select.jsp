<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>

<html>
<head>
</head>
<body>
<h1>Twice Score</h1>

<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection k20_conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement k20_stmt = k20_conn.createStatement();
	ResultSet rset = k20_stmt.executeQuery("select * from examtable2;");
%>
<table cellspacing=1 width=600 border=1>
<%
		out.println("<tr bgcolor = '#EDDEFA'>");
		out.println("<td width=50><p align=center>"+"이름"+"</p></td>");
		out.println("<td width=50><p align=center>"+"학번"+"</p></td>");
		out.println("<td width=50><p align=center>"+"국어"+"</p></td>");
		out.println("<td width=50><p align=center>"+"영어"+"</p></td>");
		out.println("<td width=50><p align=center>"+"수학"+"</p></td>");
		out.println("<td width=50><p align=center>"+"총점"+"</p></td>");
		out.println("<td width=50><p align=center>"+"평균"+"</p></td>");
		out.println("</tr>");	
	while (rset.next()){
		int korScore = rset.getInt(3);	
		int engScore = rset.getInt(4);
		int matScore = rset.getInt(5);
		int total = korScore+engScore+matScore;
		int avg = total/3;
		String cURL="170612_06each.jsp?key="+Integer.toString(rset.getInt(2));
		out.println("<tr>");		
		out.println("<td width=50 align=center>"+"<a href="+cURL+">"+rset.getString(1)+"</a>"+"</td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(2))+"</p></td>");
		out.println("<td width=50><p align=center>"+korScore+"</p></td>");
		out.println("<td width=50><p align=center>"+engScore+"</p></td>");
		out.println("<td width=50><p align=center>"+matScore+"</p></td>");
		out.println("<td width=50><p align=center>"+total+"</p></td>");
		out.println("<td width=50><p align=center>"+avg+"</p></td>");
		out.println("</tr>");
		
	}
	
	rset.close();
	k20_stmt.close();
	k20_conn.close();
%>
</table>
</body>
</html>