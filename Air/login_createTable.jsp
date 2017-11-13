<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>


<html>
<head>
<%@ page import="java.sql.*,javax.sql.*, java.net.*, java.io.*" %>
</head>
<body>
<h1 align=center> Make Table </h1>
<%
Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();
%>
<%
	try{
		stmt.execute(" drop table airsign ");
		out.println("drop table airsign OK<br>");
	}catch (Exception e){
		out.println("airsign table couldn't drop<br>");
		out.println( e.toString() );
	}
%>
<%
	stmt.execute(" create table airsign( id varchar(20) not null primary key , passwd varchar(70), passwd2 varchar(70), email varchar(70)) default charset=utf8");
%>
<%
	String sql="";
	sql=" insert into airsign(id, passwd, passwd2, email) values('admin','admin','admin', 'admin@a.com')"; stmt.execute(sql);
	sql=" insert into airsign(id, passwd, passwd2, email) values('admin1','admin','admin', 'admin@a.com')"; stmt.execute(sql);
	sql=" insert into airsign(id, passwd, passwd2, email) values('admin2','admin','admin', 'admin@a.com')"; stmt.execute(sql);
	sql=" insert into airsign(id, passwd, passwd2, email) values('admin3','admin','admin', 'admin@a.com')"; stmt.execute(sql);
	sql=" insert into airsign(id, passwd, passwd2, email) values('admin4','admin','admin', 'admin@a.com')"; stmt.execute(sql);
	
	stmt.close();
	conn.close();
%>
</body>
</html>