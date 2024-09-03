package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import entity.User;

public class UserDao {
		
	// データベースからユーザー名とパスワードを取得するためのSQL文
		private static final String SQL_SELECT_NAME_AND_PASS = "SELECT * FROM tunagu_user WHERE user_name = ? AND password = ?";
		
	
	private Connection connection;

	public UserDao(Connection connection) {
		this.connection = connection;
	}
		
		// 名前とパスワードでユーザーを検索するメソッド
		public User findByNameAndPass(String name, String pass) {
			try (PreparedStatement stmt = connection.prepareStatement(SQL_SELECT_NAME_AND_PASS)) {
				
				// プレースホルダにユーザー名とパスワードをセット
				stmt.setString(1, name);
				stmt.setString(2, pass); 
				
				// クエリを実行し、結果セットを取得
				ResultSet rs = stmt.executeQuery();

				// 結果セットにデータがある場合、Userオブジェクトを生成して返す
				 if (rs.next()) {
		                return new User(rs.getString("user_name"), rs.getString("password"));
		         } else {
		        	 
		        	 	// データがない場合はnullを返す
		                return null;
					
				}
			 } catch (SQLException e) {
				 	//例外処理
		            throw new RuntimeException(e);
		        }
		}
}
