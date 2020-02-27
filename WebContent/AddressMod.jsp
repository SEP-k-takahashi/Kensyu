<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*"%>
<!DOCTYPE html>
<%
	//接続変数
	Connection connect;
	Statement stmt ;
	ResultSet rs ;

	//リクエスト変数
	String id= "";
	String name="";
	String tel="";
	String address="";

	//抽出クエリ文字列
	String SelectQuery;



	Class.forName("com.mysql.jdbc.Driver");
	connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/testdb?characterEncoding=UTF-8&serverTimezone=JST","root", "1234567890");
	//stmt = connect.createStatement();

	request.setCharacterEncoding("UTF-8");

	SelectQuery = "Select * from tbl_jusho Where id = ?";
	PreparedStatement pstmt = connect.prepareStatement(SelectQuery);

	pstmt.setString(1,request.getParameter("id"));

	rs = pstmt.executeQuery();
	while(rs.next()){
		name= rs.getString("name");
		tel= rs.getString("number");
		address= rs.getString("address");
		id =request.getParameter("id");
	}


%>
<html>
<head>
<meta charset="UTF-8">
<title>編集画面</title>
</head>
	<body>
		<p>ユーザー情報編集</p>

		<form name="addfrm" action="./ModBL" method="post">

			<input type="hidden" name="id" Value="<%= id%>">
		    <table>
		        <tr>
		            <th class="cell_title">名前</th>
		            <th class="cell_required">※</th>

		            <td><input type="text" name="name" Value="<%=name%>"></td>
		<!--
				<td><input type="text" ></td>
		-->
		        </tr>
		        <tr>
		            <th class="cell_title">住所</th>
		            <th class="cell_required"></th>

		            <td><input type="text" name="address" Value="<%=address%>"></td>
		<!--
		 		<td><input type="text" ></td>
		-->
		        </tr>
		        <tr>
		            <th class="cell_title">電話番号</th>
		            <th class="cell_required">※</th>

		            <td><input type="text" name="tel" Value="<%= tel%>"></td>

		<!--
		 		<td><input type="text" ></td>
		-->
		        </tr>
		    </table>
		    <div class="btn_area_center">
		    	<input type="submit" value="編集" class="btn">
		    	<input type="button" onclick="history.back()" value="戻る" class="btn">
		    </div>

	    </form>

	</body>
</html>