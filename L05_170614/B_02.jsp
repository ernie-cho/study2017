<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>

<html>
<head>
<title>투표 B_02.jsp</title>
</head>
<body>
<table cellspacing=0 WIDTH=600 border=0 align=center>
<%
		String backPage="B_01.jsp";
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
<%
Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();	
	
	int age = Integer.parseInt(request.getParameter("age"));
	if(request.getParameter("choice")==null){
		String name = "";
		out.println("<h1 align=center>투표 할 대상이 없습니다.</h1>");
	}else{
		String name = request.getParameter("choice");
		String huboName = new String(name.getBytes("8859_1"),"utf-8");
		int huboNum = Integer.parseInt(huboName);

		String sql= " insert into tupyo_table (id, age) "
					+ "values ("+huboNum+",'"+age+"')";
		stmt.executeUpdate( sql );
		out.println("<h1 align=center>투표에 성공하였습니다.</h1>");
	}

	stmt.close();
	conn.close();
%>

<br>

</body>
</html>