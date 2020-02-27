<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>登録画面</title>
</head>
	<body>
		<p>ユーザー新規登録</p>

		<form name="addfrm" action="./AddBL" method="post">


		    <table>
		        <tr>
		            <th class="cell_title">名前</th>
		            <th class="cell_required">※</th>

		            <td><input type="text" name="name"></td>
		<!--
				<td><input type="text" ></td>
		-->
		        </tr>
		        <tr>
		            <th class="cell_title">住所</th>
		            <th class="cell_required"></th>

		            <td><input type="text" name="address"></td>
		<!--
		 		<td><input type="text" ></td>
		-->
		        </tr>
		        <tr>
		            <th class="cell_title">電話番号</th>
		            <th class="cell_required">※</th>

		            <td><input type="text" name="tel"></td>

		<!--
		 		<td><input type="text" ></td>
		-->
		        </tr>
		    </table>
		    <div class="btn_area_center">
		    	<input type="submit" value="登録" class="btn">
		    	<input type="button" onclick="history.back()" value="戻る" class="btn">
		    </div>

	    </form>

	</body>
</html>