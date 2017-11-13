<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>
<%@ page import="java.text.SimpleDateFormat, java.util.GregorianCalendar, java.util.Locale" %>
<html>
<head>
</head>
<body>
<hr></hr>
<h2 align=center>테이블 생성<h2>
<hr></hr>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();
	
	//시간 출력하기
	GregorianCalendar cal = new GregorianCalendar();
	SimpleDateFormat dformat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss:SSS");	
	String calDate="";
	calDate = dformat.format(cal.getTime());
	
	//파일 열기
	File f = new File("/var/lib/tomcat7/webapps/ROOT/L12_webcrawling/resort.csv");
	/*파일 연결하는데 FileReader를 이용하게 됨*/
	BufferedReader br = new BufferedReader(new FileReader(f));

	//첫줄을 잘라낼 변수
	String cutFirst="";
	//내용을 잘라내서 저장할 변수
	String readtxt="";
	cutFirst = br.readLine();
	

	
	try{
		stmt.execute(" drop table crawling ");
		out.println("drop table crawling OK<br>");
	}catch (Exception e){
		out.println("crawling table couldn't drop<br>");
		out.println( e.toString() );
	}										  
		stmt.execute(" create table crawling(server_num int, login_url varchar(200), uName varchar(50), uValue varchar(50), pName varchar(50), pValue varchar(50), adm_allview_url varchar(200), empty_room int, last_req_time varchar(30), last_proc_flag boolean, resort_name varchar(50), link varchar(200)) default charset=utf8");
		
	int cnt=0;
	String sql="";
	while((readtxt = br.readLine())!=null){
		String[] field = readtxt.split(",");
		cnt++;
		sql=" insert into crawling values("+cnt+", '"+field[3]+"', '"+field[4]+"', '"+field[5]+"', '"+field[6]+"', '"+field[7]+"', '"+field[8]+"', 0, '"+calDate+"', 0, '"+field[0]+"' , '"+field[9]+"')"; 
		stmt.execute(sql);
	}	
	out.println("생성완료");
	stmt.close();
	conn.close();
%>
