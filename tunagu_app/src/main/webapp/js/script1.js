

const qa = ["本木", "氷永", "鳥烏", "活治", "白百", "季李", "兎免", "失矢", "語悟", "扇扉"];

let currentIndex = 0; // 現在の問題のインデックス

// 問題を表示する
function displayQuestion() {
    const q = qa[currentIndex]; 
    const r = Math.floor(Math.random() * 100); // ランダムな位置
    document.querySelector('#q').innerHTML = Array(100).fill(0).map((_, i) => {
        const c = q.charAt(r !== i ? 0 : 1) + ((i % 10 === 9) ? '<br>' : '');
        return `<span id="c${i}" onclick="chk('${c}', '${r}')">${c}</span>`; // rも渡す
    }).join('');
}

// 次の問題を表示する
function nextQuestion() {
    if (currentIndex < qa.length - 1) {
        currentIndex++; // 次の問題に進む
        displayQuestion();
    } else {
        alert("全ての問題が終了しました。");
    }
}

// 初期表示
displayQuestion();

// 正解を確認する
const chk = (c, r) => {
    const correctAnswer = qa[currentIndex].charAt(1); // 正解の漢字を取得
    // 正解の漢字を赤くする
    const correctSpanId = `c${r}`; 
    document.querySelector(`#${correctSpanId}`).style.color = 'red'; // 正解を赤くする
    // ユーザーのクリックを確認
    alert((c === correctAnswer) ? '正解!' : '失敗');
}


