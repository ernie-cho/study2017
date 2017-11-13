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

public String goLogin(String getURL){
	return goXML(getURL, true);
}

public String goXML(String getURL){
	return goXML(getURL, false);
}

public String goXML(String getURL, Boolean loginFlag){
	String Result = null;
	//세션유지 체크
	HttpClient client = getThreadSafeClient();
	HttpConnectionParams.setConnectionTimeout(client.getParams(), 100000); //100초 대기
	HttpConnectionParams.setSoTimeout(client.getParams(), 100000);
	HttpPost post = new HttpPost(getURL);
	
	List <NameValuePair> nameValueParis = new ArrayList<NameValuePair>();
	if(loginFlag) { //여기가 post/get 파라미터를 전달하는 곳
	//	nameValueParis.add(new BasicNameValuePair(uname, value_uname)); //(get,post)ParameterName, Value)
	
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
String s_url = "crawlingAgent_sar.jsp";
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
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt_load = conn.createStatement();
	Statement stmt_update = conn.createStatement();
	
	ResultSet rset = stmt_load.executeQuery("SELECT count(*) FROM crawling_sar;");
	rset.next();
	String rcnt = rset.getString(1);
	
	String time = "";
	String CPU = "";
	String user = "";
	String nice = "";
	String system = "";
	String iowait = "";
	String steal = "";
	String idle = "";
	
	
		rset = stmt_load.executeQuery("SELECT * FROM crawling_sar WHERE server_num = (SELECT MIN(server_num) FROM crawling_sar WHERE last_proc_flag = false);");
	
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS"); 
		String ctime = sdf.format(new java.util.Date()); 
		
		if(rset.next()){
			String ret =goXML(rset.getString(3));
		
		try{
			//DocumentBuilderFactory 객체 생성
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			//DocumentBuilder 객체 생성
			DocumentBuilder builder = factory.newDocumentBuilder();
		
			ByteArrayInputStream is = new ByteArrayInputStream(ret.getBytes("utf-8"));
			//builder를 이용하여 XML 파싱하여 Document 객체 생성
			Document doc = builder.parse(is);
		
			Element root = doc.getDocumentElement();
			NodeList tag_001 = doc.getElementsByTagName("data");
			Element elmt=(Element)tag_001.item(0);
		
			time = elmt.getElementsByTagName("time").item(0).getFirstChild().getNodeValue()+" "+elmt.getElementsByTagName("apm").item(0).getFirstChild().getNodeValue();
			CPU = elmt.getElementsByTagName("CPU").item(0).getFirstChild().getNodeValue();
			user = elmt.getElementsByTagName("user").item(0).getFirstChild().getNodeValue();
			nice = elmt.getElementsByTagName("nice").item(0).getFirstChild().getNodeValue();
			system = elmt.getElementsByTagName("system").item(0).getFirstChild().getNodeValue();
			iowait = elmt.getElementsByTagName("iowait").item(0).getFirstChild().getNodeValue();
			steal = elmt.getElementsByTagName("steal").item(0).getFirstChild().getNodeValue();
			idle = elmt.getElementsByTagName("idle").item(0).getFirstChild().getNodeValue();
			
			stmt_update.execute("UPDATE crawling_sar SET time='"+time+"',CPU='"+CPU+"',user="+user+",nice='"+nice+"',system='"+system +"',iowait='"+iowait+"',steal='"+steal+"',idle='"+idle+"',last_proc_flag = true, last_req_time ='"+ctime+"'WHERE server_num = '"+rset.getString(1)+"';");
		out.println(rset.getString(2)+"님 crawling완료");	
		}catch(Exception e) {
			e.printStackTrace();
			out.println(e);
		}	
		}else{
			stmt_update.execute("UPDATE crawling_sar SET last_proc_flag = false;");
		}
	rset.close();
	stmt_load.close();
	stmt_update.close();
	conn.close();	
	}catch(Exception e) {
		e.printStackTrace();
		out.println(e);
	}
%>
<script>
var timer = setInterval('refresh_start()',1000); <!--1초-->
</script>
</body>
</html>