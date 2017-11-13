<!DOCTYPE html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*"%>
<html>
<head>
	<title>회원 탈퇴</title>
	<script type="text/javascript">	
	
	function submitForm(mode){
		if(mode == "back"){
			register_pw.action = "main.jsp";			
		}register_pw.submit();
	}

	</script>
</head>
<body BACKGROUND="image/bg11.png">
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();	
	
	String chkID = request.getParameter("deleteID");
	String deleteID = new String(chkID.getBytes("8859_1"),"utf-8");
	String chkpasswd = request.getParameter("pw");
	String deletePW = new String(chkpasswd.getBytes("8859_1"),"utf-8");
	ResultSet rset = stmt.executeQuery(" select * from airsign where id = '"+deleteID+"' ");
	rset.next();
	String chkPW = rset.getString(2);
	try{
		String chkID2 = rset.getString(1);
		if(!(chkPW.equals(deletePW))){
%>		<script>alert("비밀번호가 일치하지 않습니다.");
		history.go(-2);</script>	
<%		}else{
		String sql= " delete from airsign where id ='"+deleteID+"' ";
			stmt.executeUpdate( sql );
		}
	}catch(SQLException e){
		}	
		rset.close();
		stmt.close();
		conn.close();
%>
	<h1 align=center>UNITED 회원탈퇴</h1>
	<hr />
	<br />
		<form method='post' name='register_pw'>
			<table cellspacing=0 WIDTH=400 border=0 align=center>
			<h3 align=center>정상적으로 탈퇴하였습니다.</h3>
				<tr>
					<td colspan="2" align="center">
						<input type="button" name=back value="처음으로" onClick=submitForm('back');>
					</td>
				</tr>
			</table>
		</form>
<%
		stmt.close();
		conn.close();
%>
</body>
</html>
