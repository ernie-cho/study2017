<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>
<html>
<head>
</head>
<body BACKGROUND="/L08_resort/notice.jpg">
<hr></hr>
<h2 align=center>Canceled<h2>
<hr></hr>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();
	int roomNum = Integer.parseInt(request.getParameter("deleteRoom"));
	String dateStr = request.getParameter("deleteDate");
	
	String sql= " delete from resort where resv_date = '"+dateStr+"' and room = "+roomNum+" ";
	stmt.executeUpdate( sql );
	
	stmt.close();
	conn.close();
%>

<table cellspacing=0 WIDTH=600 border=0 align=center>
	<tr>
	<td  align=center><input type="button" value="LIST" onClick="location.href='login_test.jsp'"></td>
	</tr>
</table>

</body>
</html>	