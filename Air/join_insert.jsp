<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>
<html>
<head>
</head>
<body BACKGROUND="image/bg11.png">
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();	
	
	String chkID = request.getParameter("insertID");
	String newID = new String(chkID.getBytes("8859_1"),"utf-8");
	String chkPW = request.getParameter("insertPW");
	String newPW = new String(chkPW.getBytes("8859_1"),"utf-8");
	String chkEmail = request.getParameter("email");
	String newEM = new String(chkEmail.getBytes("8859_1"),"utf-8");
	
	ResultSet rset = stmt.executeQuery(" select * from airsign where id = '"+newID+"' ");
	rset.next();
	try{
		String a = rset.getString(1);
		%>
		<script>alert("이미 사용중인 아이디입니다.");
		history.go(-1);
		</script>
<%	
	}catch(SQLException e){
		String sql= " insert into airsign(id, passwd, passwd2, email) values('"+newID+"','"+newPW+"','"+newPW+"','"+newEM+"') ";
		stmt.executeUpdate( sql );
		
		rset.close();
		stmt.close();
		conn.close();
%>
<hr></hr>
<h2 align=center>회원 가입 완료<h2>
<hr></hr>
	<table cellspacing=0 WIDTH=600 border=0 align=center>
	<tr>
	<td colspan=3 align=center><input type="button" value="메인으로" onClick="location.href='/Air/main.jsp'"></td>
	</tr>
	</table>
<%
	}
%>
	
</body>
</html>

