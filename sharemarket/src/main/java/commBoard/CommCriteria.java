package commBoard;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class CommCriteria {
	
	//검색
	private String option;
	private String keyword;
	
	public String searchUri() {
		UriComponents uri = UriComponentsBuilder.newInstance()
				.queryParam("optioin", this.getOption())
				.queryParam("keyword", this.getKeyword()).build();
		return uri.toString();
	}

	public String getOption() {
		return option;
	}

	public void setOption(String option) {
		this.option = option;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

/*	@Override
	public String toString() {
		return "CommCriteria [option=" + option + ", keyword=" + keyword + "]";
	}*/
	
	
	//페이징
	private int page; //현재 페이지 번호
	private int amount; //한 페이지에 들어갈 목록 수
	
	public String pageUri(int page) {
		UriComponents uri = UriComponentsBuilder.newInstance()
				.queryParam("page", page)
				.queryParam("amount", this.amount).build();
		return uri.toString();
	}
	
	public String pageUri(int page, String keyword) {
		UriComponents uri = null;
		
		if(keyword == null) return pageUri(page);
		else {
			uri = UriComponentsBuilder.newInstance()
					.queryParam("page", page)
					.queryParam("amount", this.amount)
					.queryParam("option", option)
					.queryParam("keyword", keyword).build();
			return uri.toString();
		}
	}
	
	public CommCriteria() {
		this(1, 10);
	}
	
	public CommCriteria(int page, int amount) {
		this.page = page;
		this.amount = amount;
	}
	
	public CommCriteria(int page, int amount, String option, String keyword) {
		this.page = page;
		this.amount = amount;
		this.option = option;
		this.keyword = keyword;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	@Override
	public String toString() {
		return "CommCriteria [option=" + option + ", keyword=" + keyword + ", page=" + page + ", amount=" + amount
				+ "]";
	}
	
}
