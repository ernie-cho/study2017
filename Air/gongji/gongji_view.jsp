<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>


<html>
<head>

</head>
<body BACKGROUND="/Air/image/bg11.png">
<hr></hr>
<h2 align=center>공지사항<h2>
<hr></hr>
<form action=gongji_update.jsp method=post>
<table cellspacing=0 WIDTH=600 border=1 align=center>

<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();	
	
	int aa = Integer.parseInt(request.getParameter("name"));

	ResultSet rset = stmt.executeQuery(" select * from gongji where id="+aa+"; ");
	rset.next();
	int viewID =rset.getInt(1);
	//타이틀 변수 및 특수문자 처리
	String viewTitle = rset.getString(2);
	viewTitle = viewTitle.replaceAll("<", "&lt");
	viewTitle = viewTitle.replaceAll(">", "&gt");
	//텍스트 변수 및 특수문자 처리
	String viewText = rset.getString(4);
	viewText = viewText.replaceAll("<", "&lt");
	viewText = viewText.replaceAll(">", "&gt");
	viewText = viewText.replaceAll("<br>", "\n");
	//viewText = viewText.replaceAll("\n", "<br>");
	out.println("<tr>");
	out.println("<td width=100 align=left>No.</td>");	
	out.println("<td width=300 align=left>"+viewID+"</td>");	
	out.println("</tr>");
	
	out.println("<tr>");
	out.println("<td width=100 align=left>TITLE</td>");
	out.println("<td width=300 align=left>"+viewTitle+"</td>");
	out.println("</tr>");
	
	out.println("<tr>");
	out.println("<td width=100 align=left>DATE</td>");	
	out.println("<td width=300 align=left>"+rset.getString(3)+"</td>");
	out.println("</tr>");
%>
	<tr>
	<td width=100 align=left>CONTENT</td>
	<td width=300 align=left><textarea style="width:100%;border:1;overflow:visible;text-overflow:
		ellipsis;overflow:scroll; resize:none;" rows=30 readonly><%=viewText%></textarea></td>
	</tr>
	
	

	</table>
<table cellspacing=0 WIDTH=600 border=0 align=center>
	<tr>
	<td width = 500></td>
	<td  align=right><input type="button" value="LIST" onClick="location.href='gongji_list.jsp'"></td>
	<td  align=right><input type="button" value="UPDATE" onClick="location.href='gongji_update.jsp?id=<%=viewID%>'"></td>
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