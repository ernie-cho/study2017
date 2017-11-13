<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
<%@ page import = "java.util.regex.Matcher, java.util.regex.Pattern" %>
<html>
<head>
<%
	//Refresh를 위한 코드
	int iauto= 5000;
	String s_url="crawling.jsp";
	
	String cflag = request.getParameter( "flag" );
	
	if(cflag == null) cflag="0";
	
	int icnt= Integer.parseInt(cflag)+1;
	
	if(icnt > 10) icnt =1;
	s_url=String.format("%s?flag=%d",s_url,icnt);
%>
	<script>
	function refresh_start(){
		location.href='<%=s_url%>'
	}
	</script>
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
public String goLogin(String getURL, String id, String id_value, String passwd, String passwd_value) {
	return goXML("http://192.168.23.102:8080/L08_resort/loginck.jsp", true);
}
public String goXML(String getURL){
	return goXML(getURL, false);
}
public String goXML(String getURL, Boolean loginFlag){
	String Result = null;
	
	//세션유지 체크
	HttpClient client = getThreadSafeClient();
	
	HttpConnectionParams.setConnectionTimeout(client.getParams(), 100000);
	HttpConnectionParams.setSoTimeout(client.getParams(), 100000);
	HttpPost post = new HttpPost(getURL);
	
	List <NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
	if (loginFlag) {  //여기가 post/get 파라미터를 전달하는 곳
		nameValuePairs.add(new BasicNameValuePair("id", "admin"));
		nameValuePairs.add(new BasicNameValuePair("passwd", "admin"));
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

<%
	//로그인후 xml을 조회한다. 내부소스에 이미 세션을 유지하도록 설계되어 있다.
	String ret=goLogin( "http://192.168.23.102:8080/L08_resort/loginck.jsp","id","admin","passwd","admin" );
	ret=goXML( "http://192.168.23.102:8080/L08_resort/login_test.jsp" );
	//out.println(ret);
	
	int cnt = 0;
	Pattern p = Pattern.compile("예약가능");
	Matcher m = p.matcher( ret );
	while (m.find()){
		cnt++;
	}
	out.println("<h2>예약가능 방수 :"+cnt+" 개 </h2>");
	
%>
<center>
iAuto : <%=iauto%><br>
flag : <%=cflag%><br>
</center>
<script>
var timer = setInterval('refresh_start()', <%=iauto%> );
</script>
</body>
</html>