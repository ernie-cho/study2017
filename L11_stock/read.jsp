<%@ page import="java.net.*, java.io.*, java.util.*, java.text.*" %>
<%@ page contentType="text/html; charset=UTF=8" language="java" %>
<html>
<head>
</head>
<body>
<%
	try{
		URL url = new URL("http://www.google.com/finance/historical?q=KOSPI:005930&startdate=＂2017-01-01＂&enddate=＂2017-06-30＂&num=200&output=csv");
		URLConnection urlConn = url.openConnection();
		InputStreamReader inputStreamReader = new InputStreamReader(urlConn.getInputStream());
		BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
		String line;
		while((line = bufferedReader.readLine()) != null) {
			out.println(line+"<br>");
		}
		bufferedReader.close();
		inputStreamReader.close();
	} catch (Exception e){
		e.printStackTrace();
	}

%>
</body>
</html>
