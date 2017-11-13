<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>


<html>
<head>
</head>
<body BACKGROUND="/Air/image/bg11.png">
<hr></hr>
<h2 align=center>알리는 글<h2>
<hr></hr>
<form action=gongji_view.jsp method=post>
<table cellspacing=0 WIDTH=600 border=1 align=center>
	<tr>
		<td width=80 align=center>No.</a></td>					
		<td width=600 align=center>TITLE</a></td>
		<td width=150 align=center>Insert Date</a></td>	
	</tr>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();	
	ResultSet rset = stmt.executeQuery(" select * from gongji order by id desc ");
	String title="", getDate ="",content="";
	//로그인 세션 기록
	String loginOK="";
	String adm_login="";
		loginOK = (String)session.getAttribute("login_ok");
		if(loginOK==null){
			loginOK = "NO";
		}
		else { 
			if(loginOK.equals("yes")){
			adm_login = "OK";
		   }	
		}
	
	int idCnt = 0;
	while(rset.next()) {
		idCnt = rset.getInt(1);
		title =	rset.getString(2);
		title = title.replaceAll("<", "&lt;");
		title = title.replaceAll(">", "&gt;");
		getDate = rset.getString(3);
		
	
		
		
		
%>	
<input type=hidden name=aa value=<%=idCnt%>>
	<tr>
		<td width=80 align=center><%=idCnt%></a></td>					
		<td width=600 align=left><a href="gongji_view.jsp?name=<%=idCnt%> "><%=title%></a></td>
		<td width=150 align=center><%=getDate%></a></td>	
		
	</tr>
<%
	}
%>
</table>
<table cellspacing=0 WIDTH=600 border=0 align=center>
	<tr>
<%
	if(adm_login.equals("OK")){
%>		
		<td colspan=3 align=right><input type="button" value="NEW" onClick="location.href='gongji_insert.jsp'"></td>
<%	}
%>
	</tr>
</table>
</form>

</body>
</html>