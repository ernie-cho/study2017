<!DOCTYPE html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*"%>
<html>
<head>
	<title>회원 탈퇴</title>
	<script type="text/javascript">
	function formCheck(str) {   

		var f = register_out.deleteID.value;
		f = f.trim();

		if( f == ""){ 
			alert("아이디를 입력해주세요");
		}else if( f == "admin"){ 
			alert("운영자는 탈퇴 할 수 없습니다.");
		}
		
		else{
			submitForm(str);
		}
	} 		
	function submitForm(mode){
		if(mode == "out"){
			register_out.action = "login_pw.jsp";			
		}register_out.submit();
	}

	</script>
</head>
<body BACKGROUND="image/bg11.png">
	<h1 align=center>UNITED 회원탈퇴</h1>
	<hr />
	<br />
	<form method='post' name='register_out'>
		<fieldset>
			<legend align=center>회원탈퇴</legend>
			<table cellspacing=0 WIDTH=400 border=0 align=center>
				<tr>
					<td><label for="id">아이디</label></td>
					<td><input type="text" name=deleteID required></td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<input type="button" name=out value="탈퇴신청" onClick=formCheck('out');>
					</td>
				</tr>
			</table>
		</fieldset>
	</form>
</body>
</html>
