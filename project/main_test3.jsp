<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>
<%@ page import="java.text.SimpleDateFormat, java.util.GregorianCalendar, java.util.Locale" %>


<html>
<head>
	<script src="http://www.chartjs.org/dist/2.7.0/Chart.bundle.js"></script>
    <script src="../project/js/sample.js"></script>
    <style>
    canvas {
        -moz-user-select: none;
        -webkit-user-select: none;
        -ms-user-select: none;
    }
   
	
		.button{
			height: 50px;
			width: 50px;
			border-radius: 50px;
			border:1x solid #000;
			background-Color:#323948;
			font:12px 굴림;
			font-weight:bold;
			color:#FFFFFF;
			width:130; height:30;
		}
	td{
		max-width:120px;
	}
	</style>
</head>
<body BACKGROUND="image/bg.png"> <!--검청색 배경-->



<%
	GregorianCalendar cal = new GregorianCalendar();
	SimpleDateFormat yformat = new SimpleDateFormat("yyyy MMdd");
	SimpleDateFormat dformat = new SimpleDateFormat("H:m:ss");
	String calDate = yformat.format(cal.getTime());
	String calTime = dformat.format(cal.getTime());
%>
	<table cellspacing=0 WIDTH=100% HEIGHT=100% border=1 align=center  bordercolor=#485367 style="border-left-style:inherit;border-right-style:inherit;border-top-style:inherit;border-bottom-style:inherit;"> <!--가장 큰테이블-->
		<tr align=center>
			<!--<td rowspan=5 WIDTH=5%>메뉴</td>-->
			<td rowspan=5 WIDTH=2% BACKGROUND="image/bg2.png"></td><!--메뉴와 서버 사이의 빈공간-->
			<td colspan=5 HEIGHT=10% BACKGROUND="image/bg2.png">											<!--최상위-->
				<table cellspacing=0 WIDTH=100% HEIGHT=100% border=0 align=center>
					<tr>
						<td WIDTH=25% align=left>
							<table cellspacing=0 WIDTH=100% HEIGHT=100% border=0 align=center>
								<tr HEIGHT=40%>
									<td>
									<div style="text-decoration : underline;" >
									<font color=#03CDC8 size=4><b>DATE <%out.println(calDate);%></b> </font>
									<font color="white" size=4><b>TIME <%out.println(calTime);%></b> </font>
									</div>
									</td>
								</tr>
								<!--<tr HEIGHT=60%>
									<td>
										<img src="image/circle.png" WIDTH=100% HEIGHT=55%>
									</td>
								</tr>-->
							</table>
						</td>
						<td WIDTH=50% align=center><font color="white" size =20><b>System Overview</b></font></td>
						<td WIDTH=25% align=right style="vertical-align:top;">
							<font color="red" size=5><b>ERROR DETECTED</b></font><br>
							<font color="white" size=5><b>DATE <%out.println(calDate);%></b></font><br>
							<font color="white" size=5><b>TIME <%out.println(calTime);%></b></font>
						</td>
					</tr>
				</table>
			</td>
			<td rowspan=5 WIDTH=2% BACKGROUND="image/bg2.png"></td><!--서버와 화면 오른쪽 끝 사이의 빈공간-->
		</tr>
		<!--서버쪽 시작-->
		
			<tr align=center BACKGROUND="image/bg2.png" style="border:1px solid #03CDC8;">
			
		
			<td BACKGROUND="image/bg.png" style="border-right:none;">					<!--서버1 시작-->
				<table cellspacing=0 WIDTH=100% HEIGHT=100% border=0 align=center >
					<tr HEIGHT=12% >
						<td align=left WIDTH=56%>
							<font color="white" size =5><b>Server 1</b></font>
						</td>
						<td align=right>
							<font color="white" size =5><b>OK</b></font> <!--여기서 OK인지 Warning인지 받아야함-->
						</td>
					</tr>
					<tr>
						<td rowspan=2 align=center>	
							<div height="1px" width="1px" >						
							<canvas id="chart-area1" height="50" width="50" style="border:0px solid #000000;" />
							<!--<script src="../project/js/sample.js"></script>-->
							</div>
						</td>
						
						<td align=left vertical-align=bottom>
							<canvas id="chart-area2" height="50" width="50" style="border:0px solid #000000;"/>
							<!--<script src="../project/js/sample.js"></script>-->
						</td>
						<tr>
						<td align=center vertical-align=top>
							<canvas id="chart-area3" height="50" width="50" style="border:0px solid #000000;"/>
							<!--<script src="../project/js/sample.js"></script>-->
						</td>
						
						</tr>
					</tr>
					<tr HEIGHT=10%>
						<td colspan=2 align=center>
							<input type="button" onclick="location.href='server1.jsp'" value="MORE" class="button">
						</td>
					</tr>
				
				</table>
			</td>																 <!--서버1 끝-->
			<td WIDTH=1% style="border-left:none;border-right:none"> </td><!--서버1과 2의 사이 빈공간-->
			<td BACKGROUND="image/bg.png" style="border-left:none;border-right:none">																<!--서버2 시작-->
				<table cellspacing=0 WIDTH=100% HEIGHT=100% border=0 align=center >
					<tr HEIGHT=12%>
						<td align=left WIDTH=56%>
							<font color="white" size =5><b>Server 2</b></font>
						</td>
						<td align=right>
							<font color="white" size =5><b>OK</b></font> <!--여기서 OK인지 Warning인지 받아야함-->
						</td>
					</tr>
					<tr>
						<td rowspan=2 align=center>	
							<div height="1px" width="1px" >						
							<canvas id="chart-area4" height="50" width="50" style="border:0px solid #000000;" />
							<!--<script src="../project/js/sample.js"></script>-->
							</div>
						</td>
						
						<td align=left vertical-align=bottom>
							<canvas id="chart-area5" height="50" width="50" style="border:0px solid #000000;"/>
							<!--<script src="../project/js/sample.js"></script>-->
						</td>
					<tr>
						<td align=center vertical-align=top>
							<canvas id="chart-area6" height="50" width="50" style="border:0px solid #000000;"/>
							<!--<script src="../project/js/sample.js"></script>-->
						</td>
						
					</tr>
					</tr>
					<tr HEIGHT=10%>
						<td colspan=2 align=center>
							<input type="button" onclick="location.href='server2.jsp'" value="MORE" class="button">
						</td>
					</tr>
				
				</table>														
			</td>												<!--서버2 끝-->
			
			<td WIDTH=1% style="border-left:none;border-right:none"></td><!--서버2과 3의 사이 빈공간-->
			
			<td BACKGROUND="image/bg.png" style="border-left:none">																<!--서버3 시작-->
				<table cellspacing=0 WIDTH=100% HEIGHT=100% border=0 align=center >
					<tr HEIGHT=12%>
						<td align=left WIDTH=56%> 
							<font color="white" size =5><b>Server 3</b></font>
						</td>
						<td align=right>
							<font color="white" size =5><b>OK</b></font> <!--여기서 OK인지 Warning인지 받아야함-->
						</td>
					</tr>
					<tr>
						<td rowspan=2 align=center>	
							<div height="1px" width="1px" >						
							<canvas id="chart-area7" height="50" width="50" style="border:0px solid #000000;" />
							<!--<script src="../project/js/sample.js"></script>-->
							</div>
						</td>
						
						<td align=left vertical-align=bottom>
							<canvas id="chart-area8" height="50" width="50" style="border:0px solid #000000;"/>
							<!--<script src="../project/js/sample.js"></script>-->
						</td>
						<tr>
						<td align=center vertical-align=top>
							<canvas id="chart-area9" height="50" width="50" style="border:0px solid #000000;"/>
							<!--<script src="../project/js/sample.js"></script>-->
						</td>						
						</tr>
					</tr>
					<tr HEIGHT=10%>
						<td colspan=2 align=center>
							<input type="button" onclick="location.href='server3.jsp'" value="MORE" class="button">
						</td>
					</tr>
				
				</table>
			</td>																<!--서버3 끝-->
		
			</tr>
		
		
		
		<tr align=center BACKGROUND="image/bg2.png">
			<td colspan=5 HEIGHT=3%></td><!--서버 6개 사이의 빈공간-->
		</tr>
		
		
		<tr align=center BACKGROUND="image/bg2.png" style="border:1px solid #03CDC8;">
			
		
			<td BACKGROUND="image/bgT.png" style="border-right:none;">																<!--서버4 시작-->
					<table cellspacing=0 WIDTH=100% HEIGHT=100% border=0 align=center >
						<tr HEIGHT=12%>
							<td align=left WIDTH=56%>
								<font color="white" size =5><b>Server 4</b></font>
							</td>
							<td align=right>
								<font color="white" size =5><b>OFF</b></font> <!--여기서 OK인지 Warning인지 받아야함-->
							</td>
						</tr>
						<tr>
						<td rowspan=2 align=center>	
							<div height="1px" width="1px" >						
							<canvas id="chart-area10" height="50" width="50" style="border:0px solid #000000;" />
							<!--<script src="../project/js/sample.js"></script>-->
							</div>
						</td>
						
						<td align=left vertical-align=bottom>
							<canvas id="chart-area11" height="50" width="50" style="border:0px solid #000000;"/>
							<!--<script src="../project/js/sample.js"></script>-->
						</td>
						<tr>
						<td align=center vertical-align=top>
							<canvas id="chart-area12" height="50" width="50" style="border:0px solid #000000;"/>
							<!--<script src="../project/js/sample.js"></script>-->
						</td>
						</tr>
					</tr>
						<tr HEIGHT=10%>
							<td colspan=2 align=center>
								<input type="button" onclick="location.href='server4.jsp'" value="MORE" class="button">
							</td>
						</tr>
					
					</table>
				</td>																 <!--서버4 끝-->
			<td WIDTH=1% style="border-right:none;border-left:none"></td><!--서버1과 2의 사이 빈공간-->
			<td BACKGROUND="image/bgR.png" style="border-right:none;border-left:none">																<!--서버5 시작-->
					<table cellspacing=0 WIDTH=100% HEIGHT=100% border=0 align=center >
						<tr HEIGHT=12%>
							<td align=left WIDTH=56%>
								<font color="white" size =5><b>Server 5</b></font>
							</td>
							<td align=right>
								<font color="RED" size =5><b>Warning</b></font> <!--여기서 OK인지 Warning인지 받아야함-->
							</td>
						</tr>
						<tr>
						<td rowspan=2 align=center>	
							<div height="1px" width="1px" >						
							<canvas id="chart-area13" height="50" width="50" style="border:0px solid #000000;" />
							<!--<script src="../project/js/sample.js"></script>-->
							</div>
						</td>
						<td align=left vertical-align=bottom>
							<canvas id="chart-area14" height="50" width="50" style="border:0px solid #000000;"/>
							<!--<script src="../project/js/sample.js"></script>-->
						</td>
						<tr>
						<td align=center vertical-align=top>
							<canvas id="chart-area15" height="50" width="50" style="border:0px solid #000000;"/>
							<!--<script src="../project/js/sample.js"></script>-->
						</td>
						</tr>
					</tr>
						<tr HEIGHT=10%>
							<td colspan=2 align=center>
								<input type="button" onclick="location.href='server5.jsp'" value="MORE" class="button">
							</td>
						</tr>
					
					</table>														
				</td>																<!--서버5 끝-->
			<td WIDTH=1% style="border-right:none; border-left:none"></td><!--서버2과 3의 사이 빈공간-->
			<td BACKGROUND="image/bg.png" style="border-left:none;">																<!--서버6 시작-->
				<table cellspacing=0 WIDTH=100% HEIGHT=100% border=0 align=center >
					<tr HEIGHT=12%>
						<td align=left WIDTH=56%>
							<font color="white" size =5><b>Server 6</b></font>
						</td>
						<td align=right>
							<font color="white" size =5><b>OK</b></font> <!--여기서 OK인지 Warning인지 받아야함-->
						</td>
					</tr>
					<tr>
						<td rowspan=2 align=center>	
							<div height="1px" width="1px" >						
							<canvas id="chart-area16" height="50" width="50" style="border:0px solid #000000;" />
							<!--<script src="../project/js/sample.js"></script>-->
							</div>
						</td>
						<td align=left vertical-align=bottom>
							<canvas id="chart-area17" height="50" width="50" style="border:0px solid #000000;"/>
							<!--<script src="../project/js/sample.js"></script>-->
						</td>
						<tr>
						<td align=center vertical-align=top>
							<canvas id="chart-area18" height="50" width="50" style="border:0px solid #000000;"/>
							<!--<script src="../project/js/sample.js"></script>-->
						</td>
						</tr>
					</tr>
					<tr HEIGHT=10%>
						<td colspan=2 align=center>
							<input type="button" onclick="location.href='server6.jsp'" value="MORE" class="button">
						</td>
					</tr>
				
				</table>
			</td>																<!--서버6 끝-->
		
			</tr>
		
		
		<tr align=center BACKGROUND="image/bg2.png">
			<td colspan=5  HEIGHT=3%> </td>
			
		</tr>
	</table>
</body>