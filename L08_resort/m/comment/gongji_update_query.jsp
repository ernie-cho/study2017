<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>
<html>
<head>
</head>
<body>
<hr></hr>
<h2 align=center>SUCCESS<h2>
<hr></hr>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();	
	ResultSet rset = stmt.executeQuery(" select curdate() ");
	String getDate ="";
	rset.next();
	getDate =	rset.getString(1);
	String updateTitle = request.getParameter("fixTitle");
	String newTitle = new String(updateTitle.getBytes("8859_1"),"utf-8");
	String updateText = request.getParameter("fixText");
	String newText = new String(updateText.getBytes("8859_1"),"utf-8");
	int newID = Integer.parseInt(request.getParameter("fixID"));
	
	String sql= " update gongji set title='"+newTitle+"', date='"+getDate+"', content='"+newText+"' where id ="+newID+" ";
	stmt.executeUpdate( sql );
	
	rset.close();
	stmt.close();
	conn.close();
%>

<table cellspacing=0 WIDTH=600 border=0 align=center>
	<tr>
	<td  align=center><input type="button" value="LIST" onClick="location.href='gongji_list.jsp'"></td>
	</tr>
</table>

</body>
</html>