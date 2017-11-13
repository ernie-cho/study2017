<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>
<%@ page import="java.text.SimpleDateFormat, java.util.GregorianCalendar, java.util.Locale" %>

<html>
<head>
<title>Welcome to JAVA airline</title>
</head>
<body BACKGROUND="image/bg1.png">
<br> 


<table cellspacing=0 WIDTH=600 border=0 align=center>
	
	<tr>
		<td width=600 height=400 align=center><B><img src="image/uaa.png"></B></td>					
	</tr>
	</table>

<center>
<%
	GregorianCalendar cal = new GregorianCalendar();
	SimpleDateFormat dformat = new SimpleDateFormat("yyyy-MM-dd H:m:ss");
	
	String calDate = dformat.format(cal.getTime());
	

	//생성된 쿠키 출력
	Cookie[] cookies = request.getCookies();
	if(cookies == null){

		out.println("<font size=7 color=white><b>"+"Welcome to our Resort"+"</font><b><br>");
	}else{
			for(int i=0;i<cookies.length;i++){
		Cookie thisCookie = cookies[i];
		if("name".equals(thisCookie.getName())){			
			out.println("<font size=7 color=white><b>"+"Recent visit ("+calDate+")"+"</font><b><br>");
			}
		}	
	}
		
	//쿠키 생성
	String myName = "resort.SJCU";
	Cookie cookieName = new Cookie("name", myName);
	cookieName.setMaxAge(60*60*24);
	response.addCookie(cookieName);
%>

</center>
</body>
</html>