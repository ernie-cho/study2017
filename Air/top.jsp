<!DOCTYPE html> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>
<html>
 <head>
  <title> Welcome to UNITED Airline </title> 
 <style type='text/css'> 
 td { font-size:12; text-align:center; } 
 a:link {text-decoration:none; } 
 a:visited {text-decoration:none;} 
 a:hover {text-decoration:none; } 
 a:acvite {text-decoration:none;} 
 </style> 
 <script language='javascript' type='text/javascript' > //<![CDATA[ 
 var muCnt = 5; 
 function fncShow(pos){ 
 var i = 0; 
 for( i; i<muCnt; i++ ) { 
	var obj = document.getElementById("menu"+i); 
	var obj2 = document.getElementById("m"+i); 
	if( i == pos ) { 
		obj.style.display = ''; 
		obj2.style.color="#ff0000"; 
	} else { 
		obj.style.display = 'none';
		obj2.style.color="#000000"; 
	} 
  } 
} 
function fncHide(pos){ 
	var obj = document.getElementById("menu"+pos); 
	obj.style.display = 'none'; 
} 
//]]>
</script> 
</head > 
<body bgcolor="#AFD1F4">
 <center>
 <table cellpadding='0' cellspacing='1' border='0' width='750'>
 <td width='150'><a href='main.jsp' target=main><img src="image/unitedLogo-white.png"  border='0'></a> 
 </td> 
 <td> 
 <table cellpadding='0' cellspacing='1' border='0' width='700' height='60'> 
	<tr height='30'> 	
	<td width='100' onmouseover='fncShow(0);' id='m0'><font size=3 face=calibri color=white><b>항공사 안내</b> </font> </td> 
	<td width='100' onmouseover='fncShow(1);' id='m1'><font size=3 face=calibri color=white><b>좌석 예약</b> </font> </td>  
	<td width='100' onmouseover='fncShow(2);' id='m2'><font size=3 face=calibri color=white><b>나의 페이지</b> </font> </td>  
	<td width='100' onmouseover='fncShow(3);' id='m3'><font size=3 face=calibri color=white><b>회원 가입</b> </font></td> 
	<td width='100' onmouseover='fncShow(4);' id='m4'><font size=3 face=calibri color=white><b>공 지 사 항</b></font></td>
<%String login_id=(String)session.getAttribute("login_id");
if(login_id!=null){%>	
	<td width='400' colspan=2 onmouseover='fncShow(5);' id='m5'><font size=3 face=calibri color=#F5FCBD><b><%=login_id%>님</b></font></td> 
<%}%>
	<td width=100'></td> 
	</tr> 
	<tr height='30'> 
	<td colspan='6'> 
	<table id='menu0' style='display:none;' cellpadding='0' cellspacing='0' border='0' width='600' height='30'> 
		<tr> 
			<td width='0' ></td> 
			<td width='600' style='text-align:left;' > 
				<font size=3 face=calibri>
				<a href='a_04.html' target=main> 
				<span onmouseover=this.style.color='white' onmouseout=this.style.color='#58ABFD'><b>| 회사안내  </b></span>
				</font>
				</a> 
				<font size=3 face=calibri>
				<a href='a_01.html' target=main>
				<span onmouseover=this.style.color='white' onmouseout=this.style.color='#58ABFD'><b>| 항공기 안내  </b></span> 
				</font>
				</a> 
				<font size=3 face=calibri>
				<a href='a_02.html' target=main> 
				<span onmouseover=this.style.color='white' onmouseout=this.style.color='#58ABFD'><b>| 운행지역 안내  </b></span> 
				</font>
				</a> 
				<font size=3 face=calibri>
				<a href='a_03.html' target=main> 
				<span onmouseover=this.style.color='white' onmouseout=this.style.color='#58ABFD'><b>| 운행요금 안내 |</b></span>
				</font>
				</a>
			</td> 
		</tr> 
	</table> 
	<table id='menu1' style='display:none;' cellpadding='0' cellspacing='0' border='0' width='600' height='30'> 
		<tr> 
			<td width='100' ></td> 
			<td width='500' style='text-align:left;' > 
				<font size=3 face=calibri>
				<a href='b_01.jsp' target=main> 
				<span onmouseover=this.style.color='white' onmouseout=this.style.color='#58ABFD'><b>| 김포<->제주 |</b></span> 
				</font>
				</a> 
				<font size=3 face=calibri>
				<a href='b_02.jsp' target=main>
				<span onmouseover=this.style.color='white' onmouseout=this.style.color='#58ABFD'><b> 예약하기 |</b></span> 
				</font>
				</a> 
				
			</td> 
		</tr> 
	</table> 
	<table id='menu2' style='display:none;' cellpadding='0' cellspacing='0' border='0' width='600' height='30'> 
		<tr> 
			<td width='200' ></td> 
			<td width='500' style='text-align:center;' >
			
