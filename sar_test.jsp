<?xml version="1.0" encoding="UTF-8"?>
<%@ page contentType="text/xml;"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*, java.net.*" %> 
<data>
<% 
{
   
	String command = "sh /home/koposw19/sms.sh" ; //실행할 명령어	
	int linecount = 1;
			
    String line=""; 
	
    Runtime rt = Runtime.getRuntime(); 
	Process ps = null;
	
    try	{
      ps = rt.exec(command); 
	  //ps=command를 실행한다.
		
      BufferedReader br = new BufferedReader( 
								new InputStreamReader( 
									new SequenceInputStream(ps.getInputStream(), ps.getErrorStream()) ) ); 
	    
	  String retval[];
		
	  while((line = br.readLine()) != null) {
		if(linecount==1){	//5번째 줄이 Average가 보이는 줄
			retval=line.split(" ");
			int iCnt=0;
			for(int i=0;i<retval.length;i++){
				retval[i]=retval[i].replaceAll(" ","");
				if(retval[i].isEmpty()) continue;
				iCnt++;	
				if(iCnt==1)	out.println("<one>"+retval[i]+"</one>");
				else if(iCnt==2)	out.println("<two>"+retval[i]+"</two>");
				else if(iCnt==3)	out.println("<three>"+retval[i]+"</three>");
				else if(iCnt==4)	out.println("<four>"+retval[i]+"</four>");
				else if(iCnt==5)	out.println("<five>"+retval[i]+"</five>");
				else if(iCnt==6)	out.println("<six>"+retval[i]+"</six>");
				else if(iCnt==7)	out.println("<seven>"+retval[i]+"</seven>");
				else if(iCnt==8)	out.println("<eight>"+retval[i]+"</eight>");
				else if(iCnt==9)	out.println("<nine>"+retval[i]+"</nine>");
			}
		}
		linecount++;
      } 
      br.close(); 	  
   }catch(Exception e) { 
      e.printStackTrace(); 	  
   } 
}
%>
</data>
