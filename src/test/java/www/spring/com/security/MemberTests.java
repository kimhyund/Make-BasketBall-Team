package www.spring.com.security;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
						"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class MemberTests {

	@Autowired
	private PasswordEncoder passwordEncoder; 
	@Autowired
	private DataSource dataSource;
	
	
	//@Test
	public void testInsertMember() {
		String sql = "insert into tbl_party(id, discriminator,nickName, password) values(?,?,?,?)";
		
		for(int i = 0; i < 10; i++) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				con = dataSource.getConnection();
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "abc" + i);
				pstmt.setString(2, "M");
				pstmt.setString(3, "testSubject" + i);
				pstmt.setString(4, passwordEncoder.encode("abc" + i));
				
				
				pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			} finally {
				if(pstmt != null) {try {pstmt.close();}catch(Exception e) {} }
				if(con != null) {try {con.close();}catch(Exception e) {} }
			}
		}
	}
	
	@Test
	public void testInsertAuth() {
		String sql = "insert into tbl_auth(u_id, u_authority) values(?,?)";
		
		for(int i = 0; i < 10; i++) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				con = dataSource.getConnection();
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "abc" + i);
				pstmt.setString(2, "ROLE_MEMBER");
				
				
				pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			} finally {
				if(pstmt != null) {try {pstmt.close();}catch(Exception e) {} }
				if(con != null) {try {con.close();}catch(Exception e) {} }
			}
		}
	}
	
	
}











