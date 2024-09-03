<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>新規登録</title>
</head>
<body>
 <p>ユーザーを登録します。<br>名前、パスワードを入力してください。</p>
  <form action="InsertServlet" method="post">
    名前 <input type="text" name="name"><br>
    パスワード <input type="text" name="pass"><br>
    <button type="submit">登録</button>
  </form>
</body>
</html>