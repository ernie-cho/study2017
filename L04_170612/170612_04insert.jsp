<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>

<html>
<head>
</head>
<body>
<h2>Insert Data Success</h2>

<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection k20_conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement k20_stmt = k20_conn.createStatement();
	k20_stmt.execute("insert into examtable2 (name, studentid, kor, eng, mat) "
					+ "values ('나연',209901,95,100,95)"); /*나연 학생 정보 입력*/
			k20_stmt.execute("insert into examtable2 (name, studentid, kor, eng, mat) "
					+ "values ('정연',209902,95,95,95)");  /*정연 학생 정보 입력*/
			k20_stmt.execute("insert into examtable2 (name, studentid, kor, eng, mat) "
					+ "values ('모모',209903,100,100,100)");/*모모 학생 정보 입력*/
			k20_stmt.execute("insert into examtable2 (name, studentid, kor, eng, mat) "
					+ "values ('사나',209904,100,95,90)"); /*사나 학생 정보 입력*/
			k20_stmt.execute("insert into examtable2 (name, studentid, kor, eng, mat) "
					+ "values ('지효',209905,80,100,70)"); /*지효 학생 정보 입력*/
			k20_stmt.execute("insert into examtable2 (name, studentid, kor, eng, mat) "
					+ "values ('미나',209906,100,100,70)");/*미나 학생 정보 입력*/
			k20_stmt.execute("insert into examtable2 (name, studentid, kor, eng, mat) "
					+ "values ('다현',209907,70,70,70)");  /*다현 학생 정보 입력*/
			k20_stmt.execute("insert into examtable2 (name, studentid, kor, eng, mat) "
					+ "values ('채영',209908,80,75,72)");  /*채영 학생 정보 입력*/
			k20_stmt.execute("insert into examtable2 (name, studentid, kor, eng, mat) "
					+ "values ('쯔위',209909,78,79,82)");  /*쯔위 학생 정보 입력*/
	
		
	
	
	
	k20_stmt.close();
	k20_conn.close();
%>

</table>
</body>
</html>