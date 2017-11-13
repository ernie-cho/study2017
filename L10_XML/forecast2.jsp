<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import= "org.apache.http.HttpEntity" %>
<%@ page import= "org.apache.http.HttpResponse" %>
<%@ page import= "org.apache.http.NameValuePair" %>
<%@ page import= "org.apache.http.ParseException" %>
<%@ page import= "org.apache.http.client.HttpClient" %>
<%@ page import= "org.apache.http.client.entity.UrlEncodedFormEntity" %>
<%@ page import= "org.apache.http.client.methods.HttpGet" %>
<%@ page import= "org.apache.http.client.methods.HttpPost" %>
<%@ page import= "org.apache.http.impl.client.DefaultHttpClient" %>
<%@ page import= "org.apache.http.message.BasicNameValuePair" %>
<%@ page import= "org.apache.http.params.HttpConnectionParams" %>
<%@ page import= "org.apache.http.util.EntityUtils" %>
<%@ page import= "org.apache.http.conn.ClientConnectionManager" %>
<%@ page import= "org.apache.http.params.HttpParams" %>
<%@ page import= "org.apache.http.impl.conn.tsccm.ThreadSafeClientConnManager" %>
<%@ page import="java.io.*, java.net.*" %>
<%@ page import="java.text.*,java.util.*,java.sql.*,javax.servlet.*,javax.sql.*,javax.naming.*" %>
<%@ page import = "javax.xml.parsers.*,org.w3c.dom.*" %>
<%@ page import="java.text.SimpleDateFormat, java.util.GregorianCalendar, java.util.Locale" %>
<html>
<head>
	<title>Weather</title>
<%!
DefaultHttpClient client;
	/**
	 * HttpClient 재사용 관련 서버 통신시 세션을 유지하기 위함 ..HttpClient 4.5.2 ->https://hc.apache.org/downloads.cgi
	 */
public DefaultHttpClient getThreadSafeClient() {
		if(client != null)
			return client;
		
		client = new DefaultHttpClient();
		ClientConnectionManager mgr = client.getConnectionManager();
		HttpParams params = client.getParams();
		client = new DefaultHttpClient(new ThreadSafeClientConnManager(params, mgr.getSchemeRegistry()), params);
		
		return client;
}


