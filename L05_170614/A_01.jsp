﻿<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>

<html>
<head>
<title>후보등록 A_01.jsp</title>
</head>
<body>
<h1 align=center>후보등록</h1>
<table cellspacing=0 WIDTH=600 border=0 align=center>
<%		
		String nextPage="B_01.jsp";
		out.println("<tr>");	
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
	ResultSet rset = stmt.executeQuery("select * from hubo_table");
	String huboID="", huboName="";
%>	
	
		<table cellspacing=1 WIDTH=600 border=1 align=center>
			<tr><td bgcolor = '#EDDEFA'>
			<p align=center >후보명 입력</p></td>
			</td></tr>
			<tr><td>
	
<%	int countID=1;
	while(rset.next()) {
		huboID = Integer.toString(rset.getInt(1));
		//삭제한 후보가 있으면 새로 추가되는 후보는 
		//삭제된 그 후보 번호를 할당받음
		while(rset.getInt(1) == countID){
			countID++;
		}
		huboName =	rset.getString(2);
%>	
			<form method="post" action="A_02.jsp">	
			기호: <input type="text" name="id" value='<%=huboID%>' readonly>
			이름: <input type="text" name="name" value='<%=huboName%>' readonly>
			<input type="submit" value="삭제">
			</form>	
<%	
	}
	rset.close();
	stmt.close();
	conn.close();
%>				
			<form method="post" action="A_03.jsp">
				기호: <input type="text" name="id" value='<%=countID%>' readonly>
				이름: <input type="text" name="name" value='' >
				<input type="submit" value="추가">
			</form>			
	</td></tr>
	</table>
	
	

	
	


		
		
		
</body>
</html>