<%			if(login_id==null){%>	
			<font size=3 face=calibri>			
				<a href='login.jsp' target=main> 
				 <span onmouseover=this.style.color='white' onmouseout=this.style.color='#58ABFD'><b>| 로 그 인  </b></span> 
				</font>
				</a> 
<%}			if(login_id!=null){%>
				<font size=3 face=calibri>
				<a href='logout.jsp' target=main> 
				<span onmouseover=this.style.color='white' onmouseout=this.style.color='#58ABFD'><b>| 로그 아웃</b></span> 
				</font>
				</a>
<%}%>			<font size=3 face=calibri>
				<a href='login_update.jsp' target=main>
				<span onmouseover=this.style.color='white' onmouseout=this.style.color='#58ABFD'><b>| 회원정보 수정 </b></span> 
				</font>
				</a> 
				<font size=3 face=calibri>
				<a href='login_info.jsp' target=main> 
				<span onmouseover=this.style.color='white' onmouseout=this.style.color='#58ABFD'><b>| 나의 예약현황 |</b></span> 
				</font>
				</a> 
			
			</td> 
		</tr> 
	</table> 	
	<table id='menu3' style='display:none;' cellpadding='0' cellspacing='0' border='0' width='600' height='30'> 
		<tr> 
			<td width='300' ></td> 
			<td width='500' style='text-align:center;' >
<%			
			if(login_id==null){
%>	
				<font size=3 face=calibri>			
				<a href='join.jsp' target=main> 
				<span onmouseover=this.style.color='white' onmouseout=this.style.color='#58ABFD'><b>|회원 가입  </b></span> 
				</font>
				</a> 
<%}
%>
				<font size=3 face=calibri>
				<a href='join_out.jsp' target=main>
				<span onmouseover=this.style.color='white' onmouseout=this.style.color='#58ABFD'><b>|회원 탈퇴 |</b></span> 
				</font>
				</a> 
				<font size=3 face=calibri>
				<a href='login_test.jsp' target=main> 
				<span onmouseover=this.style.color='white' onmouseout=this.style.color='#58ABFD'><b></b></span> 
				</font>
				</a> 
				<font size=3 face=calibri>
				<a href='logout.jsp' target=main> 
				<span onmouseover=this.style.color='white' onmouseout=this.style.color='#58ABFD'><b></b></span> 
				</font>
				</a> 
			</td> 
		</tr> 
	</table> 
	<table id='menu4' style='display:none;' cellpadding='0' cellspacing='0' border='0' width='600' height='30'> 
		<tr> 
			<td width='350' ></td> 
			<td width='250' style='text-align:center;' > 
				<font size=3 face=calibri>
				<a href='gongji/gongji_list.jsp' target=main> 
				<span onmouseover=this.style.color='white' onmouseout=this.style.color='#58ABFD'><b>| 알리는 글  </b></span> 
				</font>
				</a> 
				<font size=3 face=calibri>
				<a href='gongji/comment/gongji_list.jsp' target=main>
				<span onmouseover=this.style.color='white' onmouseout=this.style.color='#58ABFD'><b>| 고객의 소리 |</b></span> 
				</font>
				</a> 
			</td> 
		</tr> 
	</table> 
	</td>
	</tr>
	</table>
	</td>
	</table>
  </center>
</body>
</html>
