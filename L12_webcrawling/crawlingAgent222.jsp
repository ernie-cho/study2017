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
<%@ page import= "java.io.*" %>
<%@ page import= "java.text.*,java.util.*,java.sql.*,javax.servlet.*,javax.sql.*,javax.naming.*" %>
<%@ page import = "javax.xml.parsers.*,org.w3c.dom.*" %>
<%@ page import = "java.util.regex.Matcher" %>
<%@ page import = "java.util.regex.Pattern" %>
<html>
<head>
<%!
DefaultHttpClient client;

	/**
	 * HttpClient 재사용 관련 서버 통신시 세션을 유지 하기 위함... HttpClient 4.5.3 -> https://hc.apache.org/downloads.cgi
	 */
public DefaultHttpClient getThreadSafeClient(){
		if(client != null)
			return client;
		client = new DefaultHttpClient();
		ClientConnectionManager mgr = client.getConnectionManager();
		HttpParams params = client.getParams();
		client = new DefaultHttpClient(new ThreadSafeClientConnManager(params, mgr.getSchemeRegistry()), params);
		return client;
}

public String goLogin(String getURL, String uname, String value_uname, String upasswd, String value_passwd){
	return goXML(getURL, true, uname, value_uname, upasswd, value_passwd);
}

public String goXML(String getURL){
	return goXML(getURL, false,null,null,null,null);
}

public String goXML(String getURL, Boolean loginFlag, String uname, String value_uname, String upasswd, String value_passwd){
	String Result = null;
	//세션유지 체크
	HttpClient client = getThreadSafeClient();
	HttpConnectionParams.setConnectionTimeout(client.getParams(), 100000); //100초 대기
	HttpConnectionParams.setSoTimeout(client.getParams(), 100000);
	HttpPost post = new HttpPost(getURL);
	
	List <NameValuePair> nameValueParis = new ArrayList<NameValuePair>();
	if(loginFlag) { //여기가 post/get 파라미터를 전달하는 곳
		nameValueParis.add(new BasicNameValuePair(uname, value_uname)); //(get,post)ParameterName, Value)
		nameValueParis.add(new BasicNameValuePair(upasswd, value_passwd));
	}
	
	try{
		post.setEntity(new UrlEncodedFormEntity(nameValueParis));
		HttpResponse responsePost = null;
		
		responsePost = client.execute(post);
		HttpEntity resEntity = responsePost.getEntity();
		
		if(resEntity != null){
			Result = EntityUtils.toString(resEntity).trim();
		}
	}catch (Exception e) {
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
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/test","root","koposw");
	Statement stmt_load = conn.createStatement();
	Statement stmt_update = conn.createStatement();
	
	ResultSet rset = stmt_load.executeQuery("SELECT count(*) FROM crawlingDB;");
	rset.next();
	String rcnt = rset.getString(1);
	
	
	
	rset = stmt_load.executeQuery("SELECT * FROM crawlingDB WHERE server_num = (SELECT MIN(server_num) FROM crawlingDB WHERE last_proc_flag = false);");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS"); //msec까지 설정
	String ctime = sdf.format(new java.util.Date()); //각 row 마다 시간 ms까지 저장
	int cnt = 0;		
	if(rset.next()){
		String ret=goLogin(rset.getString(4),rset.getString(5),rset.getString(6),rset.getString(7),rset.getString(8));	
		ret =goXML(rset.getString(9));										

		cnt = 0;
		
		Pattern p = Pattern.compile("예약가능");
		Matcher m = p.matcher(ret);
		
		while(m.find()){
			cnt++;
		}
				
		stmt_update.execute("UPDATE crawlingDB SET empty_room = "+cnt+", last_proc_flag = true, last_req_time ='"+ctime+"' WHERE server_num = '"+rset.getString(1)+"';");
%>
<center>
<h2><%=rset.getString(1)%> REC의 url crawling완료</h2>
</center>
<%		
	}else{
		stmt_update.execute("UPDATE crawlingDB SET last_proc_flag = false;");
	}

	
	
	rset.close();
	stmt_load.close();
	stmt_update.close();
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