package com.itbank.admin_board;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

public class boardDTO {
	
	private final String root="D:\\upload\\";
	private int board_number,board_prev,board_next;
	private String board_content,board_bdate,board_edate,board_title,board_store,board_file,admin_num;
	private char board_notice;
	MultipartFile file;
	
	public void ready() {

		if(file.getOriginalFilename().equals("") == false || file != null ) {
			String fileName = UUID.randomUUID().toString().replaceAll("-", "");
			int beginIndex = file.getOriginalFilename().indexOf(".");
			String extName = file.getOriginalFilename().substring(beginIndex);
			fileName += extName;
			
			File f = new File(root, fileName);
			
			try {
				file.transferTo(f);
				
			} catch (IllegalStateException | IOException e) {
				System.out.println("업로드 문제 발생 : " + e);
			}
			this.board_file = fileName;
		}
	}

	public int getBoard_prev() {
		return board_prev;
	}


	public void setBoard_prev(int board_prev) {
		this.board_prev = board_prev;
	}


	public int getBoard_next() {
		return board_next;
	}


	public void setBoard_next(int board_next) {
		this.board_next = board_next;
	}
	
	public int getBoard_number() {
		return board_number;
	}

	public void setBoard_number(int board_number) {
		this.board_number = board_number;
	}

	public String getBoard_content() {
		return board_content;
	}

	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}

	
	public String getBoard_title() {
		return board_title;
	}

	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}

	public String getBoard_store() {
		return board_store;
	}

	public void setBoard_store(String board_store) {
		this.board_store = board_store;
	}

	public String getBoard_file() {
		return board_file;
	}

	public void setBoard_file(String board_file) {
		this.board_file = board_file;
	}

	public String getAdmin_num() {
		return admin_num;
	}

	public void setAdmin_num(String admin_num) {
		this.admin_num = admin_num;
	}

	public char getBoard_notice() {
		return board_notice;
	}

	public void setBoard_notice(char board_notice) {
		this.board_notice = board_notice;
	}


	public MultipartFile getFile() {
		return file;
	}


	public void setFile(MultipartFile file) {
		this.file = file;
	}


	public String getBoard_bdate() {
		return board_bdate;
	}


	public void setBoard_bdate(String board_bdate) {
		this.board_bdate = board_bdate;
	}


	public String getBoard_edate() {
		return board_edate;
	}


	public void setBoard_edate(String board_edate) {
		this.board_edate = board_edate;
	}

	

}
