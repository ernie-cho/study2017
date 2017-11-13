<!DOCTYPE html>
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
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>전체 지도 보기</title>
    <style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 100%;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
    </style>
  </head>
  <body>
<%  	//로그인후 xml을 조회한다. 내부소스에 이미 세션을 유지하도록 설계되어 있다.
	String ret=goXML("http://openapi.its.go.kr/api/NEventIdentity?key=1498271446332&ReqType="+
					"2&MinX=127.100000&MaxX=128.890000&MinY=34.100000&MaxY=39.100000&type=its");
	
	//out.println(ret);

	try{
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
%>
    <div id="map"></div>
    <script>

      function initMap() {

        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 3,
          center: {lat: 36.555047, lng: 127.942529}
        });

        // Create an array of alphabetical characters used to label the markers.
        var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

        // Add some markers to the map.
        // Note: The code uses the JavaScript Array.prototype.map() method to
        // create an array of markers based on a given "locations" array.
        // The map() method here has nothing to do with the Google Maps API.
        var markers = locations.map(function(location, i) {
          return new google.maps.Marker({
            position: location,
            label: labels[i % labels.length]
          });
        });

        // Add a marker clusterer to manage the markers.
        var markerCluster = new MarkerClusterer(map, markers,
            {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});
      }
      var locations = [
<%		for(int i=0; i<tag_001.getLength(); i++){
		Element elmt=(Element)tag_001.item(i);	
		//위도, 경도
		coordy=elmt.getElementsByTagName("coordy").item(0).getFirstChild().getNodeValue();	
		coordx=elmt.getElementsByTagName("coordx").item(0).getFirstChild().getNodeValue();	%>
        {lat: <%=coordy%>, lng: <%=coordx%>},
        
<%		}%>
]
<%
	} catch(Exception e){
		e.printStackTrace();
	}%>
    </script>
    <script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js">
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB1jJUPRaJBjpmgp8j4LOG15yna33l8c8A&callback=initMap">
    </script>
  </body>
</html>