package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    	//エンコード設定。UTF-8に設定しないと日本語は文字化けして表示されちゃう
    	request.setCharacterEncoding("UTF-8");
        
        //index.jspのname="inputName"とgetParameter("inputName")が結びついて、入力値を受け取っている
        String name = request.getParameter("inputName");
        
        //index.jspのname="inputPass"とgetParameter("inputPass")が結びついて、入力値を受け取っている
        String pass = request.getParameter("inputPass");

        try {
            int intPass = Integer.parseInt(pass);
            
            						//かつ				//または					//かつ
            if (("仲塚".equals(name) && intPass == 1234) || ("ユーザー".equals(name) && intPass == 5678)) {
            	
            	HttpSession session = request.getSession();
            	
            	//セッションに名前を保存。これによりログアウトするまで各ページでログイン時の名前を使いまわせる。
            	session.setAttribute("name", name);
                
            	//ログイン成功なので、start.jspへ遷移させる
            	RequestDispatcher dispatcher = request.getRequestDispatcher("start.jsp");
                dispatcher.forward(request, response);
            } else {
                request.setAttribute("error", "名前またはパスワードが間違っています。");
                RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
                dispatcher.forward(request, response);
            }
        } catch (NumberFormatException e) {
            // パスワードが数値でない場合のエラーメッセージを設定
            request.setAttribute("passError", "パスワードは数字で入力してください。");
            RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
            dispatcher.forward(request, response);
        }
    }
}
