<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>
<html>
<head>
<script>
	function formCheck(str) {   

		var f = updateData.fixTitle.value;
		f = f.trim();
		var t = updateData.fixText.value;
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
			updateData.action = "re_gongji_list.jsp";
			updateData.submit();
		}else if(mode == "write"){
			updateData.action = "re_gongji_update_query.jsp";
			updateData.submit();
		}else if(mode == "delete"){
			updateData.action = "re_gongji_delete.jsp";
			updateData.submit();
		}
		
	}
	

</script>
</head>

<body>
<hr></hr>
<h2 align=center>댓글 입력<h2>
<hr></hr>
<form method='post' name='updateData'>

<table cellspacing=0 WIDTH=600 border=1 align=center>

<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();	
	int idValue = Integer.parseInt(request.getParameter("id"));
	ResultSet rset = stmt.executeQuery(" select * from re_gongji where id ="+idValue+" order by id desc ");
	rset.next();
	int idCnt = rset.getInt(1);
	String title = rset.getString(2);
	title = title.replaceAll("<", "&lt");
	title = title.replaceAll(">", "&gt");
	
	String getDate = rset.getString(3);	
	String textValue = rset.getString(4);	
	textValue = textValue.replaceAll("<", "&lt");
	textValue = textValue.replaceAll(">", "&gt");
	//textValue = textValue.replaceAll("\n", "<br>");
	textValue = textValue.replaceAll("<br>", "\n");
	int rootID = 0, nodeID = 0;
	rootID = rset.getInt(5);
	nodeID = rset.getInt(6);
%>

	<tr>
		<td width=80 align=center>번호</td>					
		<td width=600 align=left>댓글(INSERT)</td>
		
	</tr>
	<tr>
		<td width=80 align=center>제목</td>					
		<td width=600 align=left><input type=text size=60 maxlength =70 name=fixTitle value=''></td>
		
	</tr>
	<tr>
		<td width=80 align=center>일자</td>					
		<td width=600 align=left><%=getDate%></td>
	</tr>
	<tr>
		<td width=80 align=center>내용</td>					
		<td width=600 align=left><textarea name=fixText
		style="width:100%;border:1;overflow:visible;text-overflow:
		ellipsis;overflow:scroll; resize:none;" rows=30 ></textarea></td>		
	</tr>
	<tr>
		<td width=80 align=center>원글</td>					
		<td width=600 align=left><%=rootID%></td>
	</tr>
	<tr>
		<td width=100 align=center>댓글수준</td>					
		<td width=600 align=left><%=nodeID%></td>
	</tr>
	</table>
	<table cellspacing=0 WIDTH=600 border=0 align=center>
	<tr>
	<td width = 500></td>
	<td align=right><input type="button" name=cancle value="취소" onClick=submitForm("cancle");></td>
	<td  align=right><input type="button" name=write value="쓰기" onClick=formCheck("write");></td>
	<td  align=right><input type="button" name=write value="삭제" onClick=submitForm("delete");></td>
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