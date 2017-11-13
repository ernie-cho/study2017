<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>

<html>
<head>
<title>개표결과 C_01.jsp</title>

</head>
<body>
<h1 align=center>후보별 득표 결과</h1>
<table cellspacing=0 WIDTH=600 border=0 align=center>
<%
		String backPage="B_01.jsp";
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
	ResultSet rset = stmt.executeQuery(" select count(*) from tupyo_table ");
	rset.next();
	int totalCnt = rset.getInt(1);
	rset = stmt.executeQuery(" select count(*) from hubo_table ");
	rset.next();
	int totalCnt2 = rset.getInt(1);
	int widthSize = totalCnt2*100;
%>	
<h3 align=center>등록 후보자 수 : <%=totalCnt2%></h3>
<h3 align=center>총 투표자 수 : <%=totalCnt%></h3>
	<table cellspacing=3 WIDTH='<%=widthSize%>' border=1 align=center>

		<tr>
			<td width=25 colspan = '<%=totalCnt2%>' bgcolor = '#EDDEFA'><p align=center >득표율</p></td>			
		</tr>

<%	
	rset = stmt.executeQuery(" select * from hubo_table as h left outer join"+ 
	"(select id, count(id) from tupyo_table group by id) as t on h.id = t.id ");		
	double avg = 0;
	int graph = 0;
	int maxGraph = 200;
	while(rset.next()) {		
		int tupyoCnt = rset.getInt(4);	
		int huboCnt = rset.getInt(4);
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
													
			<td width=40 height=425 valign=bottom><p align=center ><img src="purple.png" width= 50 height=' <%=fGraph%>'> <br>
			<%=tupyoCnt%>표(<%=avg%>%)</p></td>
	
<%	}	  
	//out.println("</table>");
%>	
	
	<tr>
	<td width=25 colspan = '<%=totalCnt2%>' bgcolor = '#EDDEFA'><p align=center>이름</p></td>
	</tr>
<%	
	ResultSet rset2 = stmt.executeQuery(" select * from hubo_table ");
	while(rset2.next()) {
		String huboName = rset2.getString(2);
		int huboID = rset2.getInt(1);
%>				
			<td width=200><a href="C_02.jsp?name=<%=huboName%>&id=<%=huboID%>"><p align=center>기호<%=huboID%>번<br><%=huboName%></p></a></td>			
<%				
	}
	rset.close();
	rset2.close();
	stmt.close();
	conn.close();
%>
		

	</table>
</body>
</html>