package com.itbank.admin_board;

/*
 *CO_IDX     NOT NULL NUMBER         
CO_DELETED          CHAR(1)        
CO_WRITER  NOT NULL VARCHAR2(50)   
CO_CONTENT NOT NULL VARCHAR2(2000) 
CO_DATE             VARCHAR2(20)   
CO_TITLE   NOT NULL VARCHAR2(50)   
CO_NUM     NOT NULL VARCHAR2(20)     
 */


public class CoboardDTO {
	private int co_idx,co_next,co_prev;
	private String co_deleted,co_content,co_date,co_title,co_num,co_writer;
	public int getCo_idx() {
		return co_idx;
	}
	public void setCo_idx(int co_idx) {
		this.co_idx = co_idx;
	}
	public String getCo_deleted() {
		return co_deleted;
	}
	public void setCo_deleted(String co_deleted) {
		this.co_deleted = co_deleted;
	}
	public String getCo_content() {
		return co_content;
	}
	public void setCo_content(String co_content) {
		this.co_content = co_content;
	}
	public String getCo_date() {
		return co_date;
	}
	public void setCo_date(String co_date) {
		this.co_date = co_date;
	}
	public String getCo_title() {
		return co_title;
	}
	public void setCo_title(String co_title) {
		this.co_title = co_title;
	}
	public String getCo_num() {
		return co_num;
	}
	public void setCo_num(String co_num) {
		this.co_num = co_num;
	}
	public String getCo_writer() {
		return co_writer;
	}
	public void setCo_writer(String co_writer) {
		this.co_writer = co_writer;
	}
	public int getCo_prev() {
		return co_prev;
	}
	public void setCo_prev(int co_prev) {
		this.co_prev = co_prev;
	}
	public int getCo_next() {
		return co_next;
	}
	public void setCo_next(int co_next) {
		this.co_next = co_next;
	}
	public void setBoard_next(int co_next2) {
		// TODO Auto-generated method stub
		
	}
	
	
}
