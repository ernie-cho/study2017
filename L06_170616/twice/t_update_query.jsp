<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>
<html>
<head>
</head>
<body>
<%
	try{
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();	
	
	int newID = Integer.parseInt(request.getParameter("pid_up"));
	int upID = newID-122120;
	int oriID = Integer.parseInt(request.getParameter("pid_save"));
	String pname_up = request.getParameter("Pname_up");
	String newName = new String(pname_up.getBytes("8859_1"),"utf-8");
	int newStock = Integer.parseInt(request.getParameter("stock_up"));
	String content = request.getParameter("content_up");
	String newContent = new String(content.getBytes("8859_1"),"utf-8");
	ResultSet rset = stmt.executeQuery(" select curdate() ");
	String getDate ="";
	rset.next();
	getDate =	rset.getString(1);
	
	
	String sql= " update twice set pid="+upID+", pname='"+newName+"', cstock="+newStock+", sdate='"+getDate+"', content='"+newContent+"' where pid="+oriID+" ";
	stmt.executeUpdate( sql );
	
	stmt.close();
	conn.close();
	
	}catch (SQLException e){
		if(e.getErrorCode() == 1062){
			out.println("<script>");
			out.println("alert(\"이미 등록된 상품입니다.\");");
			out.println("history.go(-1);");
			out.println("</script>");
		}
		out.println(e);
	}
%>
<hr></hr>
<h2 align=center>입력완료<h2>
<hr></hr>
<table cellspacing=0 WIDTH=600 border=0 align=center>
	<tr>
	<td colspan=3 align=center><input type="button" value="처음으로" onClick="location.href='t_list.jsp'"></td>
	</tr>
	</table>
</body>
</html>
