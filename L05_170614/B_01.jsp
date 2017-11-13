<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>

<html>
<head>
<title>투표하기 B_01.jsp</title>
</head>
<body>
<h1 align=center>투표하기</h1>
<table cellspacing=0 WIDTH=600 border=0 align=center>
<%
		String backPage="A_01.jsp";
		String nextPage="C_01.jsp";
		out.println("<tr>");
		out.println("<td width=50 align=left ><h2><a href="+backPage+">"+"이전"+"</a>"+"</td>");
		out.println("<td width=50 align=right ><h2><a href="+nextPage+">"+"다음"+"</a>"+"</td>");
		out.println("</tr>");
%>
</table>
	<table cellspacing=3 WIDTH=600 border=1 align=center>
		<tr>
			<td width=100 align=center><a href="A_01.jsp">후보등록</a></td>
			<td width=100 bgcolor="#EDDEFA" align=center><a href="B_01.jsp">투표</a></td>			
			<td width=100 align=center><a href="C_01.jsp">개표결과</a></td>
		</tr>
	</table>

	<table cellspacing=3 WIDTH=600 border=1 align=center>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();	
	ResultSet rset = stmt.executeQuery("select * from hubo_table");
	String huboName="";
	int huboID= 0;
%>
		<tr>
		<form method="post" action="B_02.jsp">
			<td width=200><p align=center>
			<select name=choice>
<%			while(rset.next()) {
				huboID = rset.getInt(1);
				huboName =	rset.getString(2);
				out.println("<option value="+huboID+">기호 "+huboID+"번 "+huboName+"");					
			}
%>
			</select>
			</p></td>
			<td width=200><p align=center>
			<select name=age>
<%				
				for(int i =1; i < 10; i++){
					out.println("<option value="+i+"> &nbsp;&nbsp;"+i+"0대&nbsp");
				}
				
		
%>				
			</select>
			</p></td>
			<td align=center>
			<input type=submit value="투표하기">
			</td>
		</form>
		</tr>
	</table>
</body>
</html>