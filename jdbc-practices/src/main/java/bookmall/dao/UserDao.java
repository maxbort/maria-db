package bookmall.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import bookmall.vo.UserVo;

public class UserDao {
	
	private Connection getConnection() throws SQLException {
		Connection conn = null;
		
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			String url = "jdbc:mariadb://192.168.0.198:3306/bookmall?charset=utf8";
			conn = DriverManager.getConnection(url, "bookmall", "bookmall");
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패:" + e);
		}
		
		return conn;
	}
	
	public int insert(UserVo vo) {
		int result = 0;
		//System.out.println(vo.getName());
		
		try (
				Connection conn = getConnection();
				PreparedStatement pstmt1 = conn.prepareStatement("insert into member(name, phone, email,password) values(?, ?,?,?)");
				PreparedStatement pstmt2 = conn.prepareStatement("select last_insert_id() from dual");
			) {
			
				pstmt1.setString(1, vo.getName());
				pstmt1.setString(2, vo.getPhone());
				pstmt1.setString(3, vo.getEmail());
				pstmt1.setString(4, vo.getPassword());
				
				result = pstmt1.executeUpdate();
			
				
				ResultSet rs = pstmt2.executeQuery();
				vo.setNo(rs.next() ?  rs.getLong(1) : null);
				rs.close();
			} catch (SQLException e) {
				System.out.println("error:" + e);
			}
			
			return result;
							
		}
		
		
		
	

	public int deleteBooksByNo(Long no) {
		int result = 0;
			
		try (
				Connection conn = getConnection();
				PreparedStatement pstmt = conn.prepareStatement("delete from member where no = ?");
		) {
			pstmt.setLong(1, no);
			result = pstmt.executeUpdate();
				
			//5. 결과 처리
		} catch (SQLException e) {
			System.out.println("error:" + e);
		}
		return result;
		
		
	}

	public List<UserVo> findAll() {
		List<UserVo> result = new ArrayList<>();

		try (
			Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement("select no, name, phone, email, password from member order by no");
			ResultSet rs = pstmt.executeQuery();
		) {
			while (rs.next()) {
				Long no = rs.getLong(1);
				String name = rs.getString(2);
				String phone = rs.getString(3);
				String email = rs.getString(4);
				String password = rs.getString(5);

				UserVo vo = new UserVo(name, email, password, phone);
				vo.setNo(no);
				
				result.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("error : " + e);
		}

		return result;
	}

	public int deleteByNo(Long no) {
		int result = 0;

		try (
			Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement("delete from member where no = ?");
		) {
			pstmt.setLong(1, no);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("error:" + e);
		}
		
		return result;		
	}
}
