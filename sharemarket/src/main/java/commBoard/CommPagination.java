package commBoard;

public class CommPagination {
	//한 번에 보여질 페이지의 개수
	private static final int block = 5;
	//페이지 블록 내의 첫 번째 페이지 번호
	private int start;
	//페이지 블록 내의 마지막 페이지 번호
	private int end;
	//전체 페이지의 개수
	private int totalPage;
	//이전, 다음 버튼 생성 여부
	private boolean prev, next;
	//전체 게시글들의 개수
	private int totalList;
	//페이지 관련 정보 가져오기
	private CommCriteria criteria;

	public CommPagination(CommCriteria criteria, int totalList) {
		this.criteria = criteria;
		this.totalList = totalList;
		
		this.start = (int) Math.floor((criteria.getPage()-1)/block)*block+1;
		this.end = this.start+4;
		
		//전체 페이지의 개수
		this.totalPage = (int) (Math.ceil((totalList * 1.0) / criteria.getAmount()));
		
		//만약 블록의 마지막 번호가 실제 마지막 페이지보다 크다면 마지막 블록 번호에 마지막 페이지번호 넣음
		if(totalPage < this.end) this.end = totalPage;
		
		//블록의 시작 번호가 1보다 크다면 이전버튼 생성
		this.prev = this.start > 1;
		//블록의 마지막 번호가 전체 페이지 수보다 작다면 다음 버튼 생성
		this.next = this.end < totalPage;
	}
	
	public int getTotalList() {
		return totalList;
	}

	public void setTotalList(int totalList) {
		this.totalList = totalList;
	}

	public CommCriteria getCriteria() {
		return criteria;
	}

	public void setCriteria(CommCriteria criteria) {
		this.criteria = criteria;
	}

	public static int getBlock() {
		return block;
	}
	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	@Override
	public String toString() {
		return "CommPagination [start=" + start + ", end=" + end + ", totalPage=" + totalPage + ", prev=" + prev
				+ ", next=" + next + ", totalList=" + totalList + ", criteria=" + criteria + "]";
	}
	
}
