package commBoard;

public class HelpPage {
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	private HelpCriteria cri;
	private int total;
	
	public HelpPage(HelpCriteria cri, int total) {
	    this.cri = cri;
	    this.total = total;

	    int tempEnd = (int) (Math.ceil(cri.getPageNum() / 5.0)) * 5;
	    this.startPage = tempEnd - 4;

	    int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));

	    if (realEnd <= tempEnd) {
	        this.endPage = realEnd;
	    } else {
	        this.endPage = tempEnd;
	    }

	    this.prev = this.startPage > 1;
	    this.next = this.endPage < realEnd;
	}

	
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
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
	public HelpCriteria getCri() {
		return cri;
	}
	public void setCri(HelpCriteria cri) {
		this.cri = cri;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	@Override
	public String toString() {
		return "HelpPage [startPage=" + startPage + ", endPage=" + endPage + ", prev=" + prev + ", next=" + next
				+ ", cri=" + cri + ", total=" + total + "]";
	}
}
