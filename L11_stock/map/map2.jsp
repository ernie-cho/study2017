﻿
<!DOCTYPE html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %> 
<%@ page import="java.text.SimpleDateFormat, java.util.GregorianCalendar, java.util.Locale" %>

<html>
<head>
	<body>
	<center>
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
	<meta charset="euc-kr">
	<hr></hr>
	<title>국토교통부 Open API</title>
<%
String wedo = request.getParameter("we");
String kyungdo = request.getParameter("ky");
String event1 = request.getParameter("EventStatusMsg");
String event2 = new String(event1.getBytes("8859_1"),"utf-8");
%>
	<script src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>
	<script>
		function initialize() {
			var Y_point			= <%=wedo%>;		// Y 좌표
			var X_point			= <%=kyungdo%>;		// X 좌표

			var zoomLevel		= 15;						// 지도의 확대 레벨 : 숫자가 클수록 확대정도가 큼

			var markerTitle		= "<%=event2%>";		// 현재 위치 마커에 마우스를 오버을때 나타나는 정보
			var markerMaxWidth	= 1600;						// 마커를 클릭했을때 나타나는 말풍선의 최대 크기

			// 말풍선 내용
			var contentString	= '<div>' +
			'<h4><%=event2%></h4>'+

			'</div>';

			var myLatlng = new google.maps.LatLng(Y_point, X_point);
			var mapOptions = {
								zoom: zoomLevel,
								center: myLatlng,
								mapTypeId: google.maps.MapTypeId.ROADMAP
			}
			var map = new google.maps.Map(document.getElementById('map_view'), mapOptions);

			var marker = new google.maps.Marker({
													position: myLatlng,
													map: map,
													title: markerTitle
			});

			var infowindow = new google.maps.InfoWindow(
														{
															content: contentString,
															maxWidth: markerMaxWidth
														}
			);

			google.maps.event.addListener(marker, 'click', function() {
				infowindow.open(map, marker);
			});
		}
	</script>
</head>
<body onload="initialize()">
	<div id="map_view" style="width:1000px; height:600px;"></div>
	<table cellpadding='0' cellspacing='1' border='0' width='1200' align=center>
	<tr>
	<td align=center><font size=6 face=calibri color=white><b><%=event2%> </b></font></td>
	</tr>	
	</table>	
</body>
</center>
<hr></hr>
</html>