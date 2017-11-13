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
			updateData.action = "gongji_list.jsp";
			updateData.submit();
		}else if(mode == "write"){
			updateData.action = "gongji_update_query.jsp";
			updateData.submit();
		}else if(mode == "delete"){
			updateData.action = "gongji_delete.jsp";
			updateData.submit();
		}
		
	}
	

</script>
</head>

<body BACKGROUND="/L08_resort/notice2.jpg">
<hr></hr>
<h2 align=center>UPDATE<h2>
<hr></hr>
<form method='post' name='updateData'>

<table cellspacing=0 WIDTH=600 border=1 align=center>

<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();	
	int idValue = Integer.parseInt(request.getParameter("id"));
	ResultSet rset = stmt.executeQuery(" select * from gongji2 where id ="+idValue+" order by id desc ");
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
	

	
	
	
%>

	<tr>
		<td width=80 align=center>No.</td>					
		<td width=600 align=left><input type=text size=60 maxlength =70 name=fixID value='<%=idCnt%>' readonly></td>
		
	</tr>
	<tr>
		<td width=80 align=center>TITLE</td>					
		<td width=600 align=left><input type=text size=60 maxlength =70 name=fixTitle value='<%=title%>'></td>
		
	</tr>
	<tr>
		<td width=80 align=center>DATE</td>					
		<td width=600 align=left><%=getDate%></td>
	</tr>
	<tr>
		<td width=80 align=center>CONTENT</td>					
		<td width=600 align=left><textarea name=fixText
		style="width:100%;border:1;overflow:visible;text-overflow:
		ellipsis;overflow:scroll; resize:none;" rows=30 ><%=textValue%></textarea></td>
		
	</tr>
	</table>
	<table cellspacing=0 WIDTH=600 border=0 align=center>
	<tr>
	<td width = 500></td>
	<td align=right><input type="button" name=cancle value="CANCLE" onClick=submitForm("cancle");></td>
	<td  align=right><input type="button" name=write value="WRITE" onClick=formCheck("write");></td>
	<td  align=right><input type="button" name=write value="DELETE" onClick=submitForm("delete");></td>
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