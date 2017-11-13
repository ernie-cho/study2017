<%@ page contentType="text/html; charset=UTF-8" %> <!-- 한글 처리 UTF-8을 씀 -->
<%@ page import = "java.io.*" %>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>

<html>
<head>
<title>텍스트 파일 읽어 오기</title>
</head>
<body>
<%
FileReader fr = null;
 
 try {
  fr = new FileReader("/var/lib/tomcat7/webapps/ROOT/L03_170609/freewifi.txt"); 
  BufferedReader br = new BufferedReader(fr);
  String readtxt=null;
  	if((readtxt = br.readLine())==null){
		out.println("빈 파일입니다");
	}
  //데이터의 첫줄을 삭제하는 용도
  String[] field_name = readtxt.split("\t");
  //While문에서 사용할 카운트 변수
  int lineCnt = 0;
  //융합기술원의 위도,경도
  double lat = 37.3860521;
  double lng = 127.1214038;
  double dist = 0;
  //테이블 생성
  out.println("<table border=1 align=center cellspacing = 0 cellpadding = 0>");
  out.println("<tr>");
		out.println("<td width=100> 번호 </td>");
		out.println("<td width=500> 주소 </td>");
		out.println("<td width=100> 위도 </td>");
		out.println("<td width=100> 경도 </td>");
		out.println("<td width=100> 거리 </td>");
		out.println("</tr>");
	//파라미터를 위한 변수 생성
		int fromPT = 0;
		int cntPT = 0;
	//파라미터 	
	if( request.getParameter("from") == null){
		fromPT = 1;
		cntPT = 10;
	}else{
		fromPT=Integer.parseInt(request.getParameter("from"));
		cntPT=Integer.parseInt(request.getParameter("cnt"));
	}
	//시작지점 음수처리/
	if (fromPT < 1) {
		fromPT= 1;
	}
	//데이터를 읽으면서 테이블에 insert
	  while((readtxt = br.readLine())!= null){
		  lineCnt++;
		  if(lineCnt < fromPT ) continue;
		  if(lineCnt >= fromPT+cntPT) break;
	  String[] field = readtxt.split("\t");
	  dist = Math.sqrt( Math.pow(Double.parseDouble(field[12]) - lat, 2)
							+ Math.pow(Double.parseDouble(field[13]) - lng, 2));
	  out.println("<tr>");					
	  out.println("<td width=100>"+(lineCnt)+"</td>");	  
	  out.println("<td width=500>"+field[9]+"</td>");
	  out.println("<td width=100>"+field[12]+"</td>");
	  out.println("<td width=100>"+field[13]+"</td>");
	  out.println("<td width=100>"+dist+"</td>");
	  out.println("</tr>");
	  
	  }	
	  //계산에 필요한 변수 생성
	  int selectMax =10;
	  int currentPage = 0;
	  int startPage =1;	  
	  int cnt = cntPT;	 
	  int pageEnd = lineCnt/10;
	  int lastRec = 14821;
	  //페이지 이동에 관한 계산 조건
	  if(fromPT%cnt==0){
		  currentPage = fromPT/cnt;
	  }else{
		 currentPage = fromPT/cnt+1;
	  }//현재 페이지에서 이전과 다음 페이지를 위한 계산
	  if( currentPage > 5){
		  startPage = currentPage-5;
		  selectMax = currentPage+5;
	  }else{//시작점이 7이하이면 시작페이지를 1로 고정
		  startPage = 1;
	  }	  
	  if(currentPage >= 1480){ //마지막 10페이지를 고정 시키기
		  //startPage =1475;
		  selectMax = selectMax+(currentPage-(currentPage+(currentPage-1479)));	 
	  }
	  out.println("</table>");
	  out.println("<table border=0 align=center cellspacing = 0 cellpadding = 0>");
	  out.println("<tr>");
	  //처음 페이지
	  String firstPage="http://192.168.23.102:8080/L03_170609/wifi2.jsp?from=1&cnt="+(cnt);
	  out.println("<td width=50 align=center>"+"<a href="+firstPage+">"+"처음"+"</a>"+"</td>");
	  //이전 페이지
	  String beforePage="http://192.168.23.102:8080/L03_170609/wifi2.jsp?from="+((startPage-2)*cnt+1)+"&cnt="+(cnt);
	  if(currentPage <= 6){
		  beforePage="http://192.168.23.102:8080/L03_170609/wifi2.jsp?from=1&cnt="+(cnt);
	  }
	  out.println("<td width=50 align=center>"+"<a href="+beforePage+">"+"이전"+"</a>"+"</td>");
	  //현재 페이지와 그 앞뒤 페이지 계산
	  for(int i=startPage; i<selectMax ;i++){ 
	  String pageNum="http://192.168.23.102:8080/L03_170609/wifi2.jsp?from="+((i-1)*cnt+1)+"&cnt="+(cnt);
		  if(currentPage==i){
			  out.println("<td width=25 align=center >"+"<a href="+pageNum+">"+
			  "<font size = 5>"+"<b>"+(i)+"</b>"+"</font size>"+"</a>"+"</td>"); 
		  }else{
			   out.println("<td width=25 align=center >"+"<a href="+pageNum+">"+
			   "<font size = 3>"+(i)+"</font size>"+"</a>"+"</td>"); 
		  }
	  }
	  //다음 페이지
	  String nextPage="http://192.168.23.102:8080/L03_170609/wifi2.jsp?from="+((startPage+9)*cnt+1)+"&cnt="+(cnt);
	   if(currentPage >= 1479 && currentPage <=1480){ //마지막 3페이지의 다음 버튼을 고정 시키기
		  String nextPage1="http://192.168.23.102:8080/L03_170609/wifi2.jsp?from="+((startPage+((currentPage+8)-currentPage))*cnt+1)+"&cnt="+(cnt);
		  out.println("<td width=50 align=center>"+"<a href="+nextPage1+">"+"다음"+"</a>"+"</td>");
	   }
	   else if(currentPage == 1481){
		  String nextPage2="http://192.168.23.102:8080/L03_170609/wifi2.jsp?from="+((startPage+(1488-currentPage))*cnt+1)+"&cnt="+(cnt);
		  out.println("<td width=50 align=center>"+"<a href="+nextPage2+">"+"다음"+"</a>"+"</td>");
	   }
	   else if(currentPage == 1482){
		  String nextPage3="http://192.168.23.102:8080/L03_170609/wifi2.jsp?from="+((startPage+(1489-currentPage))*cnt+1)+"&cnt="+(cnt);
		  out.println("<td width=50 align=center>"+"<a href="+nextPage3+">"+"다음"+"</a>"+"</td>");
	   }
	   else if(currentPage <= 1482){
		  out.println("<td width=50 align=center>"+"<a href="+nextPage+">"+"다음"+"</a>"+"</td>");
	   }else{}
		  
	  //마지막 페이지
	  String lastPage="http://192.168.23.102:8080/L03_170609/wifi2.jsp?from="+lastRec+"&cnt="+(cnt);
	  out.println("<td width=50 align=center>"+"<a href="+lastPage+">"+"마지막"+"</a>"+"</td>");
	  //테이블 닫기
	  out.println("</tr>");
	  out.println("</table>");
	  
	  
	  
 }catch(IOException ex){
  out.println("예외발생:" + ex.getMessage());
 }finally{
  if (fr != null) try { fr.close();} catch (IOException ex){}
 }%>
  
 
 
	
 

</body>
</html>