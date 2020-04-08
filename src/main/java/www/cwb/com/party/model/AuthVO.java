package www.cwb.com.party.model;

public class AuthVO {
	
	public static final String ROLE_MEMBER = "ROLE_MEMBER";
	public static final String ROLE_ADMIN = "ROLE_ADMIN";
	
	private String id;
	private String authority;
	
	public AuthVO() {}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	
	
	public static String getRoleMember() {
		return ROLE_MEMBER;
	}

	public static String getRoleAdmin() {
		return ROLE_ADMIN;
	}

	@Override
	public String toString() {
		return "AuthVO [id=" + id + ", authority=" + authority + "]";
	}
	
	
}
