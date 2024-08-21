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
        request.setCharacterEncoding("UTF-8");
        
        //index.jspのname="name"とgetParameter("name")が結びついて、入力値を受け取っている
        String name = request.getParameter("name");
        
        //index.jspのname="pass"とgetParameter("pass")が結びついて、入力値を受け取っている
        String pass = request.getParameter("pass");

        try {
            int intPass = Integer.parseInt(pass);

            if ("ユーザー".equals(name) && intPass == 1234) {
            	
            	HttpSession session = request.getSession();
            	
            	//セッションに名前を保存。これによりログアウトするまで各ページでログイン時の名前を使用できる。
            	session.setAttribute("name", name);
                
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
