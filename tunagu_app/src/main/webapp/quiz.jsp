<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("name") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>クイズゲーム</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <h1>クイズゲーム</h1>
    <p id="description">
    	～ゲームの説明～<br>
    	10秒以内に問題に答えてください。<br>
    	10秒経過すると自動的に送信ボタンが押されます。<br>
    	[入力]と書かれた問題はその隣の文字をそっくりそのまま入力して送信してください。<br>
    	正解するとスコアが増えます。
    </p> 
    <p id="countdown">ゲーム開始まで: 10秒</p> <!-- 初期値として10秒を表示 -->
    <p id="question" class="no-copy">問題がここに表示されます</p>
    <input type="text" id="answer" placeholder="答えを入力してください">
    <button id="submit" disabled>送信</button> <!-- 初期状態で無効化 -->
    <p id="message"></p>
    <p id="score">スコア: 0点</p>
    <script src="js/script.js"></script> <!-- JavaScriptファイルの読み込み -->
    <br>
    <!-- 再スタートボタン -->
    <form action="quiz.jsp" method="get">
        <button type="submit" id="restart">再スタート</button>
    </form>
    
    <!-- ゲーム一覧へ戻るボタン -->
    <form action="start.jsp" method="get">
        <button type="submit">ゲーム一覧へ戻る</button>
    </form>
    
    <!-- ログアウトボタン -->
    <form action="Logout" method="get">
        <button type="submit">ログアウト</button>
    </form>
</body>
</html>