public String goXML(String getURL){
	String Result = null;
	
	//세션유지 체크
	HttpClient client = getThreadSafeClient();
	
	HttpConnectionParams.setConnectionTimeout(client.getParams(), 100000);
	HttpConnectionParams.setSoTimeout(client.getParams(), 100000);
	HttpPost post = new HttpPost(getURL);
	
	List <NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
	if (false) {  //여기가 post/get 파라미터를 전달하는 곳
		nameValuePairs.add(new BasicNameValuePair("gridx", "61"));
		nameValuePairs.add(new BasicNameValuePair("gridy", "123"));
	}
	
	try{
		post.setEntity(new UrlEncodedFormEntity(nameValuePairs));
		HttpResponse responsePost = null;
		
		responsePost = client.execute(post);
		HttpEntity resEntity = responsePost.getEntity();
		
		if (resEntity != null) {
			Result = EntityUtils.toString(resEntity).trim();
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		
	}
	return Result;
}
%>
</head>
<body BACKGROUND="image/bg4.png">

<%
	//로그인후 xml을 조회한다. 내부소스에 이미 세션을 유지하도록 설계되어 있다.
	String ret=goXML( "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=61&gridy=123");
	
	//out.println(ret);
	GregorianCalendar cal = new GregorianCalendar();
	SimpleDateFormat dformat = new SimpleDateFormat("MM월dd일");
	SimpleDateFormat dformat2 = new SimpleDateFormat("HH시mm분");
	SimpleDateFormat dateF = new SimpleDateFormat("E", Locale.KOREAN);
	String calDate="", calDate2="", calE="";
	calDate = dformat.format(cal.getTime());
	calDate2 = dformat2.format(cal.getTime());
	calE = dateF.format(cal.getTime());
	
	
	
%>	

	
<%	
	try{
		String seq="";		//48 시간중 몇번째인지
		String hour="";		//동네예보 3시간 단위
		String day="";		//1번재 날 (0: 오늘 1: 내일 2: 모레)
		String temp="";		//현재 시간온도
		String tmx="";		//최고 온도
		String tmn="";		//최저 온도
		String sky="";		//하늘 상태 코드(1:맑음, 2:구름조금, 3:구름많음, 4:흐림)
		String pty="";		//강수 상태 코드(0:없음, 1:비, 2:비/눈, 3:눈/비, 4:눈)
		String wfKor="";	//날씨 한국어
		String wfEn="";		//날씨 영어
		String pop="";		//강수 확률 %
		String r12="";		//12시간 예상 강수량
		String s12="";		//12시간 예상 적설량
		String ws="";		//풍속(m/s)
		String wd="";		//풍향 (0~7 :북, 북동, 동, 남동, 남, 남서, 서, 북서)
		String wdKor="";	//풍향 한국어
		String wdEn="";		//풍향 영어
		String reh="";		//습도 %
		String r06="";		//6시간 예상 강수량
		String s06="";		//6시간 예상 적설량
	
		String wfKor2=""; 	//이미지용 날씨
		
		//DocumentBuilderFactory 객체생성
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		//DocumentBuilder 객체생성
		DocumentBuilder builder = factory.newDocumentBuilder();
		
		ByteArrayInputStream is = new ByteArrayInputStream(ret.getBytes("utf-8"));
		//builder를 이용하여 XML 파싱하여 Document 객체생성
		Document doc = builder.parse(is);
		
		//생성된 document에서 각 요소들을 접그하여 데이터를 저장함
		Element root = doc.getDocumentElement();
		NodeList tag_001 = doc.getElementsByTagName("data"); // xml name tag
		NodeList tag_002 = doc.getElementsByTagName("tm"); // xml name tag
		//발표시간
		String tm="";
		tm=tag_002.item(0).getFirstChild().getNodeValue();
		String tm_y=tm.substring(0,4);
		String tm_m=tm.substring(4,6);
		String tm_d=tm.substring(6,8);
		String tm_h=tm.substring(8,10);
		String tm_s=tm.substring(10,12);
		Element elmt=(Element)tag_001.item(0);
		temp=elmt.getElementsByTagName("temp").item(0).getFirstChild().getNodeValue();
		temp=temp.substring(0,2);
		wfKor=elmt.getElementsByTagName("wfKor").item(0).getFirstChild().getNodeValue();
		if(wfKor.equals("비")){
			wfKor2 = "<img src=./image/rain_light.png>";
		}
		else if(wfKor.equals("흐림")||wfKor.equals("구름 많음")){
			wfKor2 = "<img src=./image/cloudy.png>";
		}
		else if(wfKor.equals("구름 조금")){
			wfKor2 = "<img src=./image/partly_cloudy.png>";
		}
		else if(wfKor.equals("맑음")){
			wfKor2 = "<img src=./image/sunny.png>";
		}
		pop=elmt.getElementsByTagName("pop").item(0).getFirstChild().getNodeValue();
		reh=elmt.getElementsByTagName("reh").item(0).getFirstChild().getNodeValue();	
		ws=elmt.getElementsByTagName("ws").item(0).getFirstChild().getNodeValue();	
		ws=ws.substring(0,3);			
%>	
	<h1 align=center><font color=white>경기도 성남시 분당구 <%=calDate%> </font></h1>
	<h3 align=center><font color=white><%=tm_y%>년<%=tm_m%>월<%=tm_d%>일 <%=tm_h%>:<%=tm_s%> (<%=calE%>)요일 - 예보</font></h3>
	
		<table cellspacing=1 width=500 border=0 align=center>
		<tr>
		<th><font color=white><%=wfKor%></font></th>	
		</tr>
		<tr>
		<td width=50 rowspan='4'><%=wfKor2%></td>
		<td width=50 rowspan='4'><font size=7 color=white><%=temp%></font></td>
		<td width=100><font size=4 color=white>˚C</font></td>
		<td width=100></td>
		<td width=120><font color=white>강수확률 :<%=pop%>%</font></td>
		</tr>
		<tr>
		<td width=50> </td>
		<td width=50> </td>
		<td width=50><font color=white>습도 : <%=reh%>%</font></td>
		</tr>
		<td width=100></td>	
		<td width=100></td>		
		<td width=100><font color=white>풍속 : <%=ws%>m/s</font></td>
		</tr>
		</table>		
		<hr />
		<table cellspacing=0 width=800 height=50 border=0 align=center>
		<h2 align=center><font color=white><b>기 온</b></font></h2>
<%		
		out.println("<tr>");
		for(int i=0; i<tag_001.getLength(); i++){
			Element elmt2=(Element)tag_001.item(i);
			hour=elmt2.getElementsByTagName("hour").item(0).getFirstChild().getNodeValue();
			day=elmt2.getElementsByTagName("day").item(0).getFirstChild().getNodeValue();
			temp=elmt2.getElementsByTagName("temp").item(0).getFirstChild().getNodeValue();
			temp=temp.substring(0,2);
			String img = "";
			String font= "";
			//오늘 내일 모레
			if(day.equals("0")){
				day="오늘";
				img="";
				font="#FFFFFF";
			}
			else if(day.equals("1")){
				day="내일";
				img="2";
				font="#BFBFBF";
			}
			else if(day.equals("2")){
				day="모레";
				img="3";
				font="#595959";
			}
			//그래프 그리는 부분
			int graph = 0;
			int maxGraph = 100;
			int percent = Integer.parseInt(temp);
			graph = maxGraph-(percent*4);
			int fGraph  = maxGraph-graph;
			out.println("<td width=40 height=250 valign=bottom><p align=center >");
			out.println("<font color=white>"+temp+"˚C</font><br>");
			
%>			<img src="./image/yellow<%=img%>.png" width= 50 height='<%=fGraph%>'><br>
<%
			int hour2 = Integer.parseInt(hour);
			if(hour2 < 12){
				out.println("<font color="+font+">오전<br>"+hour+"시</font>");	
			}else if(hour2 > 12){
				out.println("<font color="+font+">오후<br>"+hour+"시</font>");	
			}else{
				out.println("<font color="+font+">낮<br>"+hour+"시</font>");
			}
			
			
			out.println("<br><font color="+font+">"+day+"</font></td>");
		}out.println("</tr>");
		out.println("</table>");
%>		<hr />
		<table cellspacing=0 width=800 height=50 border=0 align=center>
		<h2 align=center><font color=white><b>강수확률</b></font></h2>
<%		
		out.println("<tr>");
		for(int i=0; i<tag_001.getLength(); i++){
			Element elmt2=(Element)tag_001.item(i);
			hour=elmt2.getElementsByTagName("hour").item(0).getFirstChild().getNodeValue();
			day=elmt2.getElementsByTagName("day").item(0).getFirstChild().getNodeValue();
			pop=elmt2.getElementsByTagName("pop").item(0).getFirstChild().getNodeValue();	
			pop=pop.substring(0,2);
			String img = "";
			String font= "";
			//오늘 내일 모레
			if(day.equals("0")){
				day="오늘";
				img="";
				font="#FFFFFF";
			}
			else if(day.equals("1")){
				day="내일";
				img="2";
				font="#BFBFBF";
			}
			else if(day.equals("2")){
				day="모레";
				img="3";
				font="#595959";
			}
			//그래프
			int graph = 0;
			int maxGraph = 100;
			int percent = Integer.parseInt(pop);
			graph = maxGraph-(percent*4);
			int fGraph  = maxGraph-graph;
			out.println("<td width=40 height=100 valign=bottom><p align=center >");
			out.println("<font color=white>"+pop+"%</font><br>");

%>			<img src="./image/blue<%=img%>.png" width= 50 height='<%=fGraph%>'><br>
<%
			int hour2 = Integer.parseInt(hour);
			if(hour2 < 12){
				out.println("<font color="+font+">오전<br>"+hour+"시</font>");	
			}else if(hour2 > 12){
				out.println("<font color="+font+">오후<br>"+hour+"시</font>");	
			}else{
				out.println("<font color="+font+">낮<br>"+hour+"시</font>");
			}
			
			
			out.println("<br><font color="+font+">"+day+"</font></td>");
		}out.println("</tr>");
		out.println("</table>");
%>		<hr />
		<table cellspacing=0 width=800 height=50 border=0 align=center>
		<h2 align=center><font color=white><b>바 람</b></font></h2>
<%		
		out.println("<tr>");
		for(int i=0; i<tag_001.getLength(); i++){
			Element elmt2=(Element)tag_001.item(i);
			hour=elmt2.getElementsByTagName("hour").item(0).getFirstChild().getNodeValue();
			day=elmt2.getElementsByTagName("day").item(0).getFirstChild().getNodeValue();
			ws=elmt2.getElementsByTagName("ws").item(0).getFirstChild().getNodeValue();
			ws=ws.substring(0,3);
			wd=elmt2.getElementsByTagName("wd").item(0).getFirstChild().getNodeValue();
			String font= "";
			if(day.equals("0")){
				day="오늘";
				font="#FFFFFF";
			}
			else if(day.equals("1")){
				day="내일";
				font="#BFBFBF";
			}
			else if(day.equals("2")){
				day="모레";
				font="#595959";
			}
			out.println("<td width=60 height=50 valign=bottom><p align=center >");
			out.println("<font color=white>"+ws+"m/s</font><br>");
			
			if(wd.equals("0")){
			 wd = "<img src=./image/0.png height=30 width=30>";
			}else if(wd.equals("1")){
			 wd = "<img src=./image/1.png height=30 width=30>";
			}else if(wd.equals("2")){
			 wd = "<img src=./image/2.png height=30 width=30>";
			}else if(wd.equals("3")){
			 wd = "<img src=./image/3.png height=30 width=30>";
			}else if(wd.equals("4")){
			 wd = "<img src=./image/4.png height=30 width=30>";
			}else if(wd.equals("5")){
			 wd = "<img src=./image/5.png height=30 width=30>";
			}else if(wd.equals("6")){
			 wd = "<img src=./image/6.png height=30 width=30>";
			}else if(wd.equals("7")){
			 wd = "<img src=./image/7.png height=30 width=30>";
			}
			out.println(wd+"<br>");
			int hour2 = Integer.parseInt(hour);
			if(hour2 < 12){
				out.println("<font color="+font+">오전<br>"+hour+"시</font>");	
			}else if(hour2 > 12){
				out.println("<font color="+font+">오후<br>"+hour+"시</font>");	
			}else{
				out.println("<font color="+font+">낮<br>"+hour+"시</font>");
			}
			
			out.println("<br><font color="+font+">"+day+"</font></td>");
			
			
			
			
		}out.println("</tr>");		
		out.println("</table>");
%>

<%		
		/////////////////////////////////////////////
		// out.println("<table cellspacing=1 width=1500 border=1>");
		// out.println("<tr>");
		// out.println("<td width=100>seq</td>");
		// out.println("<td width=100>hour</td>");
		// out.println("<td width=100>day</td>");
		// out.println("<td width=100>temp</td>");
		// out.println("<td width=100>tmx</td>");
		// out.println("<td width=100>tmn</td>");
		// out.println("<td width=100>sky</td>");
		// out.println("<td width=100>pty</td>");
		// out.println("<td width=100>wfKor</td>");
		// //out.println("<td width=100>wfEn</td>");
		// out.println("<td width=100>pop</td>");
		// out.println("<td width=100>r12</td>");
		// out.println("<td width=100>s12</td>");
		// out.println("<td width=100>ws</td>");
		// out.println("<td width=100>wd</td>");
		// out.println("<td width=100>wdKor</td>");
		// //out.println("<td width=100>wdEn</td>");
		// out.println("<td width=100>reh</td>");
		// out.println("<td width=100>r06</td>");
		// out.println("<td width=100>s06</td>");
		// out.println("</tr>");
		
		// for(int i=0; i<tag_001.getLength(); i++){
			// seq=tag_001.item(i).getAttributes().getNamedItem("seq").getNodeValue();
			
			// Element elmt=(Element)tag_001.item(i);
			
			// hour=elmt.getElementsByTagName("hour").item(0).getFirstChild().getNodeValue();			
			// day=elmt.getElementsByTagName("day").item(0).getFirstChild().getNodeValue();			
			// temp=elmt.getElementsByTagName("temp").item(0).getFirstChild().getNodeValue();			
			// tmx=elmt.getElementsByTagName("tmx").item(0).getFirstChild().getNodeValue();			
			// tmn=elmt.getElementsByTagName("tmn").item(0).getFirstChild().getNodeValue();		
			// sky=elmt.getElementsByTagName("sky").item(0).getFirstChild().getNodeValue();
			// pty=elmt.getElementsByTagName("pty").item(0).getFirstChild().getNodeValue();
			// wfKor=elmt.getElementsByTagName("wfKor").item(0).getFirstChild().getNodeValue();			
			// //wfEn=elmt.getElementsByTagName("wfEn").item(0).getFirstChild().getNodeValue();
			// pop=elmt.getElementsByTagName("pop").item(0).getFirstChild().getNodeValue();			
			// r12=elmt.getElementsByTagName("r12").item(0).getFirstChild().getNodeValue();
			// s12=elmt.getElementsByTagName("s12").item(0).getFirstChild().getNodeValue();
			// ws=elmt.getElementsByTagName("ws").item(0).getFirstChild().getNodeValue();
			// wd=elmt.getElementsByTagName("wd").item(0).getFirstChild().getNodeValue();
			// wdKor=elmt.getElementsByTagName("wdKor").item(0).getFirstChild().getNodeValue();
			// //wdEn=elmt.getElementsByTagName("wdEn").item(0).getFirstChild().getNodeValue();
			// reh=elmt.getElementsByTagName("reh").item(0).getFirstChild().getNodeValue();
			// r06=elmt.getElementsByTagName("r06").item(0).getFirstChild().getNodeValue();
			// s06=elmt.getElementsByTagName("s06").item(0).getFirstChild().getNodeValue();
			
			// out.println("<tr>");
			// out.println("<td width=100>" +seq+ "</td>");		
			// out.println("<td width=100>" +hour+ "</td>");
			// out.println("<td width=100>" +day+ "</td>");
			// out.println("<td width=100>" +temp+ "</td>");
			// out.println("<td width=100>" +tmx+ "</td>");
			// out.println("<td width=100>" +tmn+ "</td>");
			// out.println("<td width=100>" +sky+ "</td>");
			// out.println("<td width=100>" +pty+ "</td>");
			// out.println("<td width=100>" +wfKor+ "</td>");
			// //out.println("<td width=100>" +wfEn+ "</td>");
			// out.println("<td width=100>" +pop+ "</td>");
			// out.println("<td width=100>" +r12+ "</td>");
			// out.println("<td width=100>" +s12+ "</td>");
			// out.println("<td width=100>" +ws+ "</td>");
			// out.println("<td width=100>" +wd+ "</td>");
			// out.println("<td width=100>" +wdKor+ "</td>");
			// //out.println("<td width=100>" +wdEn+ "</td>");
			// out.println("<td width=100>" +reh+ "</td>");
			// out.println("<td width=100>" +r06+ "</td>");
			// out.println("<td width=100>" +s06+ "</td>");
			// out.println("</tr>");
		// }
		// out.println("</table>");
	} catch(Exception e){
		e.printStackTrace();
	}
%>
</body>
</html>