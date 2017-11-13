<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>

<html>
<head>
<script>
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
<h2>Insert Data Success</h2>

<%
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection k20_conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/webServer", "root", "dudeh123");
	
	String name = request.getParameter("username");		
	String twiceName = new String(name.getBytes("8859_1"),"utf-8");
	
	int kor = Integer.parseInt(request.getParameter("twicekor"));	
	int eng = Integer.parseInt(request.getParameter("twiceeng"));
	int mat = Integer.parseInt(request.getParameter("twicemat"));
	
	
	
	
	/*추가된 학생 정보 입력*/
	Statement k20_stmt = k20_conn.createStatement();	
	ResultSet rset = k20_stmt.executeQuery("select studentid from examtable2");
	int twiceID = 209901;
	int findID = 209901;
	while(rset.next()){
		if(findID == rset.getInt(1)|| twiceID == rset.getInt(1)){
			twiceID++;
			findID++;
		}else if(findID != rset.getInt(1)){
			twiceID = findID;
		}
	}
	
	
	k20_stmt.execute("insert into examtable2 (name, studentid, kor, eng, mat) "
					+ "values ('"+twiceName+"',"+twiceID+","+kor+","+eng+","+mat+")"); 
	
	k20_stmt.close();
	k20_conn.close();
%>

<table border=1 width = 400>
  <form method="post" action="170612_05select.jsp">
  <input type="submit" value="전체보기">
	<tr>
	<td width = 20% align = center>이름 </td>
	<td width = 80% align = center><%=twiceName%></td>
	</tr>

	<tr>
	<td width = 20% align = center>학번</td>
	<td width = 80% align = center><%=twiceID%></td>
	</tr>

	<tr>
	<<td width = 20% align = center>국어</td>
	<td width = 80% align = center><%=kor%></td>
	</tr>

	<tr>
	<<td width = 20% align = center>영어</td>
	<td width = 80% align = center><%=eng%></td>
	</tr>

	<tr>
	<<td width = 20% align = center>수학</td>
	<td width = 80% align = center><%=mat%></td>
	</tr>
</form>
</table>




</body>
</html>