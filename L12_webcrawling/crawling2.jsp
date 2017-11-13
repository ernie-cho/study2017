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
	String s_url="crawling2.jsp";
	
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
	return goXML(getURL, true, id, id_value, passwd, passwd_value);
}
public String goXML(String getURL, String id, String id_value, String passwd, String passwd_value){
	return goXML(getURL, false, id, "", "", "");
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
%>
</head>
<body>
<table cellspacing=1 width=500 border=1 align=center>
<tr>
<td width=20 align=center bgcolor=#DDDDDD>번호</td>
<td width=20 align=center bgcolor=#DDDDDD>리조트 명</td>
<td width=20 align=center bgcolor=#DDDDDD>빈방</td>
<td width=20 align=center bgcolor=#DDDDDD>조회 시간</td>
</tr>
<%	//시간 출력하기
	GregorianCalendar cal = new GregorianCalendar();
	SimpleDateFormat dformat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	//SimpleDateFormat dformat2 = new SimpleDateFormat("HH:mm");
	//SimpleDateFormat dateF = new SimpleDateFormat("E", Locale.KOREAN);
	String calDate="", calDate2="", calE="";
	calDate = dformat.format(cal.getTime());
	//calDate2 = dformat2.format(cal.getTime());
	//calE = dateF.format(cal.getTime());
	//파일 열기
	File f = new File("/var/lib/tomcat7/webapps/ROOT/L12_webcrawling/resort.csv");
	/*파일 연결하는데 FileReader를 이용하게 됨*/
	BufferedReader br = new BufferedReader(new FileReader(f));
	/*시작 시간을 저장할 변수*/
	long startTime = System. currentTimeMillis ();
	//첫줄을 잘라낼 변수
	String cutFirst="";
	//내용을 잘라내서 저장할 변수
	String readtxt="";
	cutFirst = br.readLine();
	//리조트 개수,레코드 개수 출력용
	int cnt2=1, cnt3=0;
	//DATABASE에 insert하기
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();
	
	
	while((readtxt = br.readLine())!=null){
		//out.println("<tr>");
		//번호 출력하기
		out.println("<td width=20 align=center bgcolor=white>"+cnt2+"</td> ");
		//리조트명 출력하기
		String[] field = readtxt.split(",");
		out.println("<td width=20 align=center bgcolor=white>"+field[0]+"</td> ");
	
	
		//로그인후 xml을 조회한다. 내부소스에 이미 세션을 유지하도록 설계되어 있다.
		String ret=goLogin( field[3],field[4],field[5],field[6],field[7] );
		ret=goXML( field[8],field[0],field[5],field[6],field[7] );
		//out.println(ret);
		
	
		
		int cnt = 0;
		Pattern p = Pattern.compile("예약가능");
		Matcher m = p.matcher(ret);
		while (m.find()){
			cnt++;
		}
		out.println("<td width=20 align=center bgcolor=white>"+cnt+"</td>");
		out.println("<td width=20 align=center bgcolor=white>"+calDate+"</td> ");
		out.println("</tr>");
		cnt2++;
		cnt3=cnt2;

	}
	/*종료 시간 측정할 변수*/
	long endTime = System. currentTimeMillis (); 
	long finalTime = endTime - startTime;
	
	conn.close();
	stmt.close();
%>
</table>
<table cellspacing=1 width=500 border=0 align=center>
<tr>
<td align=right>총<%=(cnt3-1)%>개 사이트 CRAWLING시간 : <%=finalTime%>m/s</td>
</tr>
</table>

<script>
var timer = setInterval('refresh_start()', <%=iauto%> );
</script>
</body>
</html>
