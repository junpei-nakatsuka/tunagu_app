package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entity.User;
import service.UserService;


@WebServlet("/Login01")
public class LoginServlet01 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LoginServlet01() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    	//エンコード設定。UTF-8に設定しないと日本語は文字化けして表示されちゃう
    	request.setCharacterEncoding("UTF-8");
        
        //index.jspのname="inputName"とgetParameter("inputName")が結びついて、入力値を受け取っている
        String name = request.getParameter("inputName");
        
        //index.jspのname="inputPass"とgetParameter("inputPass")が結びついて、入力値を受け取っている
        String pass = request.getParameter("inputPass");
        
                 
        	//ログインチェック
            UserService userService = new UserService();
            User user = userService.authentication(name,pass);

            if (user != null) {
            	
            	//ログインが成功した場合
                HttpSession session = request.getSession();
                
              //セッションに名前を保存。これによりログアウトするまで各ページでログイン時の名前を使いまわせる。
            	session.setAttribute("name", name);

                // 次画面指定
            	RequestDispatcher dispatcher = request.getRequestDispatcher("start.jsp");
                dispatcher.forward(request, response);
                
            } else {
            	//ログインに失敗した場合
            	 request.setAttribute("error", "名前またはパスワードが間違っています。");
                 RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
                 dispatcher.forward(request, response);
            }  
    }
}
    
