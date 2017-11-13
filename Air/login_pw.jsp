<!DOCTYPE html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*"%>
<html>
<head>
	<title>회원 탈퇴</title>
	<script type="text/javascript">	
	function formCheck(str) {   

		var f = register_pw.pw.value;
		f = f.trim();

		if( f == ""){ 
			alert("비밀번호를 입력해주세요");
		}		
		else{
			submitForm(str);
		}
	} 	
	function submitForm(mode){
		if(mode == "out"){
			register_pw.action = "login_deleteID.jsp";			
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
	
	ResultSet rset = stmt.executeQuery(" select * from airsign where id = '"+deleteID+"' ");
	rset.next();
	try{
		String checkID = rset.getString(1);
%>
		<script>alert("<%=deleteID%>님 탈퇴하시겠습니까?");</script>		
<%	
	}catch(SQLException e){
%>
		<script>alert("가입되어 있지 않은 회원입니다.");
		history.go(-1);</script>	
<%
		}	
		rset.close();
		stmt.close();
		conn.close();
%>
	<h1 align=center>UNITED 회원탈퇴</h1>
	<hr />
	<br />
	<form method='post' name='register_pw'>
		<fieldset>
			<legend align=center><%=deleteID%>님의 비밀번호를 입력 해주세요</legend>
			<table cellspacing=0 WIDTH=400 border=0 align=center>
				<tr>
					<td><label for="id">비밀번호</label></td>
					<td><input type="password" name=pw required>
					<input type="hidden" name=deleteID value=<%=deleteID%> ></td>
					
				</tr>
				<tr>
					<td colspan="2" align="right">
						<input type="button" name=out value="탈퇴" onClick=formCheck('out');>
					</td>
				</tr>
			</table>
		</fieldset>
	</form>
<%
		stmt.close();
		conn.close();
%>
</body>
</html>
