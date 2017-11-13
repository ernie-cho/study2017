<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>
<html>
<head>
</head>
<body>
<hr></hr>
<h2 align=center>테이블 생성<h2>
<hr></hr>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();
		
	try{
		stmt.execute(" drop table resort ");
		out.println("drop table resort OK<br>");
	}catch (Exception e){
		out.println("resort table couldn't drop<br>");
		out.println( e.toString() );
	}
										   //성명              예약일                       예약방               주소               연락처                   입금자명                 남기실말           예약한 날짜          현재진행1:완료2입금완료3환불요청
		stmt.execute(" create table resort( name varchar(20), resv_date date not null, room int not null, addr varchar(100), telnum varchar(20), in_name  varchar(20), comment  text, write_date date, processing int, primary key (resv_date,room)) default charset=utf8");
		
	String sql="";
	sql=" insert into resort(name, resv_date, room, addr, telnum, in_name, comment, write_date, processing) values('홍길동', date(now()), 1 , '우리집', '010-1234-3210', '홍길동', '반갑습니다', date(now()), 1)"; stmt.execute(sql);
	
	out.println("생성완료");
	
	
	
	stmt.close();
	conn.close();
%>
