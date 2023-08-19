package dto;

import java.util.Date;

public class CommReplyDTO {
	private int r_no;
	private int no;
	private String reply;
	private String replier;
	private Date replydate;
	private Date updatedate;
	
	public int getR_no() {
		return r_no;
	}
	public void setR_no(int r_no) {
		this.r_no = r_no;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getReply() {
		return reply;
	}
	public void setReply(String reply) {
		this.reply = reply;
	}
	public String getReplier() {
		return replier;
	}
	public void setReplier(String replier) {
		this.replier = replier;
	}
	public Date getReplydate() {
		return replydate;
	}
	public void setReplydate(Date replydate) {
		this.replydate = replydate;
	}
	public Date getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(Date updatedate) {
		this.updatedate = updatedate;
	}
	
	@Override
	public String toString() {
		return "CommReplyDTO [r_no=" + r_no + ", no=" + no + ", reply=" + reply + ", replier=" + replier
				+ ", replydate=" + replydate + ", updatedate=" + updatedate + "]";
	}
}
