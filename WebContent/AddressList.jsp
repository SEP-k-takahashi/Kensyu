<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*"
    import="java.util.Objects"%>
<!DOCTYPE html>
<%
	//接続変数
	Connection connect;
	Statement stmt ;
	ResultSet rs ;

	//抽出クエリ文字列
	String SelectQuery;
	String CntQuery;

	//ページ変数
	String nowPage;
	int limitSta;
	int listCnt;
	int maxPage;

	//Pageリクエストがnullの場合は現在ページ数に初期値1を設定
	if(request.getParameter("page") == null){
		nowPage = "1";
	}else{
		nowPage =request.getParameter("page");
	};
	limitSta = (Integer.parseInt(nowPage) - 1) * 10;

	Class.forName("com.mysql.jdbc.Driver");
	connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/testdb?characterEncoding=UTF-8&serverTimezone=JST","root", "1234567890");
	stmt = connect.createStatement();
	//先に全件数を取得
	CntQuery = "select count(*) as cnt from tbl_jusho Where delete_flg = 0 ";
	rs = stmt.executeQuery(CntQuery);
	rs.next();
	listCnt = rs.getInt("cnt");
	//全件数より最大ページ数を取得)(10で割り切れない場合は端数用に1ページ追加)
	maxPage = listCnt /10;
	if(listCnt % 10 > 0){
		maxPage = maxPage +1;
	}


	if (request.getParameter("Serchname") == null ){
		SelectQuery = "Select * from tbl_jusho Where delete_flg = 0  LIMIT " + limitSta +" , 10";
	}
	else{
		request.setCharacterEncoding("UTF-8");
		String tmp = request.getParameter("Serchname") ;
		String SerchWord = new String(tmp.getBytes("ISO8859_1"),"UTF-8");
		SelectQuery = "Select * from tbl_jusho Where address LIKE '%" + SerchWord +"%' and delete_flg = 0  LIMIT " + limitSta +" , 10";
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


	<%//if(Objects.equals(nowPage ,"1")){  %>
	<div class="Paging">
	<ul>
	<form method="post" name="formbb" action="#" style="display: inline">
		<input type="hidden" name="page" value="1">
		<li><a href="javascript:formbb.submit()">&lt;&lt;</a></li>
	</form>
	<form method="post" name="formb" action="#" style="display: inline">
		<input type="hidden" name="page" value="1">
		<li><a href="javascript:formb.submit()">&lt;</a></li>
	</form>


	<%
	//最大5回ループを行う
	for (int i = 0; i < 5; i++) {
		int Page = i + Integer.parseInt(nowPage);

		//現在のページが1,2の場合
		if(Integer.parseInt(nowPage) < 3){
			//現在のページと表示ページが一致しない場合は活性状態で表示

			if(maxPage < (i + 1)){
				break;
			}
			if(!(Objects.equals(nowPage ,Integer.toString(i + 1)))){

				%>
			<form method="post" name="form<%=i + 1%>"  action="#" style="display: inline">
				<input type="hidden" name="page" value=<%=i + 1%>>
				<li><a href="javascript:form<%=i + 1%>.submit()"><%=i + 1%></a></li>
			</form>

	<%
			//現在のページと表示ページが一致する場合は非活性で表示
			}else{
	%>
				<%=i + 1%>
	<%
			}
		//現在のページが3以上の場合
		}else{
			//現在のページと表示ページが一致しない場合は活性状態で表示
			if(!(Objects.equals(nowPage ,Integer.toString(Page - 2)))){
				if(maxPage < (Page - 2)){
					break;
				}
				%>
			<form method="post" name="form<%=Page - 2%>"  action="#" style="display: inline">
				<input type="hidden" name="page" value=<%=Page - 2%>>
				<li><a href="javascript:form<%=Page - 2%>.submit()"><%=Page - 2%></a></li>
			</form>
	<%
			//現在のページと表示ページが一致する場合は非活性で表示
			}else{
	%>
				<%=Page - 2%>
	<%
			}
		}
	}
	%>


	<form method="post" name="formf" action="#" style="display: inline">
		<input type="hidden" name="page" value="5">
		<li><a href="javascript:formf.submit()">&gt;</a></li>
	</form>
	<form method="post" name="formff" action="#" style="display: inline">
		<input type="hidden" name="page" value="5">
		<li><a href="javascript:formff.submit()">&gt;&gt;</a></li>
	</form>

	</ul>
	</div>






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
