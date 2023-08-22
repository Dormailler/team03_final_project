package pagination;

public class SearchDTO {
	private int page; // 현재 페이지 번호
	private int recordSize; // 페이지당 출력할 데이터 개수
	private int pageSize; // 화면 하단에 출력할 페이지 사이즈
	
	private String keyword; // 검색 키워드
	private String searchType1; // 검색 유형1
	private String searchType2; // 검색 유형2
	private String searchType3; // 검색 유형3
	private String recipeType; //레시피 유형

	private String sortType; // 정렬유형
	
	private String startDate; //날짜검색 시작날짜
	private String endDate; //날짜검색 종료날짜
	
	private Pagination pagination; // 페이지네이션 정보

	public SearchDTO() {
		this.page = 1;
		this.recordSize = 10;
		this.pageSize = 10;
	}

	// Getter Setter

	public int getPage() {
		return page;
	}

	public int getOffset() {
		return (page - 1) * recordSize;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRecordSize() {
		return recordSize;
	}

	public void setRecordSize(int recordSize) {
		this.recordSize = recordSize;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public Pagination getPagination() {
		return pagination;
	}

	public void setPagination(Pagination pagination) {
		this.pagination = pagination;
	}

	public String getSearchType1() {
		return searchType1;
	}

	public void setSearchType1(String searchType1) {
		this.searchType1 = searchType1;
	}

	public String getSearchType2() {
		return searchType2;
	}

	public void setSearchType2(String searchType2) {
		this.searchType2 = searchType2;
	}

	public String getSearchType3() {
		return searchType3;
	}

	public void setSearchType3(String searchType3) {
		this.searchType3 = searchType3;
	}

	public String getSortType() {
		return sortType;
	}

	public void setSortType(String sortType) {
		this.sortType = sortType;
	}
	
	
	public String getRecipeType() {
		return recipeType;
	}

	public void setRecipeType(String recipeType) {
		this.recipeType = recipeType;
	}
	

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}


}
