<!DOCTYPE html5>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*"%>
<html>
<head>
</head>
<body BACKGROUND="image/bg11.png">
<%
	String chkType = request.getParameter("one");
	String newType = new String(chkType.getBytes("8859_1"),"utf-8");
	out.println("<br>1. 티켓타입 : "+newType);
	
	String chkWay = request.getParameter("choice");
	String newWay = new String(chkWay.getBytes("8859_1"),"utf-8");
	out.println("<br>2. 경로 : "+newWay);
	
	String chkTime = request.getParameter("time");
	String newTime = new String(chkTime.getBytes("8859_1"),"utf-8");
	out.println("<br>3. 시간 : "+newTime);
	
	String chkDate = request.getParameter("rDate");
	String newDate = new String(chkDate.getBytes("8859_1"),"utf-8");
	out.println("<br>4. 예약일 : "+newDate);
	out.println("<h2 align=center>좌석 선택<h2>");
	out.println("<table cellspacing=0 border=1 align=center>");
	out.println("<tr>");
			//<td>
	for(int i=0;i<10;i++){
		out.println("<tr>");
		for(int j=0;j<11;j++){
			if(j==5){
				out.println("<td align=center>"+(i+1)+"</td>");
			}else{
				out.println("<td><input type=button value=√></td>");
			}
		
		
		}
		
		out.println("</tr>");
	}
%>



	<tr>
	<td align=center colspan=11><input type="button" value="메인으로" onClick="location.href='/Air/main.jsp'"></td>
	</tr>

<%
	out.println("</table>");
	
	
	
	
%>

</body>
</html>