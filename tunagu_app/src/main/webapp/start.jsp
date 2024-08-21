<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("name") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>選択画面</title>
<link rel="stylesheet" href="css/styles.css">
</head>
<body>
	<h1>${name}さん、こんにちは！</h1>
	<h3>遊びたいゲームを選んでね↓</h3>
	
	<form action="quiz.jsp">
		<button type="submit">「クイズ」10秒で答えてスコアを狙え！</button>
	</form>	
	
	<form action="start.jsp">
		<button type="submit">他のゲーム</button>
	</form>
	
	<form action="start.jsp">
		<button type="submit">他のゲーム</button>
	</form>
	
	<br><br>
	<!-- ログアウトボタン -->
    <form action="Logout" method="get">
        <button type="submit">ログアウト</button>
    </form>
</body>
</html>