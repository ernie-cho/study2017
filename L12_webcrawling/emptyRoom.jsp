<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>

<html>
<head>
<%
	String s_url = "emptyRoom.jsp";  
%>
<script>
function refresh_start(){
	location.href='<%=s_url%>'
}
</script>
<title>리조트 예약 가능 상황 </title>
</head>
<body>
	<table cellspacing=1 width=500 border=1 align=center>
		<tr>
		<td width=20 align=center bgcolor=#DDDDDD>번호</td>
		<td width=20 align=center bgcolor=#DDDDDD>리조트명</td>
		<td width=20 align=center bgcolor=#DDDDDD>빈방</td>
		<td width=20 align=center bgcolor=#DDDDDD>조회 시간</td>
		<td width=20 align=center bgcolor=#DDDDDD>예약하기</td>
		</tr>
<%		
	long startTime =System.currentTimeMillis();
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();
	ResultSet rset = stmt.executeQuery("SELECT count(*) FROM crawling;");
	rset.next();
	String totalCnt = rset.getString(1);
	rset = stmt.executeQuery(" select * from crawling ");
	
	while(rset.next()){
		int server_num = rset.getInt(1);
		//String login_url = rset.getString(2);
		//String uName = rset.getString(3);
		//String uValue = rset.getString(4);
		//String pName = rset.getString(5);
		//String pValue = rset.getString(6);
		//String adm_allview_url = rset.getString(7);
		int empty_room = rset.getInt(8);
		String last_req_time = rset.getString(9);
		//boolean last_proc_flag = rset.getInt(10);
		String resort_name = rset.getString(11);
		String link = rset.getString(12);
%>
		<tr>
		<td width=20 align=center bgcolor=white><%=server_num%></td> 
		<td width=20 align=center bgcolor=white><%=resort_name%></td> 	
		<td width=20 align=center bgcolor=white><%=empty_room%></td> 
		<td width=20 align=center bgcolor=white><%=last_req_time%></td> 
		<td width=50 align=center bgcolor=white><button onClick="location.href='<%=link%>'">예약하기</button></td>
		</tr>
<%		}	
		long endTime =System.currentTimeMillis();
		rset.close();
		stmt.close();
		conn.close();
%>
	</table>
	<center>
		총 <%=totalCnt%>개 5초마다 갱신
	</center>
<script>
var timer = setInterval('refresh_start()',5000); <!--5초-->
</script>
</body>
</html>