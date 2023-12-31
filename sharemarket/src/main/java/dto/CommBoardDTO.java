package dto;

import java.util.Date;

public class CommBoardDTO {
	private int no;
	private String title;
	private String content;
	private String writer;
	private String user_id;
	private Date regdate;
	private Date updatedate;
	private int viewcnt;
	private int replycnt;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
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
	
	public int getViewCnt() {
		return viewcnt;
	}
	public void setViewCnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}
	public int getReplyCnt() {
		return replycnt;
	}
	public void setReplyCnt(int replycnt) {
		this.replycnt = replycnt;
	}
}
