package dto;

public class HelpBoardDTO {
	private int h_no;
	private String h_type;
	private String h_title;
	private String h_id;
	private String h_email;
	private String h_content;
	private String h_regdate;
	private int h_answer;
	private String h_an_content;
	private String h_an_date;
	
	public int getH_no() {
		return h_no;
	}
	public void setH_no(int h_no) {
		this.h_no = h_no;
	}
	public String getH_type() {
		return h_type;
	}
	public void setH_type(String h_type) {
		this.h_type = h_type;
	}
	public String getH_title() {
		return h_title;
	}
	public void setH_title(String h_title) {
		this.h_title = h_title;
	}
	public String getH_id() {
		return h_id;
	}
	public void setH_id(String h_id) {
		this.h_id = h_id;
	}
	public String getH_email() {
		return h_email;
	}
	public void setH_email(String h_email) {
		this.h_email = h_email;
	}
	public String getH_content() {
		return h_content;
	}
	public void setH_content(String h_content) {
		this.h_content = h_content;
	}
	public String getH_regdate() {
		return h_regdate;
	}
	public void setH_regdate(String h_regdate) {
		this.h_regdate = h_regdate;
	}
	public int getH_answer() {
		return h_answer;
	}
	public void setH_answer(int h_answer) {
		this.h_answer = h_answer;
	}
	public String getH_an_content() {
		return h_an_content;
	}
	public void setH_an_content(String h_an_content) {
		this.h_an_content = h_an_content;
	}
	public String getH_an_date() {
		return h_an_date;
	}
	public void setH_an_date(String h_an_date) {
		this.h_an_date = h_an_date;
	}
	
	
	@Override
	public String toString() {
		return "HelpBoardDTO [h_no=" + h_no + ", h_type=" + h_type + ", h_title=" + h_title + ", h_id=" + h_id
				+ ", h_email=" + h_email + ", h_content=" + h_content + ", h_regdate=" + h_regdate + ", h_answer="
				+ h_answer + ", h_an_content=" + h_an_content + ", h_an_date=" + h_an_date + "]";
	}
	

}
