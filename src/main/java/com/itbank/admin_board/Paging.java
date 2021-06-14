package com.itbank.admin_board;

public class Paging {
	private int perPage =10;
	private int page; 
	private int boardCount;
	private int pageCount;
	private int offset; 
	
	private int perSection=10;
	private int begin;
	private int end;
	private int section;
	
	private boolean prev;
	private boolean next;
	
	public Paging(int page,int boardCount) {
		this.page=page;
		this.boardCount=boardCount;
		
		offset=(page - 1) * perPage;
		
		pageCount = boardCount / perPage;
		pageCount+=(boardCount % perPage == 0) ? 0 : 1;
		
		section =(page - 1) / perSection;		
		begin = perSection * section + 1;	
		end = begin + perSection - 1;		
		end= (end<pageCount) ? end : pageCount;
		
		setPrev(section !=0);
		next = boardCount > perPage * end;
		

	}

	public int getPerPage() {
		return perPage;
	}

	public void setPerPage(int perPage) {
		this.perPage = perPage;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getBoardCount() {
		return boardCount;
	}

	public void setBoardCount(int boardCount) {
		this.boardCount = boardCount;
	}

	public int getPageCount() {
		return pageCount;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	public int getOffset() {
		return offset;
	}
	
	public void setOffset(int offset) {
		this.offset = offset;
	}

	public int getPerSection() {
		return perSection;
	}

	public void setPerSection(int perSection) {
		this.perSection = perSection;
	}

	public int getBegin() {
		return begin;
	}

	public void setBegin(int begin) {
		this.begin = begin;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	public int getSection() {
		return section;
	}

	public void setSection(int section) {
		this.section = section;
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

}
