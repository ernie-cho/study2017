<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %> 
<%@ page import="java.text.SimpleDateFormat, java.util.GregorianCalendar, java.util.Locale" %>

<html>
<head>
</head>
<body BACKGROUND="/L08_resort/bg2.png">
<hr></hr>
<h2 align=center>Reservation Table<h2>
<hr></hr>
<%
	GregorianCalendar cal = new GregorianCalendar();
	SimpleDateFormat dformat = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat dateF = new SimpleDateFormat("E", Locale.KOREAN);
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();

	ResultSet rset = stmt.executeQuery(" select * from resort ");
	String Rname="", Raddr="", Rtelnum="", Rin_name="", Rcomment="";
	int Rroom=0, Rprocessing=0;
	String Rresv_date="", Rwrite_date="", calDate="", calE="", chkRoom="";
	rset.next();
	Rresv_date = rset.getString(2);	
	Rroom = rset.getInt(3);
	rset = stmt.executeQuery(" select * from resort where resv_date = '"+Rresv_date+"' and room = "+Rroom+" ");
	rset.next();
	int checkRoom= rset.getInt(3);
	String newDate = rset.getString(2);
%>
	<form method="post" action="d_02.jsp">	
	<table cellspacing=1 WIDTH=600 border=1 align=center>
	<tr>
		<td width=150 align=center>DATE</td>							
		<td width=150 align=center>VIP</td>
		<td width=150 align=center>CABANA</td>	
		<td width=150 align=center>SUITE</td>	
	</tr>
<%	//calDate = dformat.format(cal.getTime());
	//calE = dateF.format(cal.getTime());
	String vipStatus="", cabanaStatus="", suiteStatus="";
	for(int i=0; i <30; i++){
		rset = stmt.executeQuery(" select resv_date, "
								+ " (select name from resort where resv_date='"+dformat.format(cal.getTime())+"' and room=1 group by resv_date)as vip, "
								+ " (select name from resort where resv_date='"+dformat.format(cal.getTime())+"' and room=2 group by resv_date)as cabana, "
								+ " (select name from resort where resv_date='"+dformat.format(cal.getTime())+"' and room=3 group by resv_date)as suite"
								+ " from resort where resv_date='"+dformat.format(cal.getTime())+"' group by resv_date, vip, cabana, suite; "); 
			calDate = dformat.format(cal.getTime());
				calE = dateF.format(cal.getTime());
			// 해당 날짜에 출력값이 있는지 없는지 확인하는 조건문			
			if(rset.next() == false) {				
				vipStatus = "SELECT";
				cabanaStatus  = "SELECT";
				suiteStatus = "SELECT";
			} else {
				calDate = rset.getString(1);
				vipStatus = rset.getString(2);
				cabanaStatus = rset.getString(3);
				suiteStatus = rset.getString(4);
					//VIP 이름중간에 별표시하기				
					if(rset.getString(2) != null){
							if(vipStatus.length() > 2){
							int lenghtVip = (vipStatus.length());
							String vipStatus1 = vipStatus.substring(0,1);
							
							for(int j=0; j<(vipStatus.length()-2);j++){
								vipStatus1 = vipStatus1 +"*" ;
							}
							String vipStatusLast = vipStatus.substring((lenghtVip-1), (lenghtVip));
							vipStatus = vipStatus1+vipStatusLast;
						}
					}
					//cabana 이름중간에 별표시하기				
					if(rset.getString(3) != null){
							if(cabanaStatus.length() > 2){
							int lenghtcabana = (cabanaStatus.length());
							String cabanaStatus1 = cabanaStatus.substring(0,1);
							
							for(int j=0; j<(cabanaStatus.length()-2);j++){
								cabanaStatus1 = cabanaStatus1 +"*" ;
							}
							String cabanaStatusLast = cabanaStatus.substring((lenghtcabana-1), (lenghtcabana));
							cabanaStatus = cabanaStatus1+cabanaStatusLast;
						}
					}
					//suite 이름중간에 별표시하기				
					if(rset.getString(4) != null){
							if(suiteStatus.length() > 2){
							int lenghtsuite = (suiteStatus.length());
							String suiteStatus1 = suiteStatus.substring(0,1);
							
							for(int j=0; j<(suiteStatus.length()-2);j++){
								suiteStatus1 = suiteStatus1 +"*" ;
							}
							String suiteStatusLast = suiteStatus.substring((lenghtsuite-1), (lenghtsuite));
							suiteStatus = suiteStatus1+suiteStatusLast;
						}
					}
								
				if(vipStatus == null ||vipStatus.equals(null) || vipStatus.equals("null")){
					vipStatus = "SELECT";
				}
				if(cabanaStatus == null || cabanaStatus.equals(null) || cabanaStatus.equals("null")){
					cabanaStatus = "SELECT";
				}
				if(suiteStatus == null || suiteStatus.equals(null) || suiteStatus.equals("null")){
					suiteStatus = "SELECT";
				}	
			}
%>		
	<tr>
<%
		if(calE.equals("토")||calE.equals("일")){
%>			
		<td width=150 align=center><font color=red><%=calDate%>(<%=calE%>)</td>	
<%			
		}else{
%>		<td width=150 align=center><%=calDate%>(<%=calE%>)</td>			
<%
		}		
		//예약 가능할 때와 안될때 구분해주기
		if(vipStatus.equals("SELECT")){
%>
		<td width=150 align=center><a href ="d_02.jsp?date1=<%=calDate%>&roomCnt=1"><%=vipStatus%></a></td>
<%						
		}else{
%>
		<td width=150 align=center><%=vipStatus%></a></td>
<%		}
		if(cabanaStatus.equals("SELECT")){
%>		
		<td width=150 align=center><a href ="d_02.jsp?date1=<%=calDate%>&roomCnt=2"><%=cabanaStatus%></a></td>
<%						
		}else{
%>
		<td width=150 align=center><%=cabanaStatus%></td>
<%		}
		if(suiteStatus.equals("SELECT")){
%>			
		<td width=150 align=center><a href ="d_02.jsp?date1=<%=calDate%>&roomCnt=3"><%=suiteStatus%></a></td>
		
<%						
		}else{
%>
		<td width=150 align=center><%=suiteStatus%></a></td>	
<%		}
%>
	</tr>	
		
<%		//계산 날짜 증가
		cal.add(cal.DATE,+1);
	}
%>
</table>
</form>



<%
	rset.close();
	stmt.close();
	conn.close();
%>
</body>
</html>