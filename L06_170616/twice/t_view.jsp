<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.text.*" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" pageEncoding="UTF-8"%>

<html>
<head>
	<script>
	function submitForm(mode){
		if(mode == "delete"){
			view.action ="t_delete.jsp";
			view.submit();
		}else if(mode == "update"){
			view.action = "t_update.jsp";
			view.submit();
		}
	}
	
	
	</script>
	<style type="text/css">
	td{
		max-width: 250px;
		height: 1px;
		text-overflow: ellipsis;
		overflow: hidden;
		white-space: nowrap;
		table-layout:fixed;
	}
</style>
</head>
<body>
<hr></hr>

<form action=t_update.jsp name='view' method=post>
<table cellspacing=0 WIDTH=600 border=1 align=center>

<%
	DecimalFormat df = new DecimalFormat("###,###,###,###,###");
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();	
	
	int aa = Integer.parseInt(request.getParameter("name"));
	aa = (aa-122120);
	ResultSet rset = stmt.executeQuery(" select * from twice where pid="+aa+"; ");
	rset.next();
	int viewID =rset.getInt(1);
	int viewID2 = viewID+122120;
	//상품명 변수 및 특수문자 처리
	String viewPname = rset.getString(2);
	viewPname = viewPname.replaceAll("<", "&lt");
	viewPname = viewPname.replaceAll(">", "&gt");
	int viewStock =rset.getInt(3);
	
	String viewSdate = rset.getString(4);
	String viewPdate = rset.getString(5);
	String viewContent = rset.getString(6);
	String viewImage = rset.getString(7);
	
	out.println("<tr>");
	out.println("<td width=100 align=left>상품번호</td>");	
	out.println("<td width=300 align=left><input type=hidden name=pid2 value="+viewID+">"+viewID2+"</td>");	
	out.println("</tr>");
	
	out.println("<tr>");
	out.println("<td width=100 align=left>상품명</td>");
	out.println("<td width=300 align=left>"+viewPname+"</td>");
	out.println("</tr>");
	
	out.println("<tr>");
	out.println("<td width=100 align=left>재고현황</td>");	
	out.println("<td width=300 align=left ID=stock>"+df.format(viewStock)+"</td>");
	out.println("</tr>");
	
	out.println("<tr>");
	out.println("<td width=100 align=left>상품등록일</td>");	
	out.println("<td width=300 align=left>"+viewSdate+"</td>");
	out.println("</tr>");

	out.println("<tr>");
	out.println("<td width=100 align=left>재고등록일</td>");	
	out.println("<td width=300 align=left>"+viewPdate+"</td>");
	out.println("</tr>");
	
	out.println("<tr>");
	out.println("<td width=100 align=left>상품설명</td>");	
	out.println("<td width=300 align=left>"+viewContent+"</td>");
	out.println("</tr>");
%>
	<tr>
	<td width=100 align=left>상품사진</td>
	<td width=300 align=left><img src=./image/<%=viewImage%> style="width: 80%; height: auto;"></td>
	</tr>
	
	

	</table>
<table cellspacing=0 WIDTH=600 border=0 align=center>
	<tr>
	<td align=left><input type="button" value="뒤로가기" onClick="location.href='t_list.jsp'"></td>
	<td width = 500></td>	
	<td align=right><input type="submit" value="상품삭제" onclick=submitForm('delete')></td>
	<td align=right><input type="submit" value="재고수정" onclick=submitForm('update')></td>
	</tr>
</table>
</form>
<%	
	rset.close();
	stmt.close();
	conn.close();
%>
<hr></hr>
</body>
</html>