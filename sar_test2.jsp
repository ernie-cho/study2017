<?xml version="1.0" encoding="UTF-8"?>
<%@ page contentType="text/xml; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*, java.net.*" %> 


<data>

	<% 
	
	{
	  
		String command = "sh ./file/sms.sh" ; //실행할 명령어	
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
			
		  //String retval[];
			
			int iCnt=0;
		  while((line = br.readLine()) != null) {
			
					
					iCnt++;	
					if(iCnt==1)	out.println("<CPU>"+line+"</CPU>");
					else if(iCnt==2)	out.println("<MEM>"+line+"</MEM>");
					else if(iCnt==3)	out.println("<DISK>"+line+"</DISK>");
					else if(iCnt==4)	out.println("<MEM_USED>"+line+"</MEM_USED>");
					else if(iCnt==5)	out.println("<MEM_TOTAL>"+line+"</MEM_TOTAL>");
					else if(iCnt==6)	out.println("<DISK_USED>"+line+"</DISK_USED>");
					else if(iCnt==7)	out.println("<DISK_TOTAL>"+line+"</DISK_TOTAL>");
					else if(iCnt==8)	out.println("<eight>"+line+"</eight>");
					else if(iCnt==9)	out.println("<nine>"+line+"</nine>");
				//}
			//}
			linecount++;
			
		  } 
		  br.close(); 	  
	   }catch(Exception e) { 
		  e.printStackTrace(); 	  
	   } 
	}
	
	%>
</data>
