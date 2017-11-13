<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" pageEncoding="UTF-8"%>

<html>
<head>

</head>
<body>
<hr></hr>
<form action=t_update_query.jsp method=post>
<table cellspacing=0 WIDTH=600 border=1 align=center>

<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();	
	
	int aa = Integer.parseInt(request.getParameter("pid2"));
	ResultSet rset = stmt.executeQuery(" select * from twice where pid="+aa+"; ");
	rset.next();
	int viewID =rset.getInt(1);
	int saveID = viewID;
	int cntID = viewID+122120;
	//상품명 변수 및 특수문자 처리
	String viewPname = rset.getString(2);
	viewPname = viewPname.replaceAll("<", "&lt");
	viewPname = viewPname.replaceAll(">", "&gt");
	int viewStock =rset.getInt(3);
	
	String viewSdate = rset.getString(4);
	//String viewPdate = rset.getString(5);
	String viewContent = rset.getString(6);
	String viewImage = rset.getString(7);
	
	rset = stmt.executeQuery(" select curdate() ");
	String getDate ="";
	rset.next();
	getDate =	rset.getString(1);
	out.println("<tr>");
	out.println("<td width=100 align=left>상품번호</td>");	
	out.println("<td width=300 align=left><input type=text name=pid_up value="+cntID+"><input type=hidden name=pid_save value="+saveID+"></td>");	
	out.println("</tr>");
	
	out.println("<tr>");
	out.println("<td width=100 align=left>상품명</td>");
	out.println("<td width=300 align=left><input type=text name=Pname_up value="+viewPname+"></td>");
	out.println("</tr>");
	
	out.println("<tr>");
	out.println("<td width=100 align=left>재고현황</td>");	
	out.println("<td width=300 align=left><input type=text name=stock_up value="+viewStock+"></td>");
	out.println("</tr>");
	
	out.println("<tr>");
	out.println("<td width=100 align=left>상품등록일</td>");	
	out.println("<td width=300 align=left>"+viewSdate+"</td>");
	out.println("</tr>");

	out.println("<tr>");
	out.println("<td width=100 align=left>재고등록일</td>");	
	out.println("<td width=300 align=left>"+getDate+"</td>");
	out.println("</tr>");
	
	out.println("<tr>");
	out.println("<td width=100 align=left>상품설명</td>");	
	out.println("<td width=300 align=left><input type=text name=content_up value="+viewContent+"></td>");
	out.println("</tr>");
%>
	<tr>
	<td width=100 align=left>상품사진</td>
	<td width=300 align=left><img src=./image/<%=viewImage%>></td>
	</tr>
	
	

	</table>
<table cellspacing=0 WIDTH=600 border=0 align=center>
	<tr>
	<td align=left><input type="button" value="뒤로가기" onClick="location.href='t_list.jsp'"></td>
	<td width = 500></td>	
	<td align=right><input type="submit" value="완료"></td>
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