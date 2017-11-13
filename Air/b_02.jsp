<!DOCTYPE html5>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*"%>
<html>
<head>
<script type="text/javascript">
	function formCheck(str) {   
		var f = reserve.one.value;
		var t = reserve.rDate.value;
		if( f == ""){ 
			alert("티켓 타입을 선택해주세요");
		}
		else if( t == ""){
			alert("예약일을 선택해주세요");
		}
		else{
			submitForm(str);
		}
	} 	
	function submitForm(mode){
		if(mode == "cancle"){
			reserve.action = "main.jsp";
			reserve.submit();
		}else if(mode == "write"){
			
			reserve.action = "b_03.jsp";
		}
		reserve.submit();
	}

</script>
	<title>예약하기</title>
</head>
<body BACKGROUND="image/bg11.png">

	<h1 align=center>예 약 하 기</h1>
	<hr />
	<br />
	<form method='post' name='reserve'>
		<fieldset>
			<legend align=center>검색</legend>
			<table cellspacing=0 WIDTH=400 border=0 align=center>
				<tr>
					<td>티켓 타입</td>
					<td><input type=radio name=one value="편도">편도
					<input type=radio name=one value="왕복">왕복</td>
				</tr>
				<tr>
					<td><label for="id">경로</label></td>					
					<td>
					<p align=left>
					<select name=choice>
					<option value="김포 to 제주">김포 to 제주 </option>
					<option value="제주 to 김포">제주 to 김포 </option>
					</select>
					</p>					
					</td>
				</tr>					
				<tr>
					<td><label for="id">시간</label></td>					
					<td>
					<p align=left>
					<select name=time>
					<option value="오전 10시(오전 11시 도착)">오전 10시(오전 11시 도착)</option>
					<option value="오후 14시(오후 15시 도착)">오후 14시(오후 15시 도착)</option>
					<option value="오후 18시(오후 19시 도착)">오후 18시(오후 19시 도착)</option>
					</select>
					</p>
					</td>
				</tr>
				<tr>
					<td>예약일</td>
					<td><input type=date name=rDate ></td>
				</tr>
				<tr>
					<td colspan="2" align="right">					
						<input type="button" name=write value="다음" onClick=formCheck('write');>
						<input type="button" name=cancle value="취소" onClick=submitForm('cancle');>
					</td>
				</tr>
			</table>
		</fieldset>

	</form>
</body>
</html>
