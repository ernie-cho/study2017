<%@ page import="java.net.*, java.io.*, java.util.*, java.text.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
<script type="text/javascript">
	function formCheck(str) {   

		var f = insertData.code.value;
		f = f.trim();
		var t = insertData.begin.value;
		t = t.trim();
		var s = insertData.finish.value;
		s = s.trim();
		if( f == ""){ 
			alert("종목코드를 입력해주세요");
		}
		else if( t == ""){
			alert("시작일을 입력해주세요");
		}
		else if( s == ""){
			alert("종료일을 입력해주세요");
		}
		else{
			submitForm(str);
		}
	} 	
	function submitForm(mode){
		if(mode == "search"){
			
			insertData.action = "result.jsp";
		}
		insertData.submit();
	}

</script>
</head>
<body>
<form method='post' name='insertData'>
	<table cellspacing=1 width=800 border=1>
		<tr>
		<td>종목코드<input type=text maxlength=10 name=code value='005930'required></td>
		<td>시작일자<input type=date maxlength=10 name=begin required></td>
		<td>시작일자<input type=date maxlength=10 name=finish required></td>
		<td><input type=button name=search value=조회 onClick=formCheck('search');></td>
		</tr>
	</table>
</form>
</body>
</html>
