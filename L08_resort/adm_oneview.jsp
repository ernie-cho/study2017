<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %> 
<%@ page import="java.text.SimpleDateFormat, java.util.*, java.util.Locale" %>

<html>
<head>
	<script>
	function formCheck(str) {   

		var f = d_02.d_02name.value;
		f = f.trim();
		var t = d_02.rev_date.value;
		t = t.trim();
		if( f == ""){ 
			alert("이름을 입력해주세요");
		}
		else if( t == ""){
			alert("날짜을 입력해주세요");
		}
		else{
			submitForm(str);
		}
	} 	
	function submitForm(mode){
		if(mode == "d_01"){
			d_02.action ="login_test.jsp";
			d_02.submit();
		}else if(mode == "d_03"){
			d_02.action = "oneviewUpdate.jsp";
			d_02.submit();
		}else if(mode == "oneviewDelete"){
			d_02.action = "oneviewDelete.jsp";
			d_02.submit();
		}
	}
	
	
	</script>
</head>
<body BACKGROUND="/L08_resort/notice.jpg">

<%
	Calendar cal = Calendar.getInstance();
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
	String today = sdf.format(new java.util.Date());
	for(int i=0;i<29;i++){
		sdf.format(cal.getTime());
		cal.add(cal.DATE,+1);
	}
	String plus30 = sdf.format(cal.getTime());
	String date_02 = request.getParameter("date1");
	int roomNum = 0;
	String roomStr = request.getParameter("roomCnt");
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement stmt = conn.createStatement();

	ResultSet rset = stmt.executeQuery(" select * from resort where resv_date = '"+date_02+"' and room = "+roomStr+";");
	rset.next();
	
	String toDelete = rset.getString(2);
	int toDeleteRoom = rset.getInt(3);
%>
<hr></hr>
<h2 align=center><%=rset.getString(1)%>'s Reservation<h2>
<hr></hr>
	<form method="post" name='d_02' action="d_03.jsp">	
	<table cellspacing=1 WIDTH=600 border=1 align=center>
		<tr>
			<td width=150 align=center>Name</td>
			<td width=300 align=left><input type="text" name=d_02name maxlength=15 value='<%=rset.getString(1)%>' required>
			</td>
		</tr>
		<tr>
			<td width=150 align=center>Reserved Date</td>
			<td width=300 align=left>
			<input type=date name=rev_date min=<%= today%> max=<%= plus30 %> style="border:1px solid #000000;background-color:transparent;" value='<%=date_02%>'>
			<input type="hidden" name=rev_dateOriginal value=<%=date_02%>>

			</td>
		</tr>
		<tr>
<%
				
%>			
			<td width=150 align=center>Room type</td>
			<td width=300 align=left>

			<select name="room">  roomOriginal
<%
			if(roomStr == null){
%>				
			<option>VIP</option>
			<option>CABANA</option>
			<option>SUITE</option>			
<%				
			}else{
			roomNum = Integer.parseInt(roomStr);
%>
			<option value='1' <% if(roomNum==1) out.print("selected"); %>>VIP</option>
			<option value='2' <% if(roomNum==2) out.print("selected"); %>>CABANA</option>
			<option value='3' <% if(roomNum==3) out.print("selected"); %>>SUITE</option>
<%				
			}
%>			
			</select></td>			
		
		</tr>		
		<tr>
			<td width=150 align=center>Address</td>
			<td width=300 align=left><input type="text" style="width:300;" name=d_02addr maxlength=80 value='<%=rset.getString(4)%>' required></td>
		</tr>		
		<tr>
			<td width=150 align=center>Contact</td>
			<td width=300 align=left><input type="text" name=d_02tel maxlength=15 value='<%=rset.getString(5)%>' required></td>
		</tr>
		<tr>
			<td width=150 align=center>Reserved Name</td>
			<td width=300 align=left><input type="text" name=d_02Rname maxlength=15 value='<%=rset.getString(6)%>' required></td>
		</tr>
		<tr>
			<td width=150 align=center>Comment</td>
			<td width=300 align=left><input type="text" name=d_02comment maxlength=15 value='<%=rset.getString(7)%>' required></td>
		</tr>
		<input type="hidden" name=deleteDate value='<%=toDelete%>'>
		<input type="hidden" name=deleteRoom value='<%=toDeleteRoom%>'>
		<tr>
		<td width=150 align=center colspan=2><input type=button value="ADMIN" onclick=submitForm('d_01')>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=button value="UPDATE" onclick=formCheck('d_03')>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=button value="DELETE" onclick=submitForm('oneviewDelete')>
		<input type="hidden" name=roomOriginal value=<%=roomStr%> ></td>
		</tr>
	</table>
	</form>	
</body>
</html>