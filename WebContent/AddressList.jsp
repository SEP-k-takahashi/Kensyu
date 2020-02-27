<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*"%>
<!DOCTYPE html>
<%
	//接続変数
	Connection connect;
	Statement stmt ;
	ResultSet rs ;

	//抽出クエリ文字列
	String SelectQuery;

	Class.forName("com.mysql.jdbc.Driver");
	connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/testdb?characterEncoding=UTF-8&serverTimezone=JST","root", "1234567890");
	stmt = connect.createStatement();
	if (request.getParameter("Serchname") == null ){
		SelectQuery = "Select * from tbl_jusho Where delete_flg = 0  LIMIT 0 , 10";
	}
	else{
		request.setCharacterEncoding("UTF-8");
		String tmp = request.getParameter("Serchname") ;
		String SerchWord = new String(tmp.getBytes("ISO8859_1"),"UTF-8");
		SelectQuery = "Select * from tbl_jusho Where address LIKE '%" + SerchWord +"%' and delete_flg = 0  LIMIT 0 , 10";
	}


	rs = stmt.executeQuery(SelectQuery);

%>
<html>
<head>
<meta charset="UTF-8">
<title>検索画面</title>
<link rel="stylesheet" type="text/css" href="/test2/css/list.css">
</head>
<body>
	<form   action="./AddressList.jsp" method="post">
	<table >

		<p>
			<font color="black">住所</font>
			<input type="text" name="Serchname">
			<input type="submit" name="Serchbtn" Value="検索">

		</p>
	</table>
	</form>
	<form>
		<p>
			<a href="./AddressAdd.jsp" class="btn-stitch">新規作成</a>
		</p>

	</form>

	<table border="1">
		<!-- テーブルの各列の長さを指定 -->
	  	<colgroup>
		    <col style="width: 5%;">
		    <col style="width: 20%;">
		    <col style="width: 26%;">
		    <col style="width: 10%;">
		    <col style="width: 10%;">
		    <col style="width: 7%;">
		    <col style="width: 7%;">
	  	</colgroup>
		<tr>
			<th>ID</th>
			<th>名前</th>
			<th>住所</th>
			<th>電話</th>
			<th>削除フラグ</th>
			<th colspan=2></th>

		</tr>

		<!-- 繰り返し処理でレコードを生成 -->
		<%while (rs.next()) { %>
		    <tr>
			<td><%= rs.getInt("id")%></td>
			<td><%= rs.getString("name")%></td>
			<td><%= rs.getString("address")%></td>
			<td><%= rs.getString("number")%></td>
			<td><%= rs.getString("delete_flg")%></td>

			<form>
				<input type="hidden" name="id" Value="<%= rs.getInt("id")%>">
				<td><input  class="btn-stitch" type="submit" formaction="./AddressMod.jsp" Value="変更"></a></td>
				<td><input  class="btn-stitch" type="submit" formaction="./AddressDel.jsp" Value="削除"></a></td>
			</form>

		<%	} %>



		</tr>
	</table>


</body>
</html>
