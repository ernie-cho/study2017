<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>


<html>
<head>
<title>개표결과 C_02.jsp</title>
</head>
<body>
<table cellspacing=0 WIDTH=600 border=0 align=center>
<%
		String backPage="C_01.jsp";
		String nextPage="A_01.jsp";
		out.println("<tr>");
		out.println("<td width=50 align=left ><h2><a href="+backPage+">"+"이전"+"</a>"+"</td>");
		out.println("<td width=50 align=right ><h2><a href="+nextPage+">"+"처음으로"+"</a>"+"</td>");
		out.println("</tr>");
%>
</table>
		<table cellspacing=3 WIDTH=600 border=1 align=center>
		<tr>
			<td width=100 align=center><a href="A_01.jsp">후보등록</a></td>					
			<td width=100 align=center><a href="B_01.jsp">투표</a></td>
			<td width=100 bgcolor="#EDDEFA" align=center><a href="C_01.jsp">개표결과</a></td>	
		</tr>
	</table>

		
<%
Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();	
	int ctmp = Integer.parseInt(request.getParameter("id"));
	ResultSet rset = stmt.executeQuery(" select a.age, p.count from (select age, count(*) as count from tupyo_table where id="+ctmp+" group by id, age) as p right outer join age as a on p.age = a.age order by age ");
	int totalCnt = 0;
		while(rset.next()) {
		int Cnt = rset.getInt(2);
		totalCnt += Cnt;
		}

	String name = request.getParameter("name");		

%>	

		<h1 align=center><%=name%> 후보 득표 성향</h1>

		<table cellspacing=3 WIDTH=1200 border=1 align=center>

		<h3 align=center>총 투표자 수 : <%=totalCnt%></h3>
		<tr>
			<td width=25 colspan = 9 bgcolor = '#EDDEFA'><p align=center >득표율</p></td>			
		</tr>

<%	
	rset = stmt.executeQuery(" select a.age, p.count from (select age, count(*) as count from tupyo_table where id="+ctmp+" group by id, age) as p right outer join age as a on p.age = a.age order by age ");		
	double avg = 0;
	int graph = 0;
	int maxGraph = 200;
	while(rset.next()) {		
		int tupyoCnt = rset.getInt(2);	
		int huboCnt = rset.getInt(2);
		if(huboCnt < 1 ){
			avg = 0;
		}else{
		//out.println("huboCnt값"+huboCnt+"<br>");
		avg = (huboCnt*100.0)/totalCnt;
		avg = Math.round(avg*100);
		avg = avg/100;
		}
		//out.println("avg값"+avg+"<br>");
		int percent =(int)Math.round(avg);
		 
		if(huboCnt > maxGraph){
			huboCnt = maxGraph;
		}
		graph = maxGraph-(percent*4);
		int fGraph  = maxGraph-graph;
		//out.println("percent값"+percent+"<br>");
		//out.println(graph);
		//out.println(fGraph);
%>															
			<td width=40 height=400 valign=bottom><p align=center ><img src="purple.png" width= 50 height=' <%=fGraph%>'> <br>
			<%=tupyoCnt%>표(<%=avg%>%)</p></td>
	
<%	}	 
	//out.println("</table>");
%>	
	<tr>
	<td width=25 colspan = 9 bgcolor = '#EDDEFA'><p align=center>연령대</p></td>
	</tr>

<%	
	ResultSet rset2 = stmt.executeQuery(" select a.age, p.count from (select age, count(*) as count from tupyo_table where id=8 group by id, age) as p right outer join age as a on p.age = a.age order by age ");
	while(rset2.next()) {
		int ageNum = rset2.getInt(1);
%>				
			<td width=200><p align=center><%=ageNum%>0대</p></a></td>			
<%				
	}
	out.println("</table>");
	rset.close();
	rset2.close();
	stmt.close();
	conn.close();
%>
		


</body>
</html>