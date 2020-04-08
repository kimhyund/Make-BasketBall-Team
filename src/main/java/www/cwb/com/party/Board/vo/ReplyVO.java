package www.cwb.com.party.Board.vo;

import java.util.Date;

public class ReplyVO {
	private int bno;
	private int rno;
	private String content;
	private String replyer;
	private Date regdate;
	private Date updatedate;
	
	
	
	public ReplyVO() {
	}
	public ReplyVO(int bno, String content, String replyer) {
		this.bno = bno;
		this.content = content;
		this.replyer = replyer;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getReplyer() {
		return replyer;
	}
	public void setReplyer(String replyer) {
		this.replyer = replyer;
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
	@Override
	public String toString() {
		return "ReplyVO [bno=" + bno + ", rno=" + rno + ", content=" + content + ", replyer=" + replyer + ", regdate="
				+ regdate + ", updatedate=" + updatedate + "]";
	}
	
	
}
