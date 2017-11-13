<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<meta name="viewport" content="user-scable= no, width=device-width" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<script language='javascript' type='text/javascript'>
var orientationEvent;
var uAgent=navigator.userAgent.toLowerCase();
var mobilePhones= 'android';
if(uAgent.indexOf(mobilePhones)!=-1){
	orientationEvent="resize";   //안드로이드는 resize로 들어옴
	document.write('<link rel="shortcut icon" href="icon.png" />') ;
}
else orientationEvent="orientationchange"; //아이폰은 이렇게 들어옴
window.addEventListener(orientationEvent, function() 
{
//	alert("회전했어요");
	location.href('#');             
}, false); 

var prevScreen=0;
var sv_prevScreen=0;
function prevShow()
{
	ScreenShow( prevScreen );
}

var muCnt   = 5;  //서브메뉴
var scCnt   = 15; //화면

function fncShow( pos )
{
    var i   = 0;
	for( i=0; i<scCnt; i++ )
    {
        var obj = document.getElementById("s"+i);
	    obj.style.display   = 'none';
    }
    for( i=0; i<muCnt; i++ )
    {
        var obj = document.getElementById("menu"+i);
		var obj2 = document.getElementById("m"+i);

        if( i == pos )
        {
            obj.style.display   = '';
			obj2.style.background="#96ceb4";
        }
        else
        {
            obj.style.display   = 'none';
			obj2.style.background="#ffcc5c";
        }
    }
}

var scCnt   = 15;
var ScrObj;

var timer1;

