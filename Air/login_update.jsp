<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page import="java.text.*, javax.util.*, java.io.*, java.net.*" %>
<%@ page import="java.sql.*, javax.sql.*"%>
<html>
<head>
<script type="text/javascript">
	function formCheck(str) {   

		var f = insertData.insertID.value;
		f = f.trim();
		var t = insertData.insertPW.value;
		t = t.trim();
		var s = insertData.insertPW2.value;
		s = s.trim();
		if( f == ""){ 
			alert("아이디를 입력해주세요");
		}
		else if( t == ""){
			alert("패스워드를 입력해주세요");
		}
		else if( t != s){
			alert("패스워드가 일치 하지 않습니다");
		}
		else{
			submitForm(str);
		}
	} 	
	function submitForm(mode){
		if(mode == "cancle"){
			insertData.action = "main.jsp";
			insertData.submit();
		}else if(mode == "write"){
			
			insertData.action = "login_update_query.jsp";
		}
		insertData.submit();
	}

</script>
</head>
<body BACKGROUND="image/bg11.png">
<%
	String jump = request.getParameter("jump");
		/////세션을 체크해서 없다면 로그인창으로 보냄 그리고 로그인이 되면 자기자신에게 와야 하므로
	/////자기자신의 url을 써줘야 한다 
	
		String loginOK=null;
		String loginID=null;
		String jumpURL="login.jsp?jump=login_update.jsp";
		
		loginOK = (String)session.getAttribute("login_ok");
		if(loginOK==null){
			response.sendRedirect(jumpURL);
			return;
		}
		if(!loginOK.equals("yes")){
			response.sendRedirect(jumpURL);
			return;
		}
	//로그인 된 상태에 보여줄 콘텐츠
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();	
	loginID = (String)session.getAttribute("login_id");
	ResultSet rset = stmt.executeQuery(" select * from airsign where id = '"+loginID+"' ");
	rset.next();
	loginID = rset.getString(1);
	String loginPW = rset.getString(2);
	String loginPW2 = rset.getString(3);
	String loginEmail = rset.getString(4);
	//out.println("접속된 ID : "+loginID);
	//out.println("<br>비밀번호 : "+loginPW);
	//out.println("<br>이메일 : "+loginEmail);
%>
	<form method='post' name='insertData'>
		<fieldset>
			<legend align=center>회원 정보 수정</legend>
			<table cellspacing=0 WIDTH=400 border=0 align=center>
				<tr>
					<td><label for="id">아이디</label></td>
					<td><input type=text  maxlength=50 name=insertID value="<%=loginID%>" readonly></td>
				</tr>

				<tr>
					<td><label for="pwd">비밀번호</label></td>
					<td><input type=password  maxlength=50 name=insertPW  value=""></td>
				</tr>
				<tr>
					<td><label for="pwd">비밀번호 확인</label></td>
					<td><input type=password  maxlength=50 name=insertPW2 value=""></td>
				</tr>
				<tr>
					<td><label for="email">이메일</label></td>
					<td><input type=text  maxlength=50 name=email value="<%=loginEmail%>"></td>
				</tr>
				<tr>
					<td colspan="2" align="right">					
						<input type="button" name=write value="수정" onClick=formCheck('write');>
						<input type="button" name=cancle value="취소" onClick=submitForm('cancle');>
					</td>
				</tr>
			</table>
		</fieldset>

	</form>
	
	
	

</body>
</html>