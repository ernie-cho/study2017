<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %> 
<html>
<head>
</head>
<body>
<%
try{
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();
	//파일 열기
	File f = new File("/var/lib/tomcat7/webapps/ROOT/L13_sar/sar.csv");
	/*파일 연결하는데 FileReader를 이용하게 됨*/
	BufferedReader br = new BufferedReader(new FileReader(f)); 
		
	//첫줄을 잘라낼 변수
	String cutFirst="";
	//내용을 잘라내서 저장할 변수
	String readtxt="";
	cutFirst = br.readLine();
	
	
	try{
		stmt.execute(" drop table crawling_sar ");
		out.println("drop table crawling_sar OK<br>");
	}catch (Exception e){
		out.println("crawling_sar table couldn't drop<br>");
		out.println( e.toString() );
	}
	stmt.execute("CREATE TABLE crawling_sar (server_num int,"
		+"uName varchar(20),"
		+"sar_url varchar(100) not null,"
		+"time varchar(50)," 
		+"CPU varchar(20),"
		+"user double,"
		+"nice double,"
		+"system double,"
		+"iowait double,"
		+"steal double,"
		+"idle double,"
		+"last_req_time varchar(100),"
		+"last_proc_flag boolean  DEFAULT 0)DEFAULT CHARSET=utf8;");
	
		
	while((readtxt = br.readLine())!= null){
		String[] field = readtxt.split(",");
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS"); 
		String ctime = sdf.format(new java.util.Date()); 
		
		stmt.execute("INSERT INTO crawling_sar(server_num,uName,sar_url)"
		+"VALUES("+field[1]+",'"+field[0]+"','"+field[2]+"');");		
			
	}
	stmt.close();
	conn.close();
	
	out.println("crawling_sar table 생성완료");
}catch(Exception e){
out.println(e);
}
%>

</body>
</html>
