
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>
<%@ page import="java.text.SimpleDateFormat, java.util.GregorianCalendar, java.util.Locale" %>


<html>
<head>
<script src="http://mbostock.github.com/d3/d3.v2.js"></script>
<script src="js/utils.js"></script>
	<style>
	
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
		.button2{
			height: 30px;
			width: 30px;
			border-radius: 50px;
			border:1x solid #F45F5F;
			background-Color:#323948;
			font:12px 굴림;
			font-weight:bold;
			color:#FFFFFF;
			width:100; height:25;
		}
	td{
		max-width:120px;
		max-height:120px;
	}

	canvas {
        -moz-user-select: none;
        -webkit-user-select: none;
        -ms-user-select: none;
    }

	</style>
	<%
	String s_url = "server5.jsp"; //현페이지 
	%>
	<script>
		function refresh_start(){
			location.href='<%=s_url%>'
		}
		
		//랜덤 숫자 생성
		//cpu
		var randomScalingFactor = function () {
			return Math.round(Math.random() * 100);
		};
		//mem
		var randomScalingFactor1 = function () {
			return Math.round(Math.random() * 100);
		};
		//disk
		var randomScalingFactor2 = function () {
			return Math.round(Math.random() * 100);
		};
		//Free Mem
		var randomScalingFactor3 = function () {
			return Math.round(Math.random() * 100);
		};
		//Free disk
		var randomScalingFactor4 = function () {
			return Math.round(Math.random() * 100);
		};
		//CPU Use Top1
		var randomScalingFactor5 = function () {
			return Math.round(Math.random() * 10);
		};
		//CPU Use Top2
		var randomScalingFactor6 = function () {
			return Math.round(Math.random() * 5);
		};
		//Mem Use Top1
		var randomScalingFactor7 = function () {
			return Math.round(Math.random() * 10);
		};
		//Mem Use Top2
		var randomScalingFactor8 = function () {
			return Math.round(Math.random() * 5);
		};
		//100 - 램덤 숫자
		var cpu_Random = randomScalingFactor();
		var mem_Random = randomScalingFactor1();
		var disk_Random = randomScalingFactor2();
		var free_mem = randomScalingFactor3();
		var free_disk = randomScalingFactor4();
		var cpu_top1 = randomScalingFactor5();
		var cpu_top2 = randomScalingFactor6();
		var mem_top1 = randomScalingFactor7();
		var mem_top2 = randomScalingFactor8();
	</script>


</head>
<body BACKGROUND="image/bg.png"> <!--검청색 배경-->
	
	<script type="text/javascript" src="js/Chart.js"></script>
	
<%
	GregorianCalendar cal = new GregorianCalendar();
	SimpleDateFormat yformat = new SimpleDateFormat("yyyy MMdd");
	SimpleDateFormat dformat = new SimpleDateFormat("H:m:ss");
	String calDate = yformat.format(cal.getTime());
	String calTime = dformat.format(cal.getTime());
%>

