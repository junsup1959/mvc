package com.itbank.admin_board;

public class AdminReplyDTO {

	/*
	 * ADMREPLY_WRITER   NOT NULL VARCHAR2(20)  
ADMREPLY_COMMENT  NOT NULL VARCHAR2(400) 
ADMREPLY_IDX      NOT NULL NUMBER        
ADMREPLY_COIDX    NOT NULL NUMBER        
ADMREPLY_ADMINNUM NOT NULL VARCHAR2(30)  
	 * */
	
	private int admreply_idx,admreply_coidx;
	private String admreply_comment,admreply_adminnum,admreply_writer;
	public int getAdmreply_idx() {
		return admreply_idx;
	}
	public void setAdmreply_idx(int admreply_idx) {
		this.admreply_idx = admreply_idx;
	}
	public int getAdmreply_coidx() {
		return admreply_coidx;
	}
	public void setAdmreply_coidx(int admreply_coidx) {
		this.admreply_coidx = admreply_coidx;
	}
	public String getAdmreply_comment() {
		return admreply_comment;
	}
	public void setAdmreply_comment(String admreply_comment) {
		this.admreply_comment = admreply_comment;
	}
	public String getAdmreply_adminnum() {
		return admreply_adminnum;
	}
	public void setAdmreply_adminnum(String admreply_adminnum) {
		this.admreply_adminnum = admreply_adminnum;
	}
	public String getAdmreply_writer() {
		return admreply_writer;
	}
	public void setAdmreply_writer(String admreply_writer) {
		this.admreply_writer = admreply_writer;
	}
	
}
