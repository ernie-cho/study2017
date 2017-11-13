<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ page import= "java.io.*" %>
<%@ page import= "java.text.*,java.util.*,java.sql.*,javax.servlet.*,javax.sql.*,javax.naming.*" %>
<%@ page import = "javax.xml.parsers.*,org.w3c.dom.*" %>
<%@ page import = "java.util.regex.Matcher" %>
<%@ page import = "java.util.regex.Pattern" %>
<html>
<head>
<%
	String s_url = "emptyRoom.jsp"; //현페이지 
%>
<script>
function refresh_start(){
	location.href='<%=s_url%>'
}
</script>
<title>1등 호텔 예약현황사이트[호텔 코파유]</title>
</head>
<body>
<center>
<h2>1등 호텔 예약현황사이트[호텔 코파유]</h2>
<table <table cellspacing=0 cellpadding=0 border=1>
<tr>
	<td align=center height=50 bgcolor=#E4F7BA>&nbsp<b>리조트명</b>&nbsp</td>
	<td align=center height=50 bgcolor=#E4F7BA>&nbsp<b>대표</b>&nbsp</td>
	<td align=center height=50 bgcolor=#E4F7BA>&nbsp<b>빈방</b>&nbsp</td>
	<td align=center height=50 bgcolor=#E4F7BA>&nbsp<b>예약하기</b>&nbsp</td>
	<td align=center height=50 bgcolor=#E4F7BA>&nbsp<b>조회시간</b>&nbsp</td>
</tr>
<%
try{
	long startTime =System.currentTimeMillis(); //process 시작 시간
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/test","root","koposw");
	Statement stmt = conn.createStatement();
	
	ResultSet rset = stmt.executeQuery("SELECT count(*) FROM crawlingDB;");
	rset.next();
	String rcnt = rset.getString(1);
	
	rset = stmt.executeQuery("SELECT * FROM crawlingDB;");
	while(rset.next()){
%>		
<tr>
	<td>&nbsp<%=rset.getString(2)%>&nbsp</td> <!--리조트명-->
	<td>&nbsp<%=rset.getString(3)%>&nbsp</td> <!--대표-->
	<td>&nbsp<%=rset.getString(11)%>개&nbsp</td>	   <!--빈방 수-->
	<td align=center><button onClick="location.href='<%=rset.getString(10)%>'">홈페이지</button></td> <!--홈페이지-->
	<td>&nbsp<%=rset.getString(12)%>&nbsp</td>	   <!--조회한 시간-->
	
</tr>
<%	
	}
	long endTime =System.currentTimeMillis();
%>	
</table>
총 <%=rcnt%>개 5초마다 갱신
<%
	rset.close();
	stmt.close();
	conn.close();	
	}catch(Exception e) {
		e.printStackTrace();
	}
%>
<script>
var timer = setInterval('refresh_start()',5000); <!--5초-->
</script>
</center>
</body>
</html>