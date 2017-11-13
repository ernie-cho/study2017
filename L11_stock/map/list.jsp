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
<%@ page import="java.text.*,java.util.*,javax.servlet.*,javax.sql.*,javax.naming.*" %>
<%@ page import = "javax.xml.parsers.*,org.w3c.dom.*" %>
<%@ page import="java.net.*, java.text.DecimalFormat, java.text.SimpleDateFormat" %>

<html>
<head>
	<title>국토교통부 Open API</title>
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
	// if (false) {  //여기가 post/get 파라미터를 전달하는 곳
		// nameValuePairs.add(new BasicNameValuePair("gridx", "61"));
		// nameValuePairs.add(new BasicNameValuePair("gridy", "123"));
	// }
	
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
<hr />
<h1 align=center>도로 공사 정보</h1>
<hr />
<form method="post" action="map1.jsp">
<table cellspacing=1 width=1500 border=0 align=center>
<tr>
<td width=30 align=right><input type=submit name=map value=전체지도보기></td>
</tr>
</table>
</form>
<%
	//로그인후 xml을 조회한다. 내부소스에 이미 세션을 유지하도록 설계되어 있다.
	String ret=goXML("http://openapi.its.go.kr/api/NEventIdentity?key=1498271446332&ReqType="+
					"2&MinX=127.100000&MaxX=128.890000&MinY=34.100000&MaxY=39.100000&type=its");
	
	//out.println(ret);

	try{
		String EventType="";			// 1.공사정보유형
		String LanesBlockType="";		// 2.공사로 인한 차로 차단 방법 
		String LanesBlocked="";			// 3.공사로 인해 차단된 차로 수
		String EventStartDay="";		// 4.공사 시작일
		String EventEndDay="";			// 5.공사 종료일
		String EventStartTime="";		// 6.공사 실제 개시 시간
		String EventEndTime="";			// 7.공사 실제 종료 시간
		String EventStatusMsg="";		// 8.공사 상황정보 메시지
		String ExpectedDetourMsg="";	// 9.우회정보 메시지
		String EventDirection="";		// 10.진행방향
		//위도 경도
		String coordy="";				//위도
		String coordx="";				//경도
	
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
		
		out.println("<table cellspacing=1 width=1500 border=1 align=center>");
		out.println("<tr>");
		
		out.println("<td width=20 align=center bgcolor=#DDDDDD>공사<br>정보유형</td>");
		out.println("<td width=50 align=center bgcolor=#DDDDDD>차단<br>방법</td>");
		out.println("<td width=50 align=center bgcolor=#DDDDDD>차단된 차로 수</td>");
		out.println("<td width=50 align=center bgcolor=#DDDDDD>공사 시작일</td>");
		out.println("<td width=50 align=center bgcolor=#DDDDDD>공사 종료일</td>");
		//out.println("<td width=100 align=center bgcolor=#DDDDDD>공사 실제<br>개시 시간</td>");
		//out.println("<td width=100 align=center bgcolor=#DDDDDD>공사 실제<br>종료 시간</td>");
		out.println("<td width=300 align=center bgcolor=#DDDDDD>공사 상황정보 메시지</td>");
		//out.println("<td width=100 align=center bgcolor=#DDDDDD>우회정보 메시지</td>");
		out.println("<td width=50 align=center bgcolor=#DDDDDD>진행방향</td>");
		out.println("<td width=30 align=center bgcolor=#DDDDDD>지도 보기</td>");
		out.println("</tr>");
		
		for(int i=0; i<tag_001.getLength(); i++){	
	
			Element elmt=(Element)tag_001.item(i);		
			EventType=elmt.getElementsByTagName("eventtype").item(0).getFirstChild().getNodeValue();		
			LanesBlockType=elmt.getElementsByTagName("lanesblocktype").item(0).getFirstChild().getNodeValue();				
			if(LanesBlockType.equals("0")){
				LanesBlockType = "통제<br>없음";
			}else if(LanesBlockType.equals("1")){
				LanesBlockType = "갓길<br>통제";
			}else if(LanesBlockType.equals("2")){
				LanesBlockType = "차로<br>부분통제";
			}else if(LanesBlockType.equals("3")){
				LanesBlockType = "전면<br>통제";
			}else if(LanesBlockType.equals("4")){
				LanesBlockType = "정보<br>없음";
			}else if(LanesBlockType.equals("5")){
				LanesBlockType = "정보<br>없음";
			}
			LanesBlocked=elmt.getElementsByTagName("lanesblocked").item(0).getFirstChild().getNodeValue();			
			EventStartDay=elmt.getElementsByTagName("eventstartday").item(0).getFirstChild().getNodeValue();
				String date = EventStartDay;
				//SimpleDateFormat의 형식을 선언한다.
				SimpleDateFormat original = new SimpleDateFormat("yyyyMMdd");
				SimpleDateFormat new_format = new SimpleDateFormat("yyyy.MM.dd");
				//날짜 형식 변환시 파싱 오류를 try.. catch..로 체크한다.
				String new_date ="";
				try{
					//문자열 타입을 날짜 타입으로 변환한다.
					Date original_date = original.parse(date);
					
					//날짜 형식을 원하는 타입으로 변경한다.
					 new_date = new_format.format(original_date);
					} catch (ParseException e){
						e.printStackTrace();
					}
			if(elmt.getElementsByTagName("eventendday").item(0).getFirstChild() == null)
				EventEndDay = "20170715";
			else
				EventEndDay=elmt.getElementsByTagName("eventendday").item(0).getFirstChild().getNodeValue();
			
				String date2 = EventEndDay;
				//SimpleDateFormat의 형식을 선언한다.
				SimpleDateFormat original2 = new SimpleDateFormat("yyyyMMdd");
				SimpleDateFormat new_format2 = new SimpleDateFormat("yyyy.MM.dd");
				//날짜 형식 변환시 파싱 오류를 try.. catch..로 체크한다.
				String new_date2 ="";
				try{
					//문자열 타입을 날짜 타입으로 변환한다.
					Date original_date = original2.parse(date2);
					
					//날짜 형식을 원하는 타입으로 변경한다.
					 new_date2 = new_format2.format(original_date);
					} catch (ParseException e){
						new_date2 = "-";
						//e.printStackTrace();
					}
			//EventStartTime=elmt.getElementsByTagName("eventstarttime").item(0).getFirstChild().getNodeValue();	
			//EventEndTime=elmt.getElementsByTagName("eventendtime").item(0).getFirstChild().getNodeValue();	
			EventStatusMsg=elmt.getElementsByTagName("eventstatusmsg").item(0).getFirstChild().getNodeValue();		
			//ExpectedDetourMsg=elmt.getElementsByTagName("expecteddetourmsg").item(0).getFirstChild().getNodeValue();
			EventDirection=elmt.getElementsByTagName("eventdirection").item(0).getFirstChild().getNodeValue();	
			//위도, 경도
			coordy=elmt.getElementsByTagName("coordy").item(0).getFirstChild().getNodeValue();	
			coordx=elmt.getElementsByTagName("coordx").item(0).getFirstChild().getNodeValue();				
					
			out.println("<tr>");
			out.println("<form method=\"post\" action=\"map2.jsp\">");
			out.println("<td width=20 align=center>" +EventType+ "</td>");		
			out.println("<td width=50 align=center>" +LanesBlockType+ "</td>");
			out.println("<td width=50 align=center>" +LanesBlocked+ "</td>");
			out.println("<td width=50 align=center>" +new_date+ "</td>");
			out.println("<td width=50 align=center>" +new_date2+ "</td>");
			//out.println("<td width=100>" +EventStartTime+ "</td>");
			//out.println("<td width=100>" +EventEndTime+ "</td>");
			out.println("<td width=300 align=left>" +EventStatusMsg+ "</td>");
			out.println("<input type=hidden name=EventStatusMsg value='"+EventStatusMsg+"'>");
			//out.println("<td width=100>" +ExpectedDetourMsg+ "</td>");
			out.println("<td width=50 align=center>" +EventDirection+ "</td>");
			//위도, 경도 히든으로 보내주기
			out.println("<input type=hidden name=we value="+coordy+">");
			out.println("<input type=hidden name=ky value="+coordx+">");
			out.println("<td width=30 align=center><input type=submit name=map value=지도보기></td>");
			out.println("</form>");
			out.println("</tr>");
			
		}
		out.println("</table>");
		
	} catch(Exception e){
		e.printStackTrace();
	}
%>
</body>
</html>