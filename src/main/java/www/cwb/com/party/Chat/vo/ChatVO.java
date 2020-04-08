package www.cwb.com.party.Chat.vo;

import java.util.Date;

import lombok.Data;
@Data
public class ChatVO {
	private	String id;	
	private String team_id;
	private String user_id;
	private String content;
	private String isRequest;
	private String teamLeaderId;
	private String join_state;
	private Date reg_date;
	
	
	
	
	public String getId() {
		return id;
	}




	public void setId(String id) {
		this.id = id;
	}




	public String getTeam_id() {
		return team_id;
	}




	public void setTeam_id(String team_id) {
		this.team_id = team_id;
	}




	public String getUser_id() {
		return user_id;
	}




	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}




	public String getContent() {
		return content;
	}




	public void setContent(String content) {
		this.content = content;
	}




	public String getIsRequest() {
		return isRequest;
	}




	public void setIsRequest(String isRequest) {
		this.isRequest = isRequest;
	}




	public String getTeamLeaderId() {
		return teamLeaderId;
	}




	public void setTeamLeaderId(String teamLeaderId) {
		this.teamLeaderId = teamLeaderId;
	}




	public String getJoin_state() {
		return join_state;
	}




	public void setJoin_state(String join_state) {
		this.join_state = join_state;
	}




	public Date getReg_date() {
		return reg_date;
	}




	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}




	@Override
	public String toString() {
		return "ChatVO [user_id=" + user_id + "]";
	}

	
}
