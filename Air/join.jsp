<!DOCTYPE html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*"%>
<html>
<head>
<script type="text/javascript">
	function formCheck(str) {   

		var f = insertData.insertID.value;
		f = f.trim();
		var t = insertData.insertPW.value;
		t = t.trim();
		var s = insertData.insertPW2.value;
		s = s.trim();
		if( f == ""){ 
			alert("아이디를 입력해주세요");
		}
		else if( t == ""){
			alert("패스워드를 입력해주세요");
		}
		else if( t != s){
			alert("패스워드가 일치 하지 않습니다");
		}
		else{
			submitForm(str);
		}
	} 	
	function submitForm(mode){
		if(mode == "cancle"){
			insertData.action = "main.jsp";
			insertData.submit();
		}else if(mode == "write"){
			
			insertData.action = "join_insert.jsp";
		}
		insertData.submit();
	}

</script>
	<title>회원 가입</title>
</head>
<body BACKGROUND="image/bg11.png">

	<h1 align=center>UNITED 회원가입</h1>
	<hr />
	<br />
	<form method='post' name='insertData'>
		<fieldset>
			<legend align=center>회원가입</legend>
			<table cellspacing=0 WIDTH=400 border=0 align=center>
				<tr>
					<td><label for="id">아이디</label></td>
					<td><input type=text  maxlength=50 name=insertID required></td>
				</tr>

				<tr>
					<td><label for="pwd">비밀번호</label></td>
					<td><input type=password  maxlength=50 name=insertPW required></td>
				</tr>
				<tr>
					<td><label for="pwd">비밀번호 확인</label></td>
					<td><input type=password  maxlength=50 name=insertPW2 required></td>
				</tr>
				<tr>
					<td><label for="email">이메일</label></td>
					<td><input type=text  maxlength=50 name=email required></td>
				</tr>
				<tr>
					<td colspan="2" align="right">					
						<input type="button" name=write value="가입" onClick=formCheck('write');>
						<input type="button" name=cancle value="취소" onClick=submitForm('cancle');>
					</td>
				</tr>
			</table>
		</fieldset>

	</form>
</body>
</html>
