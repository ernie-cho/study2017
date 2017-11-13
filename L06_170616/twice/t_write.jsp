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
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();	
	
	String path = application.getRealPath("L06_170616/twice/image");
	MultipartRequest mr = new MultipartRequest(request, path, 1024*1024*5, "utf-8", new DefaultFileRenamePolicy());
	
	File s_file = mr.getFile("s_file"); 

	String o_name = mr.getOriginalFileName("s_file");
	
	//신규 상품명
	String name = mr.getParameter("insertName");
	//String newName = new String(name.getBytes("8859_1"),"utf-8");
	//신규 재고현황
	int newCstock = Integer.parseInt(mr.getParameter("insertCstock"));
	String contentPrint = mr.getParameter("insertContent");
	//String contentRead = new String(contentPrint.getBytes("8859_1"),"utf-8");

	String sql= " insert into twice(pname, cstock, sdate, pdate, content, image) values('"+name+"',"+newCstock+", date(now()) , date(now()),'"+contentPrint+"','"+o_name+"' ) ";
	stmt.executeUpdate( sql );
	
	stmt.close();
	conn.close();
%>
<hr></hr>
<h2 align=center>입력완료<h2>
<hr></hr>
<table cellspacing=0 WIDTH=600 border=0 align=center>
	<tr>
	<td colspan=3 align=center><input type="button" value="처음으로" onClick="location.href='t_list.jsp'"></td>
	</tr>
	</table>
</body>
</html>



<%


%> 