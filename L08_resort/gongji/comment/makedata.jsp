<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>


<html>
<head>
<%@ page import="java.sql.*,javax.sql.*, java.net.*, java.io.*" %>
</head>
<body BACKGROUND="/L08_resort/notice2.jpg">
<h1 align=center> Make Table </h1>
<%
Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();
%>
<%
	try{
		stmt.execute(" drop table gongji2 ");
		out.println("drop table gongji2 OK<br>");
	}catch (Exception e){
		out.println("gongji table couldn't drop<br>");
		out.println( e.toString() );
	}
%>
<%
	stmt.execute(" create table gongji2( id int not null primary key auto_increment, title varchar(70), date date, content text) default charset=utf8");
%>
<%
	String sql="";
	sql=" insert into gongji2(title, date, content) values('안녕하세요',date(now()),'공지사항내용1')"; stmt.execute(sql);
	sql=" insert into gongji2(title, date, content) values('잘놀다갑니다',date(now()),'공지사항내용2')"; stmt.execute(sql);
	sql=" insert into gongji2(title, date, content) values('좋아요',date(now()),'공지사항내용3')"; stmt.execute(sql);
	sql=" insert into gongji2(title, date, content) values('재밌었어요',date(now()),'공지사항내용4')"; stmt.execute(sql);
	sql=" insert into gongji2(title, date, content) values('감사합니다',date(now()),'공지사항내용5')"; stmt.execute(sql);
	
	stmt.close();
	conn.close();
%>
</body>
</html>