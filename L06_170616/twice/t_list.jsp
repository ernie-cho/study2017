<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.text.*" %>
<html>
<%

	DecimalFormat df = new DecimalFormat("###,###,###,###,###");
	String start = request.getParameter("startCnt");
	String cnt = request.getParameter("outputCnt");
%>
<head>
<style type="text/css">
	td{
		max-width: 250px;
		height: 1px;
		text-overflow: ellipsis;
		overflow: hidden;
		white-space: nowrap;
		table-layout:fixed;
	}
</style>
<h1 align=center><HR>(주)트와이스 재고 현황-전체현황</HR></h1>
<HR></HR>
<%!
	public int countMax(){
			try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
			Statement stmt = conn.createStatement();	
			ResultSet rset = stmt.executeQuery(" select count(*) from twice");
			rset.next();
			int maxCount = rset.getInt(1);
			if(maxCount==0){
				System.out.println("빈 파일입니다");
				return 0;
			}else if(maxCount!=0){
				maxCount = rset.getInt(1);
			}
			return maxCount;
		}catch(Exception e2){
			return 0;
		}			
	}
%>
</head>
<body>
<form action=t_view.jsp method=post>
<table cellspacing=0 WIDTH=600 border=1 align=center>
	<tr>
		<td width=120 align=center>상품번호</a></td>					
		<td width=200 align=center>상품명</a></td>
		<td width=120 align=center>현재재고수</a></td>	
		<td width=200 align=center>재고파악일</a></td>	
		<td width=200 align=center>상품등록일</a></td>	
	</tr>
<%
try{
	int maxLine = countMax();
	
	if(start == null || Integer.parseInt(start) <= 0 ){
		start = "1";
	}
	
	if(cnt == null || Integer.parseInt(cnt) <= 0 ){
		cnt = "10";
	}
	
	int perPage = Integer.parseInt(cnt);
	
	if(Integer.parseInt(start) > maxLine){
		start = String.valueOf(1);
	}
	
	int myPage = 0;
	if(perPage == 1){
		myPage = (Integer.parseInt(start)/perPage);
	}else{
		myPage = (Integer.parseInt(start)/perPage)+1;
	}
	int minPage = 1;
	int maxPage;
	int startPage;
	int endPage = 0;
	if(maxLine%perPage == 0){
		maxPage = maxLine/perPage;
	}else{
		maxPage = maxLine/perPage+1;
	}
	if((myPage - 5) < minPage){
		startPage = minPage;
	}else{
		startPage = myPage - 5;
	}
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();
	
	ResultSet rset = stmt.executeQuery(" select * from twice order by pid desc ");
	String pname="", stockDate ="",productDate="";
	
	int pid = 0, stock =0;
	int LineCnt=0;
	while(rset.next()) {
		LineCnt++;
		if(LineCnt < Integer.parseInt(start)) continue;
		if(LineCnt >= Integer.parseInt(start)+Integer.parseInt(cnt)) break;
		pid = rset.getInt(1);
		int pid2 = (pid+122120);
		pname =	rset.getString(2);
		pname = pname.replaceAll("<", "&lt;");
		pname = pname.replaceAll(">", "&gt;");
		if(pname.length() > 12){
			pname = pname.substring(0,12);
		}
		stock = rset.getInt(3);
		//int dfStock = df.format(stock);
		stockDate = rset.getString(4);
		productDate = rset.getString(5);
%>	
<input type=hidden name=aa value=<%=pid%>>
	<tr>
		<td width=15% align=center><%=pid2%></a></td>					
		<td class="ellipsis" width=30% align=left><a href="t_view.jsp?name=<%=pid2%> "><%=pname%></a></td>
		<td width=17% align=right><%=df.format(stock)%></a></td>	
		<td width=17% align=center><%=stockDate%></a></td>	
		<td width=17% align=center><%=productDate%></a></td>	
	</tr>
	
<%
	}	
	out.println("</table><br>");
%>
<table cellspacing=0 WIDTH=600 border=0 align=center>
	<tr>
	
<%
	out.println("<td align=center WIDTH=70><a href=t_list.jsp?startCnt=1&outputCnt="+(perPage)+">처음</a></td>");
	if(myPage <= 6){
		out.println("<td align=center WIDTH=70><a href=t_list.jsp?startCnt=1&outputCnt="+(perPage)+">이전</a></td>");
	}else{
		out.println("<td align=center WIDTH=70><a href=t_list.jsp?startCnt="+(((myPage-6)*perPage)+1)+"&outputCnt="+(perPage)+">이전</a></td>");
	}
	
	for(int i = 0; i < 10; i++){
		if((startPage+i)>maxPage){
			endPage = maxPage;
			break;
		}
		if(myPage == (startPage+i)){
			out.println("<td align=center WIDTH=70><a href=t_list.jsp?startCnt="+(((startPage+(i-1))*perPage)+1)+"&outputCnt="+(perPage)+"><Strong>"+(startPage+i)+"</Strong></a></td>");
		}else{
			out.println("<td align=center WIDTH=70><a href=t_list.jsp?startCnt="+(((startPage+(i-1))*perPage)+1)+"&outputCnt="+(perPage)+">"+(startPage+i)+"</a></td>");
		}
	}
	if(endPage != maxPage)
		out.println("<td align=center WIDTH=70><a href=t_list.jsp?startCnt="+((startPage+9)*perPage+1)+"&outputCnt="+(perPage)+">다음</a></td>");
	else{
		out.println("<td align=center WIDTH=70><a href=t_list.jsp?startCnt="+((endPage-1)*perPage+1)+"&outputCnt="+(perPage)+">다음</a></td>");
	}
	out.println("<td align=center WIDTH=70><a href=t_list.jsp?startCnt="+((maxPage-1)*perPage+1)+"&outputCnt="+(perPage)+">끝</a></td>");
	
	}catch(Exception e){
		out.println(e);
	}
%>
	</tr>
	</table>
<table cellspacing=0 WIDTH=600 border=0 align=center>
	<tr>
	<td colspan=3 align=right><input type="button" value="신규등록" onClick="location.href='t_insert.jsp'"></td>
	</tr>
</table>
</form>
<hr></hr>
</body>
</html>