<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>
<%@ page import="java.text.SimpleDateFormat, java.util.GregorianCalendar, java.util.Locale" %>
<html>
<head>
</head>
<body BACKGROUND="/L08_resort/notice.jpg">
<%
	try{
	GregorianCalendar cal = new GregorianCalendar();
	SimpleDateFormat dformat = new SimpleDateFormat("yyyy-MM-dd");
	String calDate = dformat.format(cal.getTime());
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();	
	
	String d_03name = request.getParameter("d_02name");
	String in_name = new String(d_03name.getBytes("8859_1"),"utf-8");
	//선택된 년,월,일
	String d_03year = request.getParameter("rev_date");
	
		//로그인 세션 기록
	String loginOK="";
	String adm_login="";
		loginOK = (String)session.getAttribute("login_ok");
		if(loginOK==null){
			adm_login = "NO";
		}
		else { 
			if(loginOK.equals("yes")){
			adm_login = "OK";
		   }	
		}
	
	
	//선택된 방 타입
	String d_03room = request.getParameter("room");
	//방타입을 인트형으로 변환
	int roomType =0;
	if(d_03room.contains("1")){
		roomType = 1;
	}else if(d_03room.contains("2")){
		roomType = 2;
	}else if(d_03room.contains("3")){
		roomType = 3;
	}
	//입력된 주소
	String d_03addr = request.getParameter("d_02addr");
	String in_addr = new String(d_03addr.getBytes("8859_1"),"utf-8");
	//입력된 전화번호
	String d_03tel = request.getParameter("d_02tel");
	//입력된 입금자명
	String d_03rname = request.getParameter("d_02Rname");
	String in_rname = new String(d_03rname.getBytes("8859_1"),"utf-8");
	//입력된 내용
	String d_03comment = request.getParameter("d_02comment");
	String in_comment = new String(d_03comment.getBytes("8859_1"),"utf-8");
	
	
	
	String sql= " insert into resort(name, resv_date, room, addr, telnum, in_name, comment, write_date, processing) " +
				" values('"+in_name+"', '"+d_03year+"', "+roomType+", '"+in_addr+"', " +
				" '"+d_03tel+"','"+in_rname+"', '"+in_comment+"', '"+calDate+"', 1); " ;
	stmt.executeUpdate( sql );

	
	
	
	
	
	
	
	
	
%>
<hr></hr>
<h2 align=center>THANK YOU FOR YOUR RESERVATION<h2>
<hr></hr>

<%
	if(adm_login.equals("OK")){
%>		
	<table cellspacing=0 WIDTH=600 border=0 align=center>
	<tr>
	<td colspan=3 align=center><input type="button" value="LIST" onClick="location.href='login_test.jsp'"></td>
	</tr>
	</table>	
<%	}else {
%>	
	<table cellspacing=0 WIDTH=600 border=0 align=center>
	<tr>
	<td colspan=3 align=center><input type="button" value="LIST" onClick="location.href='d_01.jsp'"></td>
	</tr>
	</table>
<%	}
	stmt.close();
	conn.close();
	}

catch (SQLException e){
		if(e.getErrorCode() == 1062){
			out.println("<script>");
			out.println("alert(\"THIS ROOM IS ALREADY BOOKED\");");
			out.println("history.go(-1);");
			out.println("</script>");
		}
		out.println(e);
	}
%>	
</body>
</html>

