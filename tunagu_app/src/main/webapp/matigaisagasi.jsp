<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>間違い探しゲーム</title>
    <link rel="stylesheet" type="text/css" href="css/matigaisagasi.css">
</head>
<body>
    <p id="q" class="question"></p>
    <div>
    <!-- 次の問題へ進む -->
        <button id="nextButton" onclick="nextQuestion()">次の問題へ</button>
    <!-- ゲーム一覧へ戻るボタン -->
    <form action="start.jsp" method="get">
        <button type="submit">ゲーム一覧へ戻る</button>
    </form>
    </div>
    <script src="js/script1.js"></script>
</body>
</html>
