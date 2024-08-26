document.addEventListener('DOMContentLoaded', () => {
    // 各要素の取得
    const submitButton = document.getElementById('submit');  // jsp内のid="submit"から取得
    const messageElement = document.getElementById('message');  // jsp内のid="message"から取得
    const answerInput = document.getElementById('answer');  // jsp内のid="answer"から取得
    const countdownElement = document.getElementById('countdown');  // jsp内のid="countdown"から取得
    const questionElement = document.getElementById('question');  // jsp内のid="question"から取得
    const scoreElement = document.getElementById('score');  // jsp内のid="score"から取得
    const restartButton = document.getElementById('restart');  // jsp内のid="restart"から取得

    // クイズの問題と答えの定義
    const questions = [
        { question: "日本の首都はどこですか？", answer: "東京" },
        { question: "2+2は何ですか？", answer: ["4", "４"] },
        { question: "[入力]生麦生米生卵", answer: "生麦生米生卵" }
        // さらに問題を追加可能
    ];

    // ローカルストレージからのデータの取得と初期値の設定
    let currentQuestionIndex = parseInt(localStorage.getItem('currentQuestionIndex')) || 0; // 現在の質問のインデックス
    let timeLeft = parseInt(localStorage.getItem('timeLeft')) || 10; // 残り時間
    let score = parseInt(localStorage.getItem('score')) || 0; // スコア
    let countdownInterval; // タイマーのID
    let correctAnswersCount = parseInt(localStorage.getItem('correctAnswersCount')) || 0; // 正解数
    let remainingQuestions = [...questions]; // 残りの問題のリスト

    // ゲーム開始までのカウントダウンを設定
    const startCountdown = () => {
        let startTime = 10; // 10秒でカウントダウン
        const countdown = setInterval(() => {
            countdownElement.textContent = `ゲーム開始まで: ${startTime} 秒`;
            if (startTime <= 0) {
                clearInterval(countdown);
                countdownElement.textContent = ''; // カウントダウン終了後に表示をクリア
                submitButton.disabled = false; // 送信ボタンを有効化
                displayQuestion(); // 最初の問題を表示
            } else {
                startTime--;
            }
        }, 1000);
    };

    // カウントダウンタイマーの更新関数
    const updateCountdown = () => {
        countdownElement.textContent = `残り時間: ${timeLeft} 秒`;
        if (timeLeft <= 0) {
            clearInterval(countdownInterval); // タイマーを停止
            submitButton.click(); // 自動的に送信ボタンをクリック
        } else {
            timeLeft--; // 時間を減少
        }
    };

    // ランダムな問題を表示する関数
    const displayQuestion = () => {
        if (remainingQuestions.length > 0) {
            // 残りの問題の中からランダムに選ぶ
            const randomIndex = Math.floor(Math.random() * remainingQuestions.length);
            const currentQuestion = remainingQuestions.splice(randomIndex, 1)[0];

            questionElement.textContent = currentQuestion.question;
            answerInput.value = ''; // 入力フィールドをクリア
            timeLeft = 10; // タイマーの初期値設定
            countdownElement.textContent = `残り時間: ${timeLeft} 秒`;

            // タイマーを設定
            if (countdownInterval) {
                clearInterval(countdownInterval); // 既存のタイマーをクリア
            }
            countdownInterval = setInterval(updateCountdown, 1000); // 1秒ごとにupdateCountdownを実行
            updateCountdown(); // 初期表示
        } else {
            // 全ての問題が終了した場合の処理
            clearInterval(countdownInterval); // タイマーを停止
            countdownElement.style.display = 'none'; // タイマーを非表示にする

            if (correctAnswersCount === questions.length) {
                questionElement.innerHTML = `★★おめでとうございます！★★<br>★★全問正解です！★★`;
            } else {
                questionElement.innerHTML = `お疲れ様です！<br>全ての問題が終了しました！`;
            }
            submitButton.disabled = true; // 送信ボタンを無効化
        }

        // スコアの表示
        scoreElement.textContent = `スコア: ${score}点`;
    };

    // クイズのリセット関数
	const resetQuiz = () => {
    // ローカルストレージからクイズに関連する全てのデータを削除
    	localStorage.removeItem('currentQuestionIndex'); // 現在の質問のインデックス
    	localStorage.removeItem('timeLeft'); // 残り時間
    	localStorage.removeItem('score'); // スコア
    	localStorage.removeItem('correctAnswersCount'); // 正解数

    // クイズの状態を初期化
    	currentQuestionIndex = 0; // 現在の質問のインデックスをリセット（最初の質問に戻す）
    	timeLeft = 10; // 残り時間を初期値の10秒にリセット
    	score = 0; // スコアを初期値の0にリセット
    	correctAnswersCount = 0; // 正解数を初期値の0にリセット
    
    // 問題リストを初期状態に戻す
    	remainingQuestions = [...questions]; // 全ての問題を含むリストにリセット
	};


    // ゲーム開始カウントダウンの実行
    startCountdown();

    // 送信ボタンのクリックイベントリスナー
    submitButton.addEventListener('click', () => {
        const userAnswer = answerInput.value.trim(); // ユーザーの回答を取得
        const correctAnswers = questions.find(q => q.question === questionElement.textContent).answer;

        // 正解チェック
        const isCorrect = Array.isArray(correctAnswers) ? correctAnswers.some(answer => answer === userAnswer) : userAnswer === correctAnswers;

        if (userAnswer === '') {
            messageElement.textContent = '不正解です！';
        } else if (isCorrect) {
            messageElement.textContent = '正解です！';
            score += 5; // 正解時にスコアを加算
            correctAnswersCount++; // 正解数をカウント
        } else {
            messageElement.textContent = '不正解です！';
        }

        // ローカルストレージにデータを保存
        localStorage.setItem('currentQuestionIndex', currentQuestionIndex + 1);
        localStorage.setItem('timeLeft', timeLeft);
        localStorage.setItem('score', score);
        localStorage.setItem('correctAnswersCount', correctAnswersCount);

        currentQuestionIndex++; // 次の問題に進む
        displayQuestion(); // 問題の表示を更新
    });
    
    // Enterキーで送信ボタンをクリックする処理を追加
    answerInput.addEventListener('keydown', (e) => {
        if (e.key === 'Enter') { // Enterキーが押された場合
            e.preventDefault(); // フォームのデフォルトの動作を防ぐ
            submitButton.click(); // 送信ボタンをクリック
        }
    });

    // ウィンドウが閉じられる前にデータを保存
    window.addEventListener('beforeunload', () => {
        localStorage.setItem('currentQuestionIndex', currentQuestionIndex);
        localStorage.setItem('timeLeft', timeLeft);
        localStorage.setItem('score', score);
        localStorage.setItem('correctAnswersCount', correctAnswersCount);
    });

    // 再スタートボタンのクリックイベントリスナー
    if (restartButton) {
        restartButton.addEventListener('click', () => {
            resetQuiz(); // クイズのリセット
            // 少し遅らせてリロードを行う
            setTimeout(() => {
                window.location.reload(); // ページリロード
            }, 100); // 100ミリ秒の遅延
        });
    }
});
