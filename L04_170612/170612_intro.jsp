<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*" %>

<HTML>
<HEAD>

</head>
<body BGCOLOR="#EDDEFA">
<img src="http://www.allkpop.com/upload/2016/04/af_org/twice_1461044325_af_org.jpg" align=center border=1>

<%
	String data;
	int cnt=0;
	
	FileReader fl = new FileReader("/var/lib/tomcat7/webapps/ROOT/L04_170612/cnt.txt");
	StringBuffer sb = new StringBuffer();
	int ch = 0;
	while((ch = fl.read()) != -1) {
		sb.append((char)ch);
	}
	data = sb.toString().trim().replace("\n","");
	fl.close();
	
	cnt = Integer.parseInt(data);
	cnt++;
	data=Integer.toString(cnt);
	out.println("<br><br>현재 홈페이지 방문조회수는 ["+data+"] 회 입니다</br>");
	
	FileWriter fl2 = new FileWriter("/var/lib/tomcat7/webapps/ROOT/L04_170612/cnt.txt", false);
	fl2.write(data);
	fl2.close();
	
	
	
%>

</body>
</html>