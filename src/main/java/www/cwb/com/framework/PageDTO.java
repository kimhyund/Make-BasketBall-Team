package www.cwb.com.framework;

public class PageDTO {
	private static final int PAGE_NAV_SIZE = 10;
	private int pageNum;
	private int amount;

	private int startPage;
	private int endPage;
	private boolean hasPrev, hasNext;
	
	private int totalCnt;
	
	
	
	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
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

	public boolean isHasPrev() {
		return hasPrev;
	}

	public void setHasPrev(boolean hasPrev) {
		this.hasPrev = hasPrev;
	}

	public boolean isHasNext() {
		return hasNext;
	}

	public void setHasNext(boolean hasNext) {
		this.hasNext = hasNext;
	}

	public int getTotalCnt() {
		return totalCnt;
	}

	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}

	public static int getPageNavSize() {
		return PAGE_NAV_SIZE;
	}

	public PageDTO() {
		this.pageNum = 1;
		this.amount = 10;
	}
	
	public PageDTO(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public PageDTO(PageDTO cri, int totalCnt) {
		this(cri.pageNum, cri.amount);
		this.totalCnt = totalCnt;
		
		endPage = (int) (Math.ceil(pageNum / (float) PAGE_NAV_SIZE) * PAGE_NAV_SIZE);
		startPage = endPage - PAGE_NAV_SIZE + 1 ;
		int realEnd = (int) Math.ceil(((float) totalCnt) / amount);
		endPage = realEnd < endPage ? realEnd : endPage;
		hasPrev = startPage > 1;
		hasNext = realEnd > endPage;
	}
}









