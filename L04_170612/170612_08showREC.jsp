<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*" %>

<html>
<head>
	<script language="JavaScript">
	
	function submitForm(mode){
		if(mode=="update"){
			myform.action = "170613_09updateDB.jsp";
			myform.submit();
		}else if(mode == "delete"){
			myform.action = "170613_10deleteDB.jsp";
			myform.submit();
		}
	}
	
	function OnlyNumber(obj,chkint,chkint2){
  if(isNaN(obj.value) || obj.value.match(/\s/g)) {
    alert("0~100까지 숫자를 입력해주세요");
    obj.value="";
    obj.focus();
    return false;
  }
  if(obj.value > Number(chkint)) {
    alert(chkint +" 이하의 숫자만 가능합니다.");
    obj.value="";
    obj.focus();
    return false;
  }
  if(obj.value < Number(chkint2)) {
    alert(chkint2 +" 이상의 숫자만 가능합니다.");
    obj.value="";
    obj.focus();
    return false;
  }
  
}

function CheckHangul(name) {
    strarr = new Array(name.value.length);
    schar = new Array('/','.','>','<',',','?','}','{',' ','\\','|','(',')','+','=','@','!','#',
	'$','%','^','&','*','_','§','※','☆','★','○','●','◎','◇','◆','□','■','△','▲','▽','▼','→',
	'←','↑','↔','〓','◁','◀','▷','▶','♤','♠','♡','♥','♧','♣','⊙','◈','▣','◐','◑','◑',
	'▒','▤','▥','▨','▧','▦','▩','♨','☏','☎','☜','☞','¶','†','‡','↕','↗','↙','↖','↘',
	'♭','♩','♪','♬','㉿','㈜','№','㏇','™','㏂','㏘','℡','®','ª','º','㉾');
    for (i=0; i<name.value.length; i++)    {
        for (j=0; j<schar.length; j++)        {
            if (schar[j] ==name.value.charAt(i))
            {
                alert("이름은 한글입력만 가능합니다.");
				name.value="";
                //document.registform.mem_name.focus();
                return false;
            }
            else
                continue;
        }
        strarr[i] = name.value.charAt(i)
        if ((strarr[i] >=0) && (strarr[i] <=9))
        {
            alert("이름에 숫자가 있습니다. 이름은 한글입력만 가능합니다.");
			name.value="";
            //document.registform.mem_name.focus();
            return false;
        }

        else if ((escape(strarr[i]) > '%60') && (escape(strarr[i]) <'%80') )
        {
            alert("이름에 특수문자가 있습니다. 이름은 한글입력만 가능합니다.");
			name.value="";
            //document.registform.mem_name.focus();
            return false;
        }
        else
        {
            continue;
        }
    }
    return true;
}
	
	</script>
</head>
<body>

<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection k20_conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	Statement k20_stmt = k20_conn.createStatement();	
	
	String twiceName="", twiceID="", kor="", eng="",mat="";

	String ctmp = request.getParameter("searchID");
	if(ctmp.length()==0) ctmp="0";
	ResultSet rset = k20_stmt.executeQuery("select * from examtable2 where studentid = "+ctmp);
	
	
	twiceName="해당학번없음";
	
	while(rset.next()) {
		twiceName=rset.getString(1);
		twiceID=Integer.toString(rset.getInt(2));
		kor=Integer.toString(rset.getInt(3));
		eng=Integer.toString(rset.getInt(4));
		mat=Integer.toString(rset.getInt(5));
	}
	
	k20_stmt.close();
	k20_conn.close();

	
%>

<h1>성적 조회후 정정 / 삭제</h1>
	<form method='post' action='170612_08showREC.jsp'>
		<table cellspacing=1 width=400 border=0>
		<tr>
			<td width=100><p align=center>조회할 학번</p></td>
			<td width=200><p align=center><input type="text" name="searchID"></p></td>
			<td width=100><input type="submit" value="조회" ></td>
		</tr>
		</table>
	</form>
	<form method='post' name='myform'>
		<table cellspacing=1 width=400 border=1>
		<tr>
			<td width=100><p align=center>이름</p></td>
			<td width=300><p align=center><input type='text' name="twiceName" value='<%=twiceName%>' onblur=CheckHangul(this) required></p></td>
		</tr>
		<tr>
			<td width=100><p align=center>학번</p></td>
			<td width=300><p align=center><input type='text' name="twiceID" value='<%=twiceID%>' readonly></p></td>
		</tr>
		<tr>
			<td width=100><p align=center>국어</p></td>
			<td width=300><p align=center><input type='text' name="twicekor" value='<%=kor%>' onblur=OnlyNumber(this,100,0) required></p></td>
		</tr>
		<tr>
			<td width=100><p align=center>영어</p></td>
			<td width=300><p align=center><input type='text' name="twiceeng" value='<%=eng%>' onblur=OnlyNumber(this,100,0) required></p></td>
		</tr>
		<tr>
			<td width=100><p align=center>수학</p></td>
			<td width=300><p align=center><input type='text' name="twicemat" value='<%=mat%>' onblur=OnlyNumber(this,100,0) required></p></td>
		</tr>
		</table>
<%
		if(twiceID.length() !=0){
			out.println("<table cellspacing=1 width=400 border=0>");
			out.println("<tr>");
			out.println("<td width=200></td>");
			out.println("<td width=100><p align=center><input type=button value=\"수정\" OnClick=\"submitForm('update')\"</p></td>");
			out.println("<td width=100><p align=center><input type=button value=\"삭제\" OnClick=\"submitForm('delete')\"</p></td>");
			out.println("</tr>");
			out.println("</table>");
		}
%>
	</form>
</body>
</html>
