package www.cwb.com.party.Member.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;
import www.cwb.com.party.Chat.vo.ChatVO;
import www.cwb.com.party.Team.vo.TeamVO;
import www.cwb.com.party.model.AuthVO;
@Data
public class MemberVO {
	private String id;	
	private String password;
	// 식별자 char로 수정, Edited by KTLIM(2019.12.20)
	private char discriminator;						
	private String name;					
	// 전화번호 String으로 수정, Edited by KTLIM(2019.12.20)
	private String phoneNumber;							
	private String email;					
	private int height;						
	private int grade;						
	private String address;					
	private String nickName;				
	private String position;    			 
	private String gender;						
	private Date regdate;
	private Date updatedate;
	private List<ChatVO> teamLists;
	private List<MemberVO> requestLists;
	// 탈퇴여부 추가, Edited by KTLIM(2019.12.20)
	private char enabled;
	private String reason;
	
	private List<AuthVO> authList;

	
	
	public String getId() {
		return id;
	}

	
	public void setId(String id) {
		this.id = id;
	}

	public char getDiscriminator() {
		return discriminator;
	}

	public void setDiscriminator(char discriminator) {
		this.discriminator = discriminator;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public float getHeight() {
		return height;
	}

	public void setHeight(int height) {
		this.height = height;
	}

	public int getGrade() {
		return grade;
	}

	public void setGrade(int grade) {
		this.grade = grade;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public Date getUpdatedate() {
		return updatedate;
	}

	public void setUpdatedate(Date updatedate) {
		this.updatedate = updatedate;
	}

	public List<AuthVO> getAuthList() {
		return authList;
	}

	public void setAuthList(List<AuthVO> authList) {
		this.authList = authList;
	}

	
	
	public char getEnabled() {
		return enabled;
	}

	public void setEnabled(char enabled) {
		this.enabled = enabled;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}
	
	

	public List<ChatVO> getTeamLists() {
		return teamLists;
	}


	public void setTeamLists(List<ChatVO> teamLists) {
		this.teamLists = teamLists;
	}


	public List<MemberVO> getRequestLists() {
		return requestLists;
	}


	public void setRequestLists(List<MemberVO> requestLists) {
		this.requestLists = requestLists;
	}


	@Override
	public String toString() {
		return "MemberVO [id=" + id + ", password=" + password + ", discriminator=" + discriminator + ", name=" + name
				+ ", phoneNumber=" + phoneNumber + ", email=" + email + ", height=" + height + ", grade=" + grade
				+ ", address=" + address + ", nickName=" + nickName + ", position=" + position + ", gender=" + gender
				+ ", regdate=" + regdate + ", updatedate=" + updatedate + ", enabled=" + enabled + ", reason=" + reason
				+ ", authList=" + authList + "]";
	}


	
	
	
	
	
}
