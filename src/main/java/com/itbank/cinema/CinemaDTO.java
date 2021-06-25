package com.itbank.cinema;

public class CinemaDTO {

//		    branch varchar(10) not null,
//		    branch_code varchar(30) primary key,
//		    branch_sdate varchar2(20) default to_char(sysdate,'yyyy-MM-dd'),
//		    branch_edate varchar2(20) default to_char(sysdate,'yyyy-MM-dd'),
//		     usable char default 'y' check(usable in('y','n')),
//		   screen_code varchar2(20) unique,
//		seat_amount number

	
	private String branch, branch_code, branch_sdate, branch_edate, usable, screen_code;
	private int seat_amount;
	public String getBranch() {
		return branch;
	}
	public void setBranch(String branch) {
		this.branch = branch;
	}
	public String getBranch_code() {
		return branch_code;
	}
	public void setBranch_code(String branch_code) {
		this.branch_code = branch_code;
	}
	public String getBranch_sdate() {
		return branch_sdate;
	}
	public void setBranch_sdate(String branch_sdate) {
		this.branch_sdate = branch_sdate;
	}
	public String getBranch_edate() {
		return branch_edate;
	}
	public void setBranch_edate(String branch_edate) {
		this.branch_edate = branch_edate;
	}
	public String getUsable() {
		return usable;
	}
	public void setUsable(String usable) {
		this.usable = usable;
	}
	public String getScreen_code() {
		return screen_code;
	}
	public void setScreen_code(String screen_code) {
		this.screen_code = screen_code;
	}
	public int getSeat_amount() {
		return seat_amount;
	}
	public void setSeat_amount(int seat_amount) {
		this.seat_amount = seat_amount;
	}
	
	
}