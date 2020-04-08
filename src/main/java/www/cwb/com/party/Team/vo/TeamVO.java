package www.cwb.com.party.Team.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;
import www.cwb.com.party.Chat.vo.ChatVO;

@Data
public class TeamVO {
	public String cid;
	public String teamName;
	public String discriminator;
	public String address;
	public int win, draw, lose;			
	public int num_member;	
	public String description;	
	public float winningRate;
	public Date regdate;						
	public Date updatedate;
	public String leader;
	public List<ChatVO> memberList;
	
	
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public String getTeamName() {
		return teamName;
	}
	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}
	public String getDiscriminator() {
		return discriminator;
	}
	public void setDiscriminator(String discriminator) {
		this.discriminator = discriminator;
	}
	
	
	public int getWind() {
		return win;
	}
	public void setWind(int wind) {
		this.win = wind;
	}
	public int getDraw() {
		return draw;
	}
	public void setDraw(int draw) {
		this.draw = draw;
	}
	public int getLose() {
		return lose;
	}
	public void setLose(int lose) {
		this.lose = lose;
	}
	public int getNum_member() {
		return num_member;
	}
	public void setNum_member(int num_member) {
		this.num_member = num_member;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
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
	
	
	public int getWin() {
		return win;
	}
	public void setWin(int win) {
		this.win = win;
	}
	
	
	public String getLeader() {
		return leader;
	}
	public void setLeader(String leader) {
		this.leader = leader;
	}
	public List<ChatVO> getMemberList() {
		return memberList;
	}
	public void setMemberList(List<ChatVO> memberList) {
		this.memberList = memberList;
	}
	
	
	
	public float getWinningRate() {
		return winningRate;
	}
	public void setWinningRate(float winningRate) {
		this.winningRate = winningRate;
	}
	@Override
	public String toString() {
		return "TeamVO [teamName=" + teamName + ", discriminator=" + discriminator + ", win=" + win + ", draw=" + draw
				+ ", lose=" + lose + ", num_member=" + num_member + ", description=" + description + ", regdate="
				+ regdate + ", updatedate=" + updatedate + ", memberList=" + memberList + "]";
	}
	
	
	
	
}
