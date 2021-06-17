package com.itbank.theater;

public class TheaterDTO {

	private int capacity;
	private String branch,branchcode;
	private char usable,deleted;


	public int getCapacity() {
		return capacity;
	}
	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}
	public String getBranch() {
		return branch;
	}
	public void setBranch(String branch) {
		this.branch = branch;
	}

	public char getUsable() {
		return usable;
	}
	public void setUsable(char usable) {
		this.usable = usable;
	}
	public String getBranchcode() {
		return branchcode;
	}
	public void setBranchcode(String branchcode) {
		this.branchcode = branchcode;
	}
	public char getDeleted() {
		return deleted;
	}
	public void setDeleted(char deleted) {
		this.deleted = deleted;
	}


}