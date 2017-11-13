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
		stmt.execute(" drop table twice ");
		out.println("drop table twice OK<br>");
	}catch (Exception e){
		out.println("twice table couldn't drop<br>");
		out.println( e.toString() );
	}
%>
<%
	stmt.execute(" create table twice( pid int not null primary key auto_increment, pname varchar(70), cstock int, sdate date, pdate date) default charset=utf8");
%>
<%
	String sql="";
	sql=" insert into twice(pname, cstock, sdate, pdate) values('바나나',10,date(now()),date(now()))"; stmt.execute(sql);
	sql=" insert into twice(pname, cstock, sdate, pdate) values('딸기',13,date(now()),date(now()))"; stmt.execute(sql);
	sql=" insert into twice(pname, cstock, sdate, pdate) values('사과',12,date(now()),date(now()))"; stmt.execute(sql);
	sql=" insert into twice(pname, cstock, sdate, pdate) values('배',18,date(now()),date(now()))"; stmt.execute(sql);
	sql=" insert into twice(pname, cstock, sdate, pdate) values('참외',40,date(now()),date(now()))"; stmt.execute(sql);
	
	stmt.close();
	conn.close();
%>
</body>
</html>