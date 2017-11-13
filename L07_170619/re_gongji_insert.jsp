<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*"%>
<html>
<head>
<script type="text/javascript">
	function formCheck(str) {   

		var f = insertData.insertTitle.value;
		f = f.trim();
		var t = insertData.insertText.value;
		t = t.trim();
		if( f == ""){ 
			alert("제목을 입력해주세요");
		}
		else if( t == ""){
			alert("내용을 입력해주세요");
		}
		else{
			submitForm(str);
		}
	} 	
	function submitForm(mode){
		if(mode == "cancle"){
			insertData.action = "re_gongji_list.jsp";
			insertData.submit();
		}else if(mode == "write"){
			
			insertData.action = "re_gongji_write.jsp";
		}
		insertData.submit();
	}
	
</script>
</head>

<body>
<hr></hr>
<h2 align=center>신규내용 입력<h2>
<hr></hr>
<form method='post' name='insertData'>
<table cellspacing=0 WIDTH=600 border=1 align=center>

<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();	
	//현재 날짜 받아오기
	ResultSet rset = stmt.executeQuery(" select curdate() ");
	String getDate ="";
	rset.next();
	getDate =	rset.getString(1);
	rset = stmt.executeQuery(" select * from re_gongji  ");
	
	
	
%>
	<tr>
		<td width=80 align=center>번호</td>					
		<td width=600 align=left >신규(insert)</td>
		
	</tr>
	<tr>
		<td width=80 align=center>제목</td>					
		<td width=600 align=left><input type=text size=60 maxlength=70 name=insertTitle required></td>
		
	</tr>
	<tr>
		<td width=80 align=center>일자</td>					
		<td width=600 align=left><%=getDate%></td>
	</tr>
	<tr>
		<td width=80 align=center>내용</td>					
		<td width=600 align=left><textarea name=insertText
		style="width:100%;border:1;overflow:visible;text-overflow:
		ellipsis;overflow:scroll; resize:none;" rows=30 value=''required></textarea></td>
		
	</tr>
	</table>
	<table cellspacing=0 WIDTH=600 border=0 align=center>
	<tr>
	<td width = 500></td>
	<td align=right><input type="button" name=cancle value="취소" onClick=submitForm('cancle');></td>
	<td  align=right><input type="button" name=write value="쓰기" onClick=formCheck('write');></td>
	</tr>
</table>
</form>
<%	
	
	rset.close();
	stmt.close();
	conn.close();
%>
</body>
</html>