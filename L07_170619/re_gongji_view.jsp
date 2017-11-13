<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>


<html>
<head>
<script>
function submitForm(mode){
		if(mode == "cancle"){
			viewData.action = "re_gongji_list.jsp";
			viewData.submit();
		}else if(mode == "write"){
			viewData.action = "re_gongji_update_query.jsp";
			viewData.submit();
		}else if(mode == "delete"){
			viewData.action = "re_gongji_delete.jsp";
			viewData.submit();
		}
		
	}
</script>
</head>
<body>
<hr></hr>
<h2 align=center>내용 VIEW<h2>
<hr></hr>
<form action=gongji_update.jsp method=post name=viewData >
<table cellspacing=0 WIDTH=600 border=1 align=center>

<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();	
	
	int aa = Integer.parseInt(request.getParameter("name"));

	ResultSet rset = stmt.executeQuery(" select * from re_gongji where id="+aa+"; ");
	rset.next();
	int viewID =rset.getInt(1);
	int viewCnt = rset.getInt(7);//조회수
	viewCnt++;
	//타이틀 변수 및 특수문자 처리
	String viewTitle = rset.getString(2);
	viewTitle = viewTitle.replaceAll("<", "&lt");
	viewTitle = viewTitle.replaceAll(">", "&gt");
	
	//텍스트 변수 및 특수문자 처리
	String viewText = rset.getString(4);
	viewText = viewText.replaceAll("<", "&lt");
	viewText = viewText.replaceAll(">", "&gt");
	viewText = viewText.replaceAll("<br>", "\n");
	//viewText = viewText.replaceAll("\n", "<br>");
	int rootID = 0, nodeID = 0;
	rootID = rset.getInt(5);
	nodeID = rset.getInt(6);
	
	
	out.println("<tr>");
	out.println("<td width=100 align=left>번호</td>");	
	out.println("<td width=300 align=left><input type=hidden name=view value='"+viewID+"'>"+viewID+"</td>");	
	out.println("</tr>");
	
	out.println("<tr>");
	out.println("<td width=100 align=left>제목</td>");
	out.println("<td width=300 align=left>"+viewTitle+"</td>");
	out.println("</tr>");
	
	out.println("<tr>");
	out.println("<td width=100 align=left>일자</td>");	
	out.println("<td width=300 align=left>"+rset.getString(3)+"</td>");
	out.println("</tr>");
	
	out.println("<tr>");
	out.println("<td width=100 align=left>조회수</td>");	
	out.println("<td width=300 align=left>"+viewCnt+"</td>");
	out.println("</tr>");
	
	String sql= " update re_gongji set viewcnt= "+viewCnt+" where id ="+viewID+" ";
	stmt.executeUpdate( sql );
%>
	<tr>
	<td width=100 align=left>내용</td>
	<td width=300 align=left><textarea style="width:100%;border:1;overflow:visible;text-overflow:
		ellipsis;overflow:scroll; resize:none;" rows=30 readonly><%=viewText%></textarea></td>
	</tr>
	
	<tr>
	<td width=100 align=left>원글</td>
	<td width=300 align=left><%=rootID%></td>
	</tr>
	
	<tr>
	<td width=100 align=left>댓글수준</td>
	<td width=300 align=left><%=nodeID%></td>
	</tr>
	

	</table>
<table cellspacing=0 WIDTH=600 border=0 align=center>
	<tr>
	<td width = 500></td>
	<td  align=right><input type="button" value="목록" onClick="location.href='re_gongji_list.jsp'"></td>
	<td  align=right><input type="button" value="수정" onClick="location.href='re_gongji_update.jsp?id=<%=viewID%>'"></td>
	<td  align=right><input type="button" value="삭제" onClick=submitForm('delete');></td>
	<td  align=right><input type="button" value="댓글" onClick="location.href='re_gongji_reply.jsp?id=<%=viewID%>'"></td>
	</tr>
</table>
</form>
<%	
	rset.close();
	stmt.close();
	conn.close();
%>

</body>
</html>