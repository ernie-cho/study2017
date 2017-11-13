<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*" %>
<%@ page import="javax.xml.parsers.*, org.w3c.dom.*" %>
<html>
<head>
</head>
<body>
<h1>WIFI 조회</h1>
<%
	
	DocumentBuilder docBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();//파싱을 위한 준비과정
	
	//당연히 파일을 읽을 때 서버 내부 local path로 지정
	Document doc = docBuilder.parse(new File("/var/lib/tomcat7/webapps/ROOT/L09_XML/wifi.xml"));

	Element root = doc.getDocumentElement(); 	//root태그를 가져오기도 하지만 이 소스에서는 쓰이는 곳이 없다.
	
	NodeList tag_address = doc.getElementsByTagName("소재지지번주소"); 	//xml address tag
	
	NodeList tag_latitude = doc.getElementsByTagName("위도"); 	//xml latitude tag
	NodeList tag_longitude = doc.getElementsByTagName("경도"); 	//xml longitude tag
	
%>
	<table cellspacing=1 width=500 border=1>
	<tr>
	<td width=100>순번</td>
	<td width=100>소재지지번주소</td>
	<td width=100>위도</td>
	<td width=100>경도</td>
	</tr>
<%
	for(int i =0; i<tag_address.getLength(); i++){
		//아래와 같은 형식으로 불러온다..
		String address ="";
		if(tag_address.item(i).getFirstChild() != null){
			address =tag_address.item(i).getFirstChild().getNodeValue();
		}
%>
		<tr>
		<td width=100><%=(i+1)%></td>
		<td width=100><%=address%></td>
		<td width=100><%=tag_latitude.item(i).getFirstChild().getNodeValue()%></td>
		<td width=100><%=tag_longitude.item(i).getFirstChild().getNodeValue()%></td>

		</tr>		
<%		
	}
%>
</table>
</body>
</html>
