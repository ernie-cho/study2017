<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.text.*, javax.util.*, java.io.*, java.net.*" %>
<%@ page import="java.text.SimpleDateFormat, java.util.GregorianCalendar, java.util.Locale" %>

<% //session option  
	session.setAttribute("session_id","조영도");
	GregorianCalendar cal = new GregorianCalendar();
	SimpleDateFormat fmt = new SimpleDateFormat("yy-MM-dd [hh:mm:ss]");
	long createTime = (long)session.getCreationTime(); //세션 생성시간
	long lastTime = (long)session.getLastAccessedTime(); //마지막 처리 시간
%>
session 생성 시간 ==> <%=fmt.format(cal.getTime())%><br>
session 마지막 처리 시간 ==> <%=fmt.format(cal.getTime())%><br>
session 유지 시간 ==> <%=(int)session.getMaxInactiveInterval()%><br>
session 유지 시간 변경 ==> <%session.setMaxInactiveInterval(180);%><br>
session 값 표시 ==> <%=(String)session.getAttribute("session_id")%><br>
session ID ==> <%=session.getId()%><br>
session 유지 시간 ==> <%=(int)session.getMaxInactiveInterval()%><br>