<script>
	Chart.pluginService.register({

		afterDraw: function (chart) { //막대그래프 1번3번
			if(chart.config.options.elements.bottom){
				var width = chart.chart.width,
				height = chart.chart.height,
				ctx = chart.chart.ctx;

				ctx.restore();
				var fontSize = (height / 200).toFixed(2);
				ctx.font = fontSize + "em sans-serif";

			
				ctx.textBaseline = "middle";
				//Text color
				ctx.fillStyle = "#FFFFFF";
				
			
				var dataType = chart.config.options.dataType;
				var text = dataType,
				textX = Math.round((width - ctx.measureText(text).width) / 2),
				textY = height / 7 * 3;

				ctx.fillText(text, textX, textY);
				
				var valueString = chart.config.data.datasets[0].data[0];
				var text = valueString + "%",
				textX = Math.round((width - ctx.measureText(text).width) / 2),
				textY = height / 1.15;

				ctx.fillText(text, textX, textY);

				var text =  "tomcat7",
				textX = Math.round((width - ctx.measureText(text).width) / 2),
				textY = height / 1.05;

				ctx.fillText(text, textX, textY);
				ctx.save();
			}else if(chart.config.options.elements.bottom1){ //막대그래프 2번 4번
				var width = chart.chart.width,
				height = chart.chart.height,
				ctx = chart.chart.ctx;

				ctx.restore();
				var fontSize = (height / 200).toFixed(2);
				ctx.font = fontSize + "em sans-serif";

			
				ctx.textBaseline = "middle";
				//Text color
				ctx.fillStyle = "#FFFFFF";
				

				
				var valueString = chart.config.data.datasets[0].data[0];
				var text = valueString + "%",
				textX = Math.round((width - ctx.measureText(text).width) / 2),
				textY = height / 1.15;

				ctx.fillText(text, textX, textY);

				var text =  "www-data",
				textX = Math.round((width - ctx.measureText(text).width) / 2),
				textY = height / 1.05;

				ctx.fillText(text, textX, textY);
				ctx.save();
			}
			else if(chart.config.options.elements.top){
				var width = chart.chart.width,
					height = chart.chart.height,
					ctx = chart.chart.ctx;

					ctx.restore();
					var fontSize = (height / 150).toFixed(2);
					ctx.font = fontSize + "em sans-serif";

				
					ctx.textBaseline = "middle";
					//Text color
					ctx.fillStyle = "#FFFFFF";
					
				
					var dataType = chart.config.options.dataType;
					var text = dataType,
					textX = Math.round((width - ctx.measureText(text).width) / 2),
					textY = height / 10 * 3.1;

					ctx.fillText(text, textX, textY);
					
					var valueString = chart.config.data.datasets[0].label[0];
					var text = valueString,
					textX = Math.round((width - ctx.measureText(text).width) / 2),
					textY = height / 10 * 4.9;

					ctx.fillText(text, textX, textY);

					
					var text =  "―――――",
					textX = Math.round((width - ctx.measureText(text).width) / 2),
					textY = height / 10 * 5.9;

					ctx.fillText(text, textX, textY);

					var valueString = chart.config.data.datasets[0].label[1];
					var text = valueString,
					textX = Math.round((width - ctx.measureText(text).width) / 2),
					textY = height / 10 * 7.2;

					ctx.fillText(text, textX, textY);
					ctx.save();
			}
			else if(chart.config.options.elements.lines){
				var width = chart.chart.width,
				height = chart.chart.height,
				ctx = chart.chart.ctx;

				ctx.restore();
				var fontSize = (height / 30000).toFixed(2);
				ctx.font = fontSize + "em sans-serif";

			
				ctx.textBaseline = "middle";
				//Text color
				ctx.fillStyle = "#FFFFFF";
				
			
				var dataType = chart.config.options.dataType;
				var text = dataType,
				textX = Math.round((width - ctx.measureText(text).width) / 2),
				textY = height / 7 * 3;

				ctx.fillText(text, textX, textY);
				
				var valueString = chart.config.data.datasets[0].data[0];
				var text = valueString + "%",
				textX = Math.round((width - ctx.measureText(text).width) / 2),
				textY = height / 1.05;

				ctx.fillText(text, textX, textY);
				ctx.save();
			}
			else{
				var width = chart.chart.width,
					height = chart.chart.height,
					ctx = chart.chart.ctx;

					ctx.restore();
					var fontSize = (height / 114).toFixed(2);
					ctx.font = fontSize + "em sans-serif";

				
					ctx.textBaseline = "middle";
					//Text color
					ctx.fillStyle = "#FFFFFF";
					
				
					var dataType = chart.config.options.dataType;
					var text = dataType,
					textX = Math.round((width - ctx.measureText(text).width) / 2),
					textY = height / 7 * 3;

					ctx.fillText(text, textX, textY);
					
					var valueString = chart.config.data.datasets[0].data[0];
					var text = valueString + "%",
					textX = Math.round((width - ctx.measureText(text).width) / 2),
					textY = height / 7 * 4;

					ctx.fillText(text, textX, textY);
					ctx.save();
			}
		}

	});
	
	</script>
	<table cellspacing=0 WIDTH=100% HEIGHT=100% border=1 align=center bordercolor=#485367> <!--가장 큰테이블-->
		<tr align=center>
		<!--<td rowspan=5 WIDTH=5%>메뉴</td>-->
		
		<td rowspan=5 WIDTH=2% BACKGROUND="image/bg2.png"></td><!--메뉴와 서버 사이의 빈공간-->
		
		<td colspan=5 HEIGHT=10% BACKGROUND="image/bg2.png">											<!--최상위-->
			<table cellspacing=0 WIDTH=100% HEIGHT=100% border=0 align=center>
				<tr>
					<td WIDTH=20% align=left>
							<table cellspacing=0 WIDTH=100% HEIGHT=100% border=0 align=center>
								<tr HEIGHT=40% align=left>
									<td>
									<input type="button" onclick="location.href='main.jsp'" value="BACK" class="button" >
									</td>
								</tr>
								
							</table>
						</td>
						<td WIDTH=60% align=center><font color="white" size =20><b>Server 5 Status</b></font></td>
						<td WIDTH=20% align=right style="vertical-align:bottom;">
							<div style="text-decoration : underline;" >
								<font color=#03CDC8 size=4><b>DATE <%out.println(calDate);%></b> </font>
								<font color="white" size=4><b>TIME <%out.println(calTime);%></b> </font>
							</div>
					</td>
				</tr>
			</table>
		</td><!--최상위-->
		
		<td rowspan=5 WIDTH=2% BACKGROUND="image/bg2.png"></td><!--서버와 화면 오른쪽 끝 사이의 빈공간-->
		</tr>
		
																							<!--서버쪽 시작-->
		<tr align=center BACKGROUND="image/bg2.png" style="border:0px solid #03CDC8;">
		<td HEIGHT=87%>

		<table border=0 width=100% height=50% cellspacing=0 bordercolor=red>
			<tr height=15%>
				<td BACKGROUND="image/bg.png"><font color="white" size= 6>Network</font></td>
				<td width=1% BACKGROUND="image/bg2.png"></td>
				<td BACKGROUND="image/bg.png">
				<table cellspacing=0 bordercolor=blue border=0>
					<tr>
						<td>
						<font color="white" size= 6>Usage</font>
						</td>
						<td align=right width=100%>
						<input type="button" onclick="location.href='stress.jsp'" value="Stress" class="button2"> 
						</td>
					</tr>
				</table>
				
				</td>
			</tr>
			<tr>
				<td width=32% BACKGROUND="image/bg.png">
							<!--라인그래프-->							
						 <div style="width:100%;">
							  <canvas id="canvas"></canvas>
						</div>
						<script>
							var randomScalingFactor = function() {
								return Math.round(Math.random() * 30.0);
							};
							var config = {
								type: 'line',
								data: {
									labels: ["1", "2", "3", "4", "5", "6", "7"],
									datasets: [{
										label: "PING of 8.8.8.8",
										backgroundColor: window.chartColors.red,
										borderColor: window.chartColors.red,
										data: [
												randomScalingFactor(), 
												randomScalingFactor(), 
												randomScalingFactor(), 
												randomScalingFactor(), 
												randomScalingFactor(), 
												randomScalingFactor(), 
												randomScalingFactor()
											],
										fill: false,
									}]
								},
								options: {
									legend:{
											display: false,
											labels:{
												fontColor: "white",
												
											}
									},
									responsive: true,
									dataType: " ",
									elements: {
										lines: {
										}
									},
									scales: {
										yAxes: [{
											ticks: {
												min: 0,
												max: 30,
												fontColor: 'white'
											}
										}],
										xAxes: [{
											ticks: {
												fontColor: 'white'
											}
										}]
									}
								}
							};

							window.onload = function() {
								var ctx = document.getElementById("canvas").getContext("2d");
								window.myLine = new Chart(ctx, config);
							};
						</script>

							
					
				</td>
				<td width=1% BACKGROUND="image/bg2.png"></td>
				<td width=69% BACKGROUND="image/bg.png" ><!--여기서 원 세개-->
				
					<table border=0 width=100% height=69% cellspacing=0 >	
						<tr><td width=33% align=center>							
								<canvas id="myDoughnut1" height="270" width="320" align=center >
									<script type="text/javascript">
										var context = document.getElementById('myDoughnut1').getContext('2d');
										if(cpu_Random >= 70){
										var myDoughnut1 = new Chart(context, {
											type: 'doughnut',
											data: {
												label: [
													"Red",
													"Blue"
												  ],
											datasets:[{													
													backgroundColor: ["#FF476E", "#FFFFFF"],
													data: [cpu_Random, (100 - cpu_Random)]
												}]
											},
											 options: {
												 dataType: "CPU",
												responsive: false,
												cutoutPercentage: 80
												
											}
										});
										}
										else if(cpu_Random >= 50){
												var myDoughnut1 = new Chart(context, {
													type: 'doughnut',
													data: {
													datasets:[{											
														backgroundColor: ["#FFC000", "#FFFFFF"], //#FFC000 주황색
														data: [cpu_Random, (100-cpu_Random)]
														}]
													},
													 options: {
														 dataType: "CPU",
														responsive: false,
														cutoutPercentage: 80
													}
												});
										}else{
											var myDoughnut1 = new Chart(context, {
												type: 'doughnut',
												data: {
													label: [
														"Red",
														"Blue"
													  ],
												datasets:[{		
													backgroundColor: ["#4BC0C0", "#FFFFFF"],
													data: [cpu_Random, (100 - cpu_Random)]
													}]
												},
												 options: {
													 dataType: "CPU",
													responsive: false,
													cutoutPercentage: 80
													
												}
											});
										}
										
									</script>
								</canvas>
							<!--버튼
							<br><input type="button" onclick="location.href='stress.jsp'" value="Stress" class="button2">-->
						</td>
						<td width=33% align=center>	
								<canvas id="myDoughnut2"height="270" width="320" align=center>
									<script type="text/javascript">
										var context = document.getElementById('myDoughnut2').getContext('2d');
										if(mem_Random >= 70){
										var myDoughnut2 = new Chart(context, {
											type: 'doughnut',
											data: {
											datasets:[{											
												backgroundColor: ["#FF476E", "#FFFFFF"],
												data: [mem_Random,(100-mem_Random)]
												}]
											},
											 options: {
												 dataType: "Mem",
												responsive: false,
												cutoutPercentage: 80
												
											}
										});
										}
										else if(mem_Random >= 50){
												var myDoughnut2 = new Chart(context, {
													type: 'doughnut',
													data: {
													datasets:[{											
														backgroundColor: ["#FFC000", "#FFFFFF"], //#FFC000 주황색
														data: [mem_Random, (100-mem_Random)]
														}]
													},
													 options: {
														 dataType: "Mem",
														responsive: false,
														cutoutPercentage: 80
													}
												});
										}else{
											var myDoughnut2 = new Chart(context, {
												type: 'doughnut',
												data: {
													label: [
														"Red",
														"Blue"
													  ],
												datasets:[{		
													backgroundColor: ["#4BC0C0", "#FFFFFF"],
													data: [mem_Random, (100 - mem_Random)]
													}]
												},
												 options: {
													 dataType: "Mem",
													responsive: false,
													cutoutPercentage: 80
													
												}
											});
										}
									</script>
								</canvas>
								<!--<br><input type="button" onclick="location.href='stress.jsp'" value="Stress" class="button2">-->
						</td>
						<td width=33% align=center>							
								<canvas id="myDoughnut3" height="270" width="320" align=center>
									<script type="text/javascript">
										var context = document.getElementById('myDoughnut3').getContext('2d');
										if(disk_Random >= 70){
											var myDoughnut3 = new Chart(context, {
												type: 'doughnut',
												data: {
												datasets:[{											
													backgroundColor: ["#FF476E", "#FFFFFF"],
													data: [disk_Random,(100-disk_Random)]
													}]
												},
												 options: {
													 dataType: "Disk",
													responsive: false,
													cutoutPercentage: 80
												}
											});
										}else if(disk_Random >= 50){
												var myDoughnut3 = new Chart(context, {
													type: 'doughnut',
													data: {
													datasets:[{											
														backgroundColor: ["#FFC000", "#FFFFFF"], //#FFC000 주황색
														data: [disk_Random, (100-disk_Random)]
														}]
													},
													 options: {
														 dataType: "Disk",
														responsive: false,
														cutoutPercentage: 80
													}
												});
										}
										else{
											var myDoughnut3 = new Chart(context, {
												type: 'doughnut',
												data: {
													label: [
														"Red",
														"Blue"
													  ],
												datasets:[{		
													backgroundColor: ["#4BC0C0", "#FFFFFF"],
													data: [disk_Random, (100 - disk_Random)]
													}]
												},
												 options: {
													 dataType: "Disk",
													responsive: false,
													cutoutPercentage: 80
													
												}
											});
										}
									</script>
								</canvas>
								<!--<br><input type="button" onclick="location.href='stress.jsp'" value="Stress" class="button2">-->
						</td>									
					</tr>
				</table>	
				</td>
			</tr>
		</table>
		<table height=1% width=100% BACKGROUND="image/bg2.png">
			<tr>
				<td colspan=2> </td>
			</tr>
		</table>
		
		<table border=0 width=100% height=49% cellspacing=0 bordercolor=red >
			<tr >
				<td width=45% BACKGROUND="image/bg.png">
					<table border=0 width=100% height=100% cellspacing=0 >	
						<tr>
							<td colspan=2 height=15%><font color="white" size= 6>Free</font></td>
						</tr>
						<tr valign="top">
							<td width=50% align=center>
								<canvas id="myDoughnut4" height="300" width="400" align=center>
									<script type="text/javascript">////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
										var context = document.getElementById('myDoughnut4').getContext('2d');
										if(free_mem >= 70){
											var myDoughnut4 = new Chart(context, {
												type: 'doughnut',
												data: {
												datasets:[{											
													backgroundColor: ["#4BC0C0", "#DBDBEB"],
													data: [free_mem, (100-free_mem)],
													label : [free_mem*2048*20,4046596]
													}]
												},
												 options: {
													 dataType: "Mem Free(kB)",
													responsive: false,
													cutoutPercentage: 90,
													elements: {
														top: {
															
														}
													}
												}
											});
										}else if(free_mem >= 50){
												var myDoughnut4 = new Chart(context, {
													type: 'doughnut',
													data: {
													datasets:[{											
														backgroundColor: ["#FFC000", "#DBDBEB"], //#FFC000 주황색
														data: [free_mem, (100-free_mem)],
														label : [free_mem*2048*20,4046596]
														}]
													},
													 options: {
														 dataType: "Mem Free(kB)",
														responsive: false,
														cutoutPercentage: 90,
														elements: {
															top: {
																
															}
													}
													}
												});
										}else{
											var myDoughnut4 = new Chart(context, {
												type: 'doughnut',
												data: {
												datasets:[{											
													backgroundColor: ["#FF476E", "#DBDBEB"],
													data: [free_mem, (100-free_mem)],
													label : [free_mem*2048*20,4046596]
													}]
												},
												 options: {
													 dataType: "Mem Free(kB)",
													responsive: false,
													cutoutPercentage: 90,
													elements: {
														top: {
															
														}
													}
												}
											});
										}
									</script>
								</canvas>
							</td>
							<td>
								<table border=0 width=100% height=100% cellspacing=0 bordercolor=blue>
									<!--<tr height=50%></tr>
									<tr height=50%>-->
									<tr valign="top"><td align=center >
									<canvas id="myDoughnut5" height="300" width="400" align=center >
										<script type="text/javascript">
											var context = document.getElementById('myDoughnut5').getContext('2d');
											if(free_disk >= 70){
												var myDoughnut5 = new Chart(context, {
													type: 'pie',
													data: {
													datasets:[{											
														backgroundColor: ["#4BC0C0", "#DBDBEB"],
														data: [free_disk, (100-free_disk)],
														label : [free_disk*2,196]
														}]
													},
													 options: {
														 dataType: "Disk Free(G)",
														responsive: false,
														cutoutPercentage: 90,
															elements: {
															top: {
																
															}
														}
													}
												});
											}else if(free_disk >= 50){
												var myDoughnut5 = new Chart(context, {
													type: 'pie',
													data: {
													datasets:[{											
														backgroundColor: ["#FFC000", "#DBDBEB"], //#FFC000 주황색
														data: [free_disk, (100-free_disk)],
														label : [free_disk*2,196]
														}]
													},
													 options: {
														 dataType: "Disk Free(G)",
														responsive: false,
														cutoutPercentage: 90,
														elements: {
															top: {
																
															}
														}
													}
												});
											}else{
												var myDoughnut5 = new Chart(context, {
													type: 'pie',
													data: {
													datasets:[{											
														backgroundColor: ["#FF476E", "#DBDBEB"], 
														data: [free_disk, (100-free_disk)],
														label : [free_disk*2,196]
														}]
													},
													 options: {
														dataType: "Disk Free(G)",
														responsive: false,
														cutoutPercentage: 90,
														elements: {
															top: {
																
															}
														}
													}
												});
											}
											
											
										</script>
									</canvas>
									</td></tr>
								</table>
							</td>
						
						</tr>
				
					</table>
				</td>
				
				
				<td width=27%>
					<table border=0 width=100% height=100% cellspacing=0 bordercolor=green>
						<tr height=15% ><td colspan=2 align=center><font color="white" size= 6 style="text-decoration : underline;">CPU Use Top 2</font></td> </tr>
						<tr>
							<td align=center>
								<canvas id="myBar1" height="120" width="50" align=center>
									<script type="text/javascript">
										var context = document.getElementById('myBar1').getContext('2d');
										var myBar1 = new Chart(context, {										 
											type: 'bar',
											data: {
											datasets:[{
												label: 'tomcat7',												
												backgroundColor: ["#4BC0C0"],
												data: [cpu_top1+6,1]
												}]
											},
											
												options: {
												legend: {
															display: false,
															labels: {
																fontColor: "white",
																fontSize: 14
															}
												},
												dataType: " ",
												elements: {
													bottom: {
													}
												},
												scales: {
													yAxes: [{
														ticks: {
															fontColor: 'white'
															},
													}]
												} 
											}
											});				
									</script>
								</canvas>							
							</td>
							<td align=center>
								<canvas id="myBar3" height="120" width="50" align=center>
									<script type="text/javascript">
										var context = document.getElementById('myBar3').getContext('2d');
										var myBar3 = new Chart(context, {
											type: 'bar',											
											data: {
											datasets:[{	
												label: 'www-data',
												backgroundColor: ["#4BC0C0"],
												data: [cpu_top2+1]
												}]
											},
											options: {
												legend: {
															display: false,
															labels: {
																fontColor: "white",
																fontSize: 14
															}
												},
												dataType: " ",
												elements: {
													bottom1: {
													}
												},
												scales: {
													yAxes: [{
														ticks: {
															fontColor: 'white'
															},
													}]
												} 
											}
										});					
									</script>
								</canvas>							
							</td>
						</tr>
					</table>
				</td>
				<td width=27%>
					<table border=0 width=100% height=100% cellspacing=0 bordercolor=green>
						<tr height=15%><td colspan=2 align=center><font color="white" size= 6 style="text-decoration : underline;">Memory  Use Top 2</font></td> </tr>
							<tr>
								<td align=center>
									<canvas id="myBar2" height="120" width="50" align=center>
										<script type="text/javascript">
											var context = document.getElementById('myBar2').getContext('2d');
											var myBar2 = new Chart(context, {
												type: 'bar',
												data: {
												datasets:[{
													label: 'tomcat7',
													backgroundColor: ["#4BC0C0"],
													data: [mem_top1+6,1]
													}]
												},
												options: {
												legend: {
															display: false,
															labels: {
																fontColor: "white",
																fontSize: 14
															}
												},
												dataType: " ",
												elements: {
													bottom: {
													}
												},
												scales: {
													yAxes: [{
														ticks: {
															fontColor: 'white'
															},
													}]
												} 
											}
											});														
										</script>
									</canvas>							
								</td>
								<td align=center>
									<canvas id="myBar4" height="120" width="50" align=center>									
										<script type="text/javascript">
											var context = document.getElementById('myBar4').getContext('2d');
											var myBar4 = new Chart(context, {
											type: 'bar',											
											data: {
											datasets:[{	
												label: 'mysql2',
												backgroundColor: ["#4BC0C0"],
												data: [mem_top2+1]
												}]
											},
											options: {
												legend: {
															display: false,
															labels: {
																fontColor: "white",
																fontSize: 14
															}
												},
												dataType: " ",
												elements: {
													bottom1: {
													}
												},
												scales: {
													yAxes: [{
														ticks: {
															fontColor: 'white'
															},
													}]
												} 
											}
										});	
										</script>
									</canvas>							
								</td>
							</tr>
					</table>
				</td>
				
			</tr>
		</table>
		 
		</td>
		</tr>
	
		<tr align=center BACKGROUND="image/bg2.png">
			<td colspan=5 HEIGHT=3%></td>		<!--아래공간-->	
		</tr>
		
		
		
	</table> <!--가장 큰테이블-->
		<script>
		var timer = setInterval('refresh_start()',3000); <!--3초-->
		</script>
</body>
</html>