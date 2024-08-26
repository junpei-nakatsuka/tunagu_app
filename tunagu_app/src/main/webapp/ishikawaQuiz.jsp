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
        <script>
        // 問題と選択肢の配列
        const questions = [
            {
                question: "石川県で有名なラーメン屋さんは？",
                choices: ["らぁめんいしかわ", "みかん", "８番ラーメン"],
                answer: 2, 
                hint: "石川に通ってる国道って何号線だっけな..."
            },
            {
                question: "「あいそらしー」って言われた、どーゆー意味？",
                choices: ["かわいらしい", "かわいそう", "目をそらす"],
                answer: 0,
                hint: "あ、あの猫とっても..."
            },
            {
                question: "石川県の郷土の花といえば？",
                choices: ["いしみかわ", "クロユリ", "キャンディタフト"],
                answer: 1,
                hint: "花言葉は「呪い」「復讐」...なんか黒いなぁ"
            },
            {
                question: "珠洲、なんて読む？",
                choices: ["たます", "すず", "じゅず"],
                answer: 1,
                hint: "ちりんちりーん"
            },
            {
                question: "だれ？",
                choices: ["はせひろし", "いしだるまくん", "ひゃくまんさん"],
                answer: 2,
                hint: "まじ、だれ？",
                image: "image/100.jpg"
            }
        ];

        let currentQuestionIndex = 0;
        let score = 0;

        function displayQuestion() {
            const questionElement = document.getElementById("question");
            const choicesElement = document.getElementById("choices");
            const hintButton = document.getElementById("hintButton");
            const imageElement = document.getElementById("image");
            

            // 現在の問題を表示
            const question = questions[currentQuestionIndex];
            questionElement.textContent = question.question;
            choicesElement.innerHTML = ""; // 選択肢のリセット


         // 画像の表示・非表示
            if (question.image) {
                imageElement.src = question.image;
                imageElement.style.display = "block";
            } else {
                imageElement.style.display = "none";
            }
                    
            // 選択肢の表示
            question.choices.forEach((choice, index) => {
                const button = document.createElement("button");
                button.textContent = choice;
                button.className = "choice-button"; // クラスを追加
                button.onclick = function () { checkAnswer(index); };
                choicesElement.appendChild(button);
            });

            // ヒントボタンの表示
            hintButton.style.display = "inline";
            hintButton.onclick = function () { alert(question.hint); };
        }

        //選択を受け取る
        function checkAnswer(selectedIndex) {
            const question = questions[currentQuestionIndex];
          //選択が答えと一致しているか判別する場所
            if (selectedIndex === question.answer) {
                alert("正解です！");
                score++;
            } else {
                alert("不正解です。");
            }
            //問題を更新する部分
            currentQuestionIndex++;
            if (currentQuestionIndex < questions.length) {
                displayQuestion();
            } else {
                //全問題が終了したら要素を非表示にする
                document.getElementById("question").style.display = "none";
                document.getElementById("choices").style.display = "none";
            	document.getElementById("hintButton").style.display = "none";
            	
                // スコアを表示する
                const scoreElement = document.getElementById("score");
                scoreElement.textContent = "あなたのスコア: " + score + " / " + questions.length;
                scoreElement.style.display = "block";

                //スコアによって最終的に表示するコメントと画像を決める
                if(score == questions.length){
                    
                	document.getElementById("image").src= "image/100_2.jpg";
                	
                    document.getElementById("question").textContent = "すごい！おめでとう！"; 
                    document.getElementById("question").style.display = "block";
                    }else if (score < questions.length / 2){
                        
                    	document.getElementById("image").src= "image/100_3.jpg";

                        document.getElementById("question").textContent = "・・・・・・"; 
                        document.getElementById("question").style.display = "block";
                        //画像に新しいクラスを定義
                        document.getElementById("image").classList.add("shake");

                        }else {
                            
                            document.getElementById("question").textContent = "よく知ってますね！"; 
                            document.getElementById("question").style.display = "block";
                            
                            }
            }
        }

        window.onload = displayQuestion; // ページロード時に最初の質問を表示
    </script>
    <link rel="stylesheet" href="css/ishikawaCss.css">
<title>石川県って...</title>
</head>
<body>
        <h1>石川県クイズ</h1>
        <p id="score" style="display: none;"></p>  <!-- スコアを入れる場所 -->
    <div id="questionContainer"> <!-- クイズの全てを格納してる部分  -->
        <p id="question"></p> <!-- 問題文を入れる場所 -->
        <img id="image" src="" alt="問題画像" display: none;"> <!-- 画像を入れる場所 -->
        <div id="choices"></div> <!-- 選択肢を入れる場所 -->
        <button id="hintButton" style="display: none;">ヒント</button> <!-- ヒントを入れる場所 -->
    </div>
    
    <br>
    <!-- 再スタートボタン -->
    <form action="ishikawaQuiz.jsp" method="get">
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