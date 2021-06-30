package com.itbank.admin_board;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.SftpException;

public class boardDTO {
	
	private final String root="D:\\upload\\";
	private int board_number,board_prev,board_next;
	private String board_content,board_bdate,board_edate,board_title,board_store,board_file,admin_num;
	private String board_notice;
	MultipartFile file;
	private final String serverIp = "192.168.0.70";
	private final int serverPort = 22;
	private final String serverUser = "root";
	private final String serverPass = "1";
	private ChannelSftp chsftp = null;
	
	public void ready() throws SftpException, JSchException, IllegalStateException, IOException {

		if(file.getOriginalFilename().equals("") == false || file != null ) {
			Session sess = null;
			Channel channel = null;
			JSch jsch = new JSch();
			sess = jsch.getSession(serverUser, serverIp, serverPort);
			sess.setPassword(serverPass);
			sess.setConfig("StrictHostKeyChecking", "no");
			
			sess.connect();
			System.out.println("sftp> Connected");
			System.out.println(sess.getHost());
			
			channel = sess.openChannel("sftp");
			channel.connect();
			chsftp = (ChannelSftp) channel;
			
			System.out.println("aaa : " + channel);
			////////////////////////////////////////////////////////////////
			
			String originalFileName = file.getOriginalFilename();	//오리지날 파일명
			String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자				
			String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
			
			File tmp = new File(file.getOriginalFilename());
			file.transferTo(tmp);
		
			FileInputStream fis = new FileInputStream(tmp);
			chsftp.cd("/var/www/html");
			chsftp.put(fis, savedFileName);
			
			System.out.println("sftp> transfer complete !!");

			fis.close();
			chsftp.exit();
			tmp.delete();
			
			System.out.println("sftp>exit");
			
			board_file = "http://" + serverIp + ":1234/"+savedFileName;
		
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

	public String getBoard_notice() {
		return board_notice;
	}

	public void setBoard_notice(String board_notice) {
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
