<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page import="java.text.*, javax.util.*, java.io.*, java.net.*" %>
<%@ page import="java.sql.*, javax.sql.*"%>

<html>
<head>
<script>
function aa(jump){
	parent.top_frame.location.href="top.jsp";
	parent.main.location.href=jump;
}
</script>
</head>
<body BACKGROUND="image/bg11.png">
<center>
<%
	request.setCharacterEncoding("utf-8");
	
	String jump = request.getParameter( "jump" );
	String id = request.getParameter( "id" );
	id = id.replaceAll(" ","");
	String pass = request.getParameter( "passwd" );
	pass = pass.replaceAll(" ","");

	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();	
	
	ResultSet rset = stmt.executeQuery(" select * from airsign where id = '"+id+"' ");
	rset.next();
	try{
		String chkID = rset.getString(1);
		String chkPW = rset.getString(2);
		out.println("<h2>"+chkID+"님 비밀번호 오류</h2>");
		boolean bPassChk=false;
		
		//아이디, 패스워드 체크
		if( id.equals(chkID)&& pass.equals(chkPW)){
			bPassChk=true;
		}else{
			bPassChk=false;
		}

		//패스워드 체크가 끝나면, 세션을 기록하고 점프한다.
		if(bPassChk){
			session.setAttribute("login_ok","yes");
			session.setAttribute("login_id",id);
			out.print("<script>aa('"+jump+"');</script>"); //로그인체크 이후 돌아갈 곳
				//<a href="javascript:window.location.reload(true);">페이지 다시 읽기</a>

				//<input type="button" value="Click" onclick="location.reload()" />
		}else{
			out.println("<h4>다시 입력해주세요.</h4>");
			out.println("<input type=button value='로그인' OnClick=\"location.href='login.jsp?jump="+jump+"'\">");
		}
	}catch (SQLException e){
			out.println("<h2>가입되어있지 않은 ID입니다.</h2>");
			out.println("<input type=button value='로그인' OnClick=\"location.href='login.jsp?jump="+jump+"'\">");
	}
	
%>		

</center>
</body>
</html>