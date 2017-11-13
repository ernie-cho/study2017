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
	return goXML(getURL, true, id, id_value, passwd, passwd_value);
}
public String goXML(String getURL){
	return goXML(getURL, false, "", "", "", "");
}
public String goXML(String getURL, Boolean loginFlag, String id, String id_value, String passwd, String passwd_value){
	String Result = null;
	
	//세션유지 체크
	HttpClient client = getThreadSafeClient();
	
	HttpConnectionParams.setConnectionTimeout(client.getParams(), 100000);
	HttpConnectionParams.setSoTimeout(client.getParams(), 100000);
	HttpPost post = new HttpPost(getURL);
	
	List <NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
	if (loginFlag) {  //여기가 post/get 파라미터를 전달하는 곳
		nameValuePairs.add(new BasicNameValuePair(id, id_value));
		nameValuePairs.add(new BasicNameValuePair(passwd, passwd_value));
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
String s_url = "crawlingAgent.jsp";
%>
<script>
function refresh_start(){
	location.href='<%=s_url%>'
}
</script>
</head>

<%
	try{
	//DATABASE에서 조회하기
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();
	
	ResultSet rset = stmt.executeQuery("SELECT * FROM crawling WHERE server_num = (SELECT MIN(server_num) FROM crawling WHERE last_proc_flag = false);");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS"); 
	String current = sdf.format(new java.util.Date());
	int cnt = 0;
	
	if(rset.next()){
		String ret=goLogin(rset.getString(2),rset.getString(3),rset.getString(4),rset.getString(5),rset.getString(6));	
		ret =goXML(rset.getString(7));										

		cnt = 0;
		
		Pattern p = Pattern.compile("예약가능");
		Matcher m = p.matcher(ret);
		
		while(m.find()){
			cnt++;
		}
	out.println(rset.getString(11)+"리조트 crawling완료");				
		stmt.execute("UPDATE crawling SET empty_room = "+cnt+", last_proc_flag = true, last_req_time ='"+current+"' WHERE server_num = '"+rset.getString(1)+"';");

		
	}else{
		stmt.execute("UPDATE crawling SET last_proc_flag = false;");
	}
	
	rset.close();
	stmt.close();
	conn.close();	
	}catch(Exception e) {
		e.printStackTrace();
	}
%>
<script>
var timer = setInterval('refresh_start()',1000); <!--1초-->
</script>
</body>
</html>