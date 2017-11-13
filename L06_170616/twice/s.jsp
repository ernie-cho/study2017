<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.BufferedReader" %>
<%
		String start = request.getParameter("startCnt");
		String cnt = request.getParameter("outputCnt");
%>
<html>
<head>
<%!
	public int countMax(){
	try{
	File f2 = new File("/var/lib/tomcat7/webapps/ROOT/WebServer/Lec04/wifi2.txt");
	BufferedReader br2 = new BufferedReader(new FileReader(f2));
	String readtxt2;
	if((readtxt2 = br2.readLine())==null){
		System.out.println("빈 파일입니다");
		return 0;
	}
	int maxCount = 0;
	while((readtxt2=br2.readLine())!= null){
		maxCount++;
	}
	br2.close();
	return maxCount;
	}
	catch(Exception e2){
		return 0;
	}
	}
%>		
</head>
<body>
<table style="TABLE-LAYOUT: fixed" width=1000 border="1">
	<tr>
		<td td width=5% align = center>번호</td>
		<td td width=55% align = center>주소</td>
		<td td width=10% align = center>위도</td>
		<td td width=10% align = center>경도</td>
		<td td width=20% align = center>거리</td>
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
	
	File f = new File("/var/lib/tomcat7/webapps/ROOT/WebServer/Lec04/wifi2.txt");
	BufferedReader br = new BufferedReader(new FileReader(f));
	String readtxt;
	
	if((readtxt = br.readLine())==null){
		System.out.println("빈 파일입니다");
		return;
	}
	String[] field_name = readtxt.split("\t");
	
	double lat = 37.3860521;
	double lng = 127.1214038;
	
	int LineCnt=0;
	while((readtxt=br.readLine())!= null){
		LineCnt++;
		if(LineCnt < Integer.parseInt(start)) continue;
		if(LineCnt >= Integer.parseInt(start)+Integer.parseInt(cnt)) break;
		
		out.println("<tr>");
		String[] field = readtxt.split("\t");
			out.println("<td td width=5% align = center>"+LineCnt+"</td>");
			out.println("<td td width=55% align = center>"+field[9]+"</td>");
			out.println("<td td width=10% align = right>"+field[12]+"</td>");
			out.println("<td td width=10% align = right>"+field[13]+"</td>");
			double dist=Math.sqrt(Math.pow(Double.parseDouble(field[12])-lat,2)
						+ Math.pow(Double.parseDouble(field[13])-lng,2));
			out.println("<td td width=20% align = right>"+dist+"</td>");
			
		out.println("</tr>");
	}

	
	out.println("</table><br>");
	out.println("<a href=wifi2.jsp?startCnt=1&outputCnt="+(perPage)+">[&lt;&lt;]</a>");
	if(myPage <= 6){
		out.println("<a href=wifi2.jsp?startCnt=1&outputCnt="+(perPage)+">&lt;&lt;</a>");
	}else{
		out.println("<a href=wifi2.jsp?startCnt="+(((myPage-6)*perPage)+1)+"&outputCnt="+(perPage)+">&lt;&lt;</a>");
	}
	
	for(int i = 0; i < 10; i++){
		if((startPage+i)>maxPage){
			endPage = maxPage;
			break;
		}
		if(myPage == (startPage+i)){
			out.println("<a href=wifi2.jsp?startCnt="+(((startPage+(i-1))*perPage)+1)+"&outputCnt="+(perPage)+"><Strong>"+(startPage+i)+"</Strong></a>");
		}else{
			out.println("<a href=wifi2.jsp?startCnt="+(((startPage+(i-1))*perPage)+1)+"&outputCnt="+(perPage)+">"+(startPage+i)+"</a>");
		}
	}
	if(endPage != maxPage)
		out.println("<a href=wifi2.jsp?startCnt="+((startPage+9)*perPage+1)+"&outputCnt="+(perPage)+">&gt;&gt;</a>");
	else{
		out.println("<a href=wifi2.jsp?startCnt="+((endPage-1)*perPage+1)+"&outputCnt="+(perPage)+">&gt;&gt;</a>");
	}
	out.println("<a href=wifi2.jsp?startCnt="+((maxPage-1)*perPage+1)+"&outputCnt="+(perPage)+">[&gt;&gt;]</a>");
	br.close();
	}catch(Exception e){
		out.println(e);
	}
%>
</body>
</html>