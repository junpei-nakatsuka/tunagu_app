<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TOP画面</title>
</head>
<body>
	<h2>ゲームを始めるにはログインしてください</h2>
	<form action="Login01" method="post">
		
		<!-- ログインするための名前入力欄。ここのname="inputName"がServletのgetParameter("inputName")に結びつく -->
		<label for="name">名前:</label>
		<input type="text" name="inputName" id="name" required><br>
		
		<!-- ログインするためのPASS入力欄。ここのname="inputPass"がServletのgetParameter("inputPass")に結びつく -->
		<label for="pass">パスワード:</label>
		<input type="password" name="inputPass" id="pass" required>
		
		<c:if test="${not empty passError}">
            <span style="color: red;">${passError}</span>
        </c:if>
		<br>
		<button type="submit">ログイン</button>
		<c:if test="${not empty error}">
			<p style="color: red;">${error}</p>
		</c:if>
	</form>
	<br>
	<a href="insert.jsp">新規登録はこちら</a>
</body>
</html>