<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page import="java.text.*, javax.util.*, java.io.*, java.net.*" %>

<html>
<head>
</head>
<body BACKGROUND="/L08_resort/notice.jpg">
<center>
<%
	request.setCharacterEncoding("utf-8");
	
	String jump = request.getParameter( "jump" );
	String id = request.getParameter( "id" );
	String pass = request.getParameter( "passwd" );
	//여기에서 엉뚱한 값을 체크해야 하는데 생략함
	
	boolean bPassChk=false;
	
	//아이디, 패스워드 체크
	if( id.replaceAll(" ","").equals("admin")&& pass.replaceAll(" ","").equals("admin")){
		bPassChk=true;
	}else{
		bPassChk=false;
	}

	//패스워드 체크가 끝나면, 세션을 기록하고 점프한다.
	if(bPassChk){
		session.setAttribute("login_ok","yes");
		session.setAttribute("login_id",id);
		response.sendRedirect(jump); //로그인체크 이후 돌아갈 곳
	}else{
		out.println("<h2>Wrong ID or Password.</h2>");
		out.println("<input type=button value='Login' OnClick=\"location.href='login.jsp?jump="+jump+"'\">");
	}
%>		
	
</center>
</body>
</html>