<%@ page import="java.net.*, java.io.*, java.util.*, java.text.*, java.text.DecimalFormat, java.text.SimpleDateFormat" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
</head>
<body>

<%
	String getCode = request.getParameter("code");		//005930
	String getBegin = request.getParameter("begin");	//2017-01-01
	String getFinish = request.getParameter("finish");	//2017-06-30
	DecimalFormat dF = new DecimalFormat("###,###");

%>
	<table cellspacing=1 width=800 border=0 align=center>
	<tr>
	<td>종목코드<input type=text name=code value=<%=getCode%> readonly></td>
	<td>시작일자<input type=text name=begin value=<%=getBegin%> readonly></td>
	<td>시작일자<input type=text name=finish value=<%=getFinish%> readonly></td>
	<td><input type=button name=search value="뒤로가기" onClick="location.href='/L11_stock/search.jsp'"></td>
	</tr>
	</table>
	<br>


<%	

	try{
		URL url = new URL("http://www.google.com/finance/historical?q=KOSPI:"+ getCode +"&startdate=＂"+ getBegin +"＂&enddate=＂"+ getFinish +"＂&num=200&output=csv");
		URLConnection urlConn = url.openConnection();
		InputStreamReader inputStreamReader = new InputStreamReader(urlConn.getInputStream());
		BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
		String line;
		//한번 읽는것인데 제목을 잘라내는 용도
		line = bufferedReader.readLine();
		//읽은 첫줄을 다른곳에 저장하는 용도
		String [] title_line = line.split(",");
%>
	<table cellspacing=1 width=800 border=1 align=center>
	<tr>
	<td align=center>일자</td>
	<td align=center>시가</td>
	<td align=center>저가</td>
	<td align=center>고가</td>
	<td align=center>종가</td>
	<td align=center>거래량</td>
	</tr>
<%		
		//순수 내용 읽기 시작
		while((line = bufferedReader.readLine()) != null) {		
			String[] field = line.split(",");
			String date = field[0];
			//SimpleDateFormat의 형식을 선언한다.
			SimpleDateFormat original = new SimpleDateFormat("dd-MMM-yy");
			SimpleDateFormat new_format = new SimpleDateFormat("yyyy-MM-dd");
			//날짜 형식 변환시 파싱 오류를 try.. catch..로 체크한다.
			String new_date ="";
			try{
				//문자열 타입을 날짜 타입으로 변환한다.
				Date original_date = original.parse(date);
				
				//날짜 형식을 원하는 타입으로 변경한다.
				 new_date = new_format.format(original_date);
				} catch (ParseException e){
					e.printStackTrace();
				}
			//데이터의 (".")을 찾고 없애는 과정
			int point = 0; //데이터의 (.)을 찾는 변수
			point = field[1].indexOf(".");
			field[1] = field[1].substring(0, point);	
			point = field[2].indexOf(".");
			field[2] = field[2].substring(0, point);
			point = field[3].indexOf(".");
			field[3] = field[3].substring(0, point);
			point = field[4].indexOf(".");
			field[4] = field[4].substring(0, point);		
%>
	<tr>
	<td align=center><%=new_date%></td>
	<td align=right><%=dF.format(Long.parseLong(field[1]))%></td>
	<td align=right><%=dF.format(Long.parseLong(field[2]))%></td>
	<td align=right><%=dF.format(Long.parseLong(field[3]))%></td>
	<td align=right><%=dF.format(Long.parseLong(field[4]))%></td>
	<td align=right><%=dF.format(Long.parseLong(field[5]))%></td>
	</tr>

<%
			//out.println(line+"<br>");
		}out.println("</table>");
		bufferedReader.close();
		inputStreamReader.close();
	} catch (Exception e){
		e.printStackTrace();
	}

%>
	
</body>
</html>