function ScrAnimation() {
	var offset = -50;

		if (parseInt(ScrObj.style.left) > 10 ) 
		{
            ScrObj.style.left = parseInt(ScrObj.style.left) + offset + "px";
            timer1 = setTimeout("ScrAnimation()", 1);
		} else {
			ScrObj.style.left=5;
		    clearTimeout(timer1);
      	}
}
function ScreenShow( pos )
{
    var i   = 0;
	
	//모든 메뉴페이지는 막는다.
	for( i=0; i<muCnt; i++ )
    {
        var obj = document.getElementById("menu"+i);
	    obj.style.display   = 'none';
    }

    for( i=0; i<scCnt; i++ )
    {
		var obj = document.getElementById("s"+i);

        if( i == pos )
        {
			prevScreen = sv_prevScreen;
			sv_prevScreen=i;
			
            obj.style.display   = '';

			obj.style.position="relative";
			obj.style.top=35;
			obj.style.left=screen.width;
			obj.style.height=screen.height-120;

			ScrObj=obj;
			ScrAnimation();
        }
        else
        {
            obj.style.display   = 'none';
        }
    }
}
</script>
<style type="text/css">
li {text-align:left;vertical-align:middle; margin:2; padding:10; height:20; background-color:#ffeead; border:2px; solid:red; font-size:16px}
ul {text-align:left;vertical-align:middle; margin:2; padding:10; height:20; background-color:#ffcc5c; border:2px; solid:red; font-size:16px}
</style> 

</head>
<body background="image/yellow.png" onload='ScreenShow(0);'>
<center>
	<div id="container" style="width:device-width;height:device-height;">
		<div id="header1" style="background-color:#ffcc5c;height:35px;width:15%;float:left;" onclick='prevShow();'><center>
			<img src= "image/back.png" width=40px height=32px></center></div>
		<div id="header2" style="background-color:#ffcc5c;height:35px;width:70%;float:left;">
		<center style="margin:10px;"><font size=5 face=calibri color=white><b>HIMALYA RESORT</b></font></center></div>
		<div id="header3" style="background-color:#ffcc5c;height:35px;width:15%;float:left;" onclick='ScreenShow(0);'><center>
			<img src= "image/home.png" width=30px height=32px></center></div>

		<div id="menu0" style="background-color:#ffcc5c;display:none;width:device-width">
		<font size=6 face=calibri color=white><b>ABOUT RESORT</b></font></li>  
			<li onclick='ScreenShow(0);'><font size=5 face=calibri color=#ffcb4f><b>RESORT</b></font></li>
			<li onclick='ScreenShow(1);'><font size=5 face=calibri color=#ffcb4f><b>VIP</b></font></li>
			<li onclick='ScreenShow(2);'><font size=5 face=calibri color=#ffcb4f><b>CABANA</b></font></li>
			<li onclick='ScreenShow(3);'><font size=5 face=calibri color=#ffcb4f><b>SUITE</b></font></li>
			<br>
		</div>
		<div id="menu1" style="background-color:#ffcc5c;display:none;width:device-width">
		<font size=6 face=calibri color=white><b>LOCATION</b></font></li>
			<li onclick='ScreenShow(4);'><font size=5 face=calibri color=#ffcb4f><b>LOCATION</b></font></li>
			<li onclick='ScreenShow(5);'><font size=5 face=calibri color=#ffcb4f><b>DIRECTION</b></font></li>
			<br>
		</div>
		<div id="menu2" style="background-color:#ffcc5c;display:none;width:device-width">
		<font size=6 face=calibri color=white><b>AROUND</b></font></li>
			<li onclick='ScreenShow(7);'><font size=5 face=calibri color=#ffcb4f><b>CLIMBING</b></font></li>
			<li onclick='ScreenShow(8);'><font size=5 face=calibri color=#ffcb4f><b>BEACH</b></font></li>
			<li onclick='ScreenShow(9);'><font size=5 face=calibri color=#ffcb4f><b>SPA</b></font></li>
			<br>
		</div>
		<div id="menu3" style="background-color:#ffcc5c;display:none;width:device-width">
		<font size=6 face=calibri color=white><b>RESERVATION</b></font></li>
			<li onclick='ScreenShow(10);'><font size=5 face=calibri color=#ffcb4f><b>BOOK TABLE</b></font></li>
			<li onclick='ScreenShow(11);'><font size=5 face=calibri color=#ffcb4f><b>RESERVATION</b></font></li>
			<br>
		</div>
		<div id="menu4" style="background-color:#ffcc5c;display:none;width:device-width">
		<font size=6 face=calibri color=white><b>NEWS</b></font></li>
			<li onclick='ScreenShow(12);'><font size=5 face=calibri color=#ffcb4f><b>NOTICE</b></font></li>
			<br>
		</div>

		<div id="s0" style="background-image:url(image/yellow.png);display:none;width:device-width;" >
			<center>
			<font size=5 face=calibri color=#ffcc5c><b>WELCOME TO HIMALAYA RESORT</b></font>
			<img src= "image/words2.png" width=80% height=60%>
			<br>
			</center>			
		</div>
		<div id="s1"style="background-image:url(image/yellow.png);display:none;width:device-width;" >
			<center>
			
			<img src= "image/room/vip2.jpg" width=200px height=150px>
			<img src= "image/room/vip3.jpg" width=200px height=150px>
			<img src= "image/room/vip1.jpg" width=200px height=150px>
			<br><font size=7 face=calibri color=#ffcb4f><b>VIP ROOM TYPE</b></font>
			</center>			</div>
		<div id="s2" style="background-image:url(image/yellow.png);display:none;width:device-width;">
			<center>
			<img src= "image/room/cabana.jpg" width=200px height=150px>
			<img src= "image/room/cabana1.jpg" width=200px height=150px>
			<img src= "image/room/cabana2.jpg" width=200px height=150px>

			<br><font size=7 face=calibri color=#ffcb4f><b>CABANA TYPE</b></font>
			</center>			</div>
		<div id="s3" style="background-image:url(image/yellow.png);display:none;width:device-width;">
			<center>
			<img src= "image/room/single.jpg" width=200px height=150px>
			<img src= "image/room/single1.jpg" width=200px height=150px>
			<img src= "image/room/single2.jpg" width=200px height=150px>

			<br><font size=7 face=calibri color=#ffcb4f><b>SUITE TYPE</b></font>
			</center>	
		</div>
		<div id="s4" style="background-image:url(image/yellow.png);display:none;">
			<iframe src="map.html" frameborder="0" border="0" bordercolor="white" 
		 width=100% height=100% marginwidth="10" marginheight="10" 
			scroling="yes" ></iframe>
		</div>
		<div id="s5" style="background-image:url(image/yellow.png);display:none;">
			<img src= "image/air.PNG" width=80% height=70%>
  			<br>
		</div>
		<div id="s6" style="background-image:url(image/yellow.png);display:none;">
			<img src= "b_03.jpg" width=200px height=150px>
  			<br>
		</div>
		<div id="s7" style="background-image:url(image/yellow.png);display:none;">
			<img src= "image/around/climbing.jpg" width=200px height=150px>
			<img src= "image/around/climbing1.jpg" width=200px height=150px>
			<img src= "image/around/climbing2.jpg" width=200px height=150px>

			<br><font size=7 face=calibri color=#ffcb4f><b>CLIMBING</b></font>
		</div>  
		<div id="s8" style="background-image:url(image/yellow.png);display:none;">
			<img src= "image/around/beach.jpg" width=200px height=150px>
			<img src= "image/around/beach1.jpg" width=200px height=150px>
			<img src= "image/around/beach2.jpg" width=200px height=150px>

			<br><font size=7 face=calibri color=#ffcb4f><b>BEACH</b></font>
		</div>
		<div id="s9" style="background-image:url(image/yellow.png);display:none;">
			<img src= "image/around/spa.jpg" width=200px height=150px>
			<img src= "image/around/spa1.jpg" width=200px height=150px>
			<img src= "image/around/spa2.jpg" width=200px height=150px>

			<br><font size=7 face=calibri color=#ffcb4f><b>SPA</b></font>
		</div>
		<div id="s10" style="background-image:url(image/yellow.png);display:none;">
			<iframe src="booking/b1.jsp" frameborder="0" border="0" bordercolor="white" 
		 width="100%" height="90%" marginwidth="10" marginheight="10" 
			scroling="yes" ></iframe>
		</div>
		<div id="s11" style="background-image:url(image/yellow.png);display:none;">
		 <iframe src="booking/b2.jsp" frameborder="0" border="0" bordercolor="white" 
		 width="100%" height="90%" marginwidth="10" marginheight="10" 
			scroling="yes" ></iframe>
		</div>
		<div id="s12" style="background-image:url(image/yellow.png);display:none;">
			<iframe src="comment/gongji_list.jsp" frameborder="0" border="0" bordercolor="white" 
		 width="100%" height="90%" marginwidth="10" marginheight="10" 
			scroling="yes" ></iframe>
		</div>
		<div id="s13" style="background-image:url(image/yellow.png);display:none;">
		 
		</div>
		<div id="s14" style="background-image:url(image/yellow.png);display:none;">
		
		</div>
<footer id="footer">
		<div id="m0" onclick='fncShow(0);' 
		style="position:fixed;bottom:3px;position:fixed;left:1%;background-color:#ffcc5c;height:80px;width:18%;float:left;">
				<center>
				<img src= "image/resort.png" width=40px height=40px><br>
				<font size=3 face=calibri color=white><b>ABOUT<br>RESORT</b></font></center></div>
		<div id="m1" onclick='fncShow(1);' 
		style="position:fixed;bottom:3px;position:fixed;left:21%;background-color:#ffcc5c;height:80px;width:18%;float:left;">
				<center>
				<img src= "image/pin.png" width=40px height=40px><br>
				<font size=3 face=calibri color=white><b>LOCATION</b></font></center></div>
		<div id="m2" onclick='fncShow(2);' 
		style="position:fixed;bottom:3px;position:fixed;left:41%;background-color:#ffcc5c;height:80px;width:18%;float:left;">
				<center>
				<img src= "image/around.png" width=40px height=40px><br>
				<font size=3 face=calibri color=white><b>AROUND</b></font></center></div>
		<div id="m3" onclick='fncShow(3);' 
		style="position:fixed;bottom:3px;position:fixed;left:61%;background-color:#ffcc5c;height:80px;width:18%;float:left;">
				<center>
				<img src= "image/book.png" width=40px height=40px><br>
				<font size=3 face=calibri color=white><b>RESERVATION</b></font></center></div>
		<div id="m4" onclick='fncShow(4);' 
		style="position:fixed;bottom:3px;position:fixed;left:81%;background-color:#ffcc5c;height:80px;width:18%;float:left;">
				<center>
				<img src= "image/note.png" width=40px height=40px><br>
				<font size=3 face=calibri color=white><b>NEWS</b></font></center></div>	
	</div>
	</footer>
</center>
</body>
</html> 