package www.cwb.com.party.model.criteria;

import org.springframework.web.util.UriComponentsBuilder;

import www.cwb.com.framework.PageDTO;


public class BoardCriteria extends PageDTO {
	private String searchType;
	private String keyword;

	
	
	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public BoardCriteria() {
		super();
	}

	public BoardCriteria(int pageNum, int amount) {
		super(pageNum, amount);
	}
	
	public BoardCriteria(BoardCriteria cri, int totalCnt) {
		super(cri, totalCnt);
		this.searchType = cri.searchType;
		this.keyword = cri.keyword;
	}

	public String[] getSearchTypeArr() {
		return searchType == null ? new String[] {} : searchType.split("");
	}
	
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("");
		builder.queryParam("pageNum", getPageNum())
		.queryParam("amount", getAmount())
		.queryParam("searchType", getSearchType())
		.queryParam("keyword", getKeyword());

		return builder.toUriString();
	}
}

















