package com.itbank.admin_board;

public class Board_likeDTO {

	private int el_idx,board_number;
	private String user_email;
	
	public int getEl_idx() {
		return el_idx;
	}
	public void setEl_idx(int el_idx) {
		this.el_idx = el_idx;
	}
	public int getBoard_number() {
		return board_number;
	}
	public void setBoard_number(int board_number) {
		this.board_number = board_number;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
}
