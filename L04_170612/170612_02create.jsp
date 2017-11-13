<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>

<html>
<head>
</head>
<body>
<h2>Create Table Success</h2>

<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection k20_conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement k20_stmt = k20_conn.createStatement();
	k20_stmt.execute( " create table examtable2(" +
							  " name varchar(20)," +
							  " studentid int not null primary key," +
							  " kor		int, " +
							  " eng     int, " +
							  " mat     int)" +
							  " DEFAULT CHARSET = utf8");


	
	k20_stmt.close();
	k20_conn.close();
%>

</table>
</body>
</html>

