<%@ page contentType="text/html; charset=UTF-8" %> <!-- 한글 처리 UTF-8을 씀 -->
<%@ page import = "java.io.*" %>
<%@page import="java.io.FileReader"%>

<html>
<head>
<title>텍스트 파일 읽어 오기</title>
</head>
<body>
<%
FileReader fr = null;
char [] buff = new char[512];
int len = -1;
 
 try {
  fr = new FileReader("/var/lib/tomcat7/webapps/ROOT/L03_170609/freewifi.txt"); //절대경로
  while((len=fr.read(buff)) != -1){
	  out.print(fr+"</br>");
   out.print(new String(buff,0,len));
   
  }
 }catch(IOException ex){
  out.println("예외발생:" + ex.getMessage());
 }finally{
  if (fr != null) try { fr.close();} catch (IOException ex){}
 }
 %>



</body>
</html>