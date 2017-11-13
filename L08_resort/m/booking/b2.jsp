<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %> 
<%@ page import="java.text.SimpleDateFormat, java.util.*, java.util.Locale" %>

<html>
<head>
	<script>
	function formCheck(str) {   

		var f = d_02.fixTitle.value;
		f = f.trim();
		var t = d_02.fixText.value;
		t = t.trim();
		if( f == ""){ 
			alert("INSERT TITLE");
		}
		else if( t == ""){
			alert("INSERT CONTENT");
		}
		else{
			submitForm(str);
		}
	} 	
	function submitForm(mode){
		if(mode == "d_01"){
			d_02.action ="b1.jsp";
			d_02.submit();
		}else if(mode == "d_03"){
			d_02.action = "b3.jsp";
			d_02.submit();
		}
	}
	
	
	</script>
</head>
<body background="image/yellow.png">
<hr></hr>
<h2 align=center>New Reservation<h2>
<hr></hr>
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
		
%>

	<form method="post" name='d_02' action="b3.jsp">	
	<table cellspacing=1  border=1 align=center>
		<tr>
			<td align=center>Name</td>
			<td align=left><input type="text" name=d_02name maxlength=15 value='' required></td>
		</tr>
		<tr>
			<td align=center>Reserved Date</td>
			<td align=left>
<%		if(date_02 != null){%>

		<input type=date name=rev_date min=<%= today%> max=<%= plus30 %> style="border:1px solid #000000;background-color:transparent;" value='<%=date_02%>'>
<%		}else{%>

		<input type=date name=rev_date min=<%= today%> max=<%= plus30 %> style="border:1px solid #000000;background-color:transparent;" value='<%=today%>'>
<%		}%>

			


			</td>
		</tr>
		<tr>
<%
		int roomNum = 0;
		String roomStr = request.getParameter("roomCnt");		
%>			
			<td align=center>Room type</td>
			<td align=left>

			<select name="room">
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
			<td align=center>Address</td>
			<td align=left><input type="text" style="width:300;" name=d_02addr maxlength=80 value='' required></td>
		</tr>		
		<tr>
			<td align=center>Contact</td>
			<td align=left><input type="text" name=d_02tel maxlength=15 value='' required></td>
		</tr>
		<tr>
			<td align=center>Reserved Name</td>
			<td align=left><input type="text" name=d_02Rname maxlength=15 value='' required></td>
		</tr>
		<tr>
			<td align=center>Comment</td>
			<td align=left><input type="text" name=d_02comment maxlength=15 value='' required></td>
		</tr>
		<tr>
		<td align=center colspan=2><input type=submit value="Back" onclick=submitForm('d_01')>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=submit value="Submit" onclick=formCheck('d_03')></td>
		</tr>
	</table>
	</form>	
</body>
</html>