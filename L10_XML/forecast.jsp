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
<%@ page import="java.io.*" %>
<%@ page import="java.text.*,java.util.*,java.sql.*,javax.servlet.*,javax.sql.*,javax.naming.*" %>
<%@ page import = "javax.xml.parsers.*,org.w3c.dom.*" %>
<html>
<head>
	<title>Weather On</title>
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
<body>
<h1>기상청 일기 예보</h1>
<%
	//로그인후 xml을 조회한다. 내부소스에 이미 세션을 유지하도록 설계되어 있다.
	String ret=goXML( "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=61&gridy=123");
	
	//out.println(ret);
	

	
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
		
		out.println("<table cellspacing=1 width=1500 border=1>");
		out.println("<tr>");
		out.println("<td width=100>seq</td>");
		out.println("<td width=100>hour</td>");
		out.println("<td width=100>day</td>");
		out.println("<td width=100>temp</td>");
		out.println("<td width=100>tmx</td>");
		out.println("<td width=100>tmn</td>");
		out.println("<td width=100>sky</td>");
		out.println("<td width=100>pty</td>");
		out.println("<td width=100>wfKor</td>");
		//out.println("<td width=100>wfEn</td>");
		out.println("<td width=100>pop</td>");
		out.println("<td width=100>r12</td>");
		out.println("<td width=100>s12</td>");
		out.println("<td width=100>ws</td>");
		out.println("<td width=100>wd</td>");
		out.println("<td width=100>wdKor</td>");
		//out.println("<td width=100>wdEn</td>");
		out.println("<td width=100>reh</td>");
		out.println("<td width=100>r06</td>");
		out.println("<td width=100>s06</td>");
		out.println("</tr>");
		
		for(int i=0; i<tag_001.getLength(); i++){
			seq=tag_001.item(i).getAttributes().getNamedItem("seq").getNodeValue();
			
			Element elmt=(Element)tag_001.item(i);
			
			hour=elmt.getElementsByTagName("hour").item(0).getFirstChild().getNodeValue();			
			day=elmt.getElementsByTagName("day").item(0).getFirstChild().getNodeValue();			
			temp=elmt.getElementsByTagName("temp").item(0).getFirstChild().getNodeValue();			
			tmx=elmt.getElementsByTagName("tmx").item(0).getFirstChild().getNodeValue();			
			tmn=elmt.getElementsByTagName("tmn").item(0).getFirstChild().getNodeValue();		
			sky=elmt.getElementsByTagName("sky").item(0).getFirstChild().getNodeValue();
			pty=elmt.getElementsByTagName("pty").item(0).getFirstChild().getNodeValue();
			wfKor=elmt.getElementsByTagName("wfKor").item(0).getFirstChild().getNodeValue();			
			//wfEn=elmt.getElementsByTagName("wfEn").item(0).getFirstChild().getNodeValue();
			pop=elmt.getElementsByTagName("pop").item(0).getFirstChild().getNodeValue();			
			r12=elmt.getElementsByTagName("r12").item(0).getFirstChild().getNodeValue();
			s12=elmt.getElementsByTagName("s12").item(0).getFirstChild().getNodeValue();
			ws=elmt.getElementsByTagName("ws").item(0).getFirstChild().getNodeValue();
			wd=elmt.getElementsByTagName("wd").item(0).getFirstChild().getNodeValue();
			wdKor=elmt.getElementsByTagName("wdKor").item(0).getFirstChild().getNodeValue();
			//wdEn=elmt.getElementsByTagName("wdEn").item(0).getFirstChild().getNodeValue();
			reh=elmt.getElementsByTagName("reh").item(0).getFirstChild().getNodeValue();
			r06=elmt.getElementsByTagName("r06").item(0).getFirstChild().getNodeValue();
			s06=elmt.getElementsByTagName("s06").item(0).getFirstChild().getNodeValue();
			
			out.println("<tr>");
			out.println("<td width=100>" +seq+ "</td>");		
			out.println("<td width=100>" +hour+ "</td>");
			out.println("<td width=100>" +day+ "</td>");
			out.println("<td width=100>" +temp+ "</td>");
			out.println("<td width=100>" +tmx+ "</td>");
			out.println("<td width=100>" +tmn+ "</td>");
			out.println("<td width=100>" +sky+ "</td>");
			out.println("<td width=100>" +pty+ "</td>");
			out.println("<td width=100>" +wfKor+ "</td>");
			//out.println("<td width=100>" +wfEn+ "</td>");
			out.println("<td width=100>" +pop+ "</td>");
			out.println("<td width=100>" +r12+ "</td>");
			out.println("<td width=100>" +s12+ "</td>");
			out.println("<td width=100>" +ws+ "</td>");
			out.println("<td width=100>" +wd+ "</td>");
			out.println("<td width=100>" +wdKor+ "</td>");
			//out.println("<td width=100>" +wdEn+ "</td>");
			out.println("<td width=100>" +reh+ "</td>");
			out.println("<td width=100>" +r06+ "</td>");
			out.println("<td width=100>" +s06+ "</td>");
			out.println("</tr>");
		}
		out.println("</table>");
	} catch(Exception e){
		e.printStackTrace();
	}
%>
</body>
</html>