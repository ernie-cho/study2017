<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ page import= "java.io.*" %>
<%@ page import= "java.text.*,java.util.*,java.sql.*,javax.servlet.*,javax.sql.*,javax.naming.*" %>
<%@ page import = "javax.xml.parsers.*,org.w3c.dom.*" %>
<%@ page import = "java.util.regex.Matcher" %>
<%@ page import = "java.util.regex.Pattern" %>
<html>
<head>
<%
	String s_url = "view.jsp"; //현페이지 
%>
<script>
function refresh_start(){
	location.href='<%=s_url%>'
}
</script>
<title>SYSTEM MONITORING</title>
</head>
<body>
<center>
<h3>SYSTEM MONITORING</h3>
<table <table cellspacing=1 cellpadding=1 border=1>
<tr>
	<td align=center width=100 bgcolor=#868686><font color=white>번호</font></td>
	<td align=center width=100 bgcolor=#868686><font color=white>사용자</font></td>
	<td align=center width=100 bgcolor=#868686><font color=white>시간</font></td>
	<td align=center width=100 bgcolor=#868686><font color=white>CPU</font></td>
	<td align=center width=100 bgcolor=#868686><font color=white>%USER</font></td>
	<td align=center width=100 bgcolor=#868686><font color=white>%NICE</font></td>
	<td align=center width=100 bgcolor=#868686><font color=white>%SYSTEM</font></td>
	<td align=center width=100 bgcolor=#868686><font color=white>%IOWAIT</font></td>
	<td align=center width=100 bgcolor=#868686><font color=white>%STEAL</font></td>
	<td align=center width=100 bgcolor=#868686><font color=white>%IDLE</font></td>
	<td align=center width=100 bgcolor=#868686><font color=white>상태</font></td>
</tr>
<%
try{
	long startTime =System.currentTimeMillis(); //process 시작 시간
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();
	
	ResultSet rset = stmt.executeQuery("SELECT count(*) FROM crawling_sar;");
	rset.next();
	String rcnt = rset.getString(1);
	
	rset = stmt.executeQuery("SELECT * FROM crawling_sar;");
	while(rset.next()){
		String server_num = rset.getString(1);
		String uName = rset.getString(2);
		String time = rset.getString(4);
		String cpu = rset.getString(5);
		String user = rset.getString(6);
		String nice = rset.getString(7);
		String system = rset.getString(8);
		String iowait = rset.getString(9);
		String steal = rset.getString(10);
		String idle = rset.getString(11);
	out.println("<tr>");	
	if(rset.getDouble(11)<40.0){			
%>		
	<td align=center bgcolor=#FA7070><%=server_num%></td> 		
	<td align=center bgcolor=#FA7070><%=uName%></td> 		
	<td align=center bgcolor=#FA7070><%=time%></td>		
	<td align=center bgcolor=#FA7070><%=cpu%></td>		
	<td align=center bgcolor=#FA7070><%=user%></td>		
	<td align=center bgcolor=#FA7070><%=nice%></td>		
	<td align=center bgcolor=#FA7070><%=system%></td>		
	<td align=center bgcolor=#FA7070><%=iowait%></td>		
	<td align=center bgcolor=#FA7070><%=steal%></td>		
	<td align=center bgcolor=#FA7070><%=idle%></td>		
<%	}else { %>
	<td align=center bgcolor=#F5F5F5><%=server_num%></td> 		
	<td align=center bgcolor=#F5F5F5><%=uName%></td> 		
	<td align=center bgcolor=#F5F5F5><%=time%></td>		
	<td align=center bgcolor=#F5F5F5><%=cpu%></td>		
	<td align=center bgcolor=#F5F5F5><%=user%></td>		
	<td align=center bgcolor=#F5F5F5><%=nice%></td>		
	<td align=center bgcolor=#F5F5F5><%=system%></td>		
	<td align=center bgcolor=#F5F5F5><%=iowait%></td>		
	<td align=center bgcolor=#F5F5F5><%=steal%></td>		
	<td align=center bgcolor=#F5F5F5><%=idle%></td>	
<%	}
	if(rset.getDouble(11)<40.0){
		out.println("<td align=center bgcolor=#FA7070><img src=./red.png style=width:30%; height: auto;></td>");
	}else if(rset.getDouble(11)<70.0){
		out.println("<td align=center bgcolor=#F5F5F5><img src=./yellow.png style=width:30%; height: auto;></td>");
		}else{
		out.println("<td align=center bgcolor=#F5F5F5><img src=./blue.png style=width:30%; height: auto;></td>");	
		}
	out.println("</tr>");
	}
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