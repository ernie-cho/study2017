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
			insertData.action = "gongji_list.jsp";
			insertData.submit();
		}else if(mode == "write"){
			
			insertData.action = "gongji_write.jsp";
		}
		insertData.submit();
	}
	
</script>
</head>

<body>
<hr></hr>
<h2 align=center>COMMENT<h2>
<hr></hr>
<form method='post' name='insertData'>
<table cellspacing=0 border=1 align=center>

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
	rset = stmt.executeQuery(" select * from gongji  ");
	
	
	
%>
	<tr>
		<td align=center>No.</td>					
		<td align=left >NEW</td>
		
	</tr>
	<tr>
		<td align=center>TITLE</td>					
		<td align=left><input type=text maxlength=70 name=insertTitle required></td>
		
	</tr>
	<tr>
		<td align=center>DATE</td>					
		<td align=left><%=getDate%></td>
	</tr>
	<tr>
		<td align=center>CONTENT</td>					
		<td align=left><textarea name=insertText
		style="border:1;overflow:visible;text-overflow:
		ellipsis;overflow:scroll; resize:none;" rows=30 value=''required></textarea></td>
		
	</tr>
	</table>
	<table cellspacing=0 border=0 align=center>
	<tr>
	<td ></td>
	<td align=right><input type="button" name=cancle value="CANCLE" onClick=submitForm('cancle');></td>
	<td  align=right><input type="button" name=write value="WRITE" onClick=formCheck('write');></td>
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