package service;

import java.sql.Connection;

import dao.UserDao;
import entity.User;
import util.DbUtil;

public class UserService {
	
	// ユーザー認証を行うメソッド
	public User authentication(String name, String pass) {
        try (Connection conn = DbUtil.getConnection()) {
            UserDao userDao = new UserDao(conn);
            
            User user = userDao.findByNameAndPass(name, pass);
            
         // 検索結果のユーザーを返す
            return user;
        } catch (Exception e) {
        	// 例外が発生した場合、その内容をコンソールに出力
            e.printStackTrace();
        }
     // 例外が発生した場合やユーザーが見つからなかった場合はnullを返す
        return null;
    }

}
