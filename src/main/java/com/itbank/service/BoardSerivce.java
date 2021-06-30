package com.itbank.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.itbank.admin_board.AdminReplyDAO;
import com.itbank.admin_board.AdminReplyDTO;
import com.itbank.admin_board.Board_likeDAO;
import com.itbank.admin_board.Board_likeDTO;
import com.itbank.admin_board.CoboardDAO;
import com.itbank.admin_board.CoboardDTO;
import com.itbank.admin_board.Paging;
import com.itbank.admin_board.boardDAO;
import com.itbank.admin_board.boardDTO;
import com.itbank.admin_member.Admin_memberDTO;
import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.SftpException;

@Service
public class BoardSerivce {

	@Autowired private boardDAO dao;
	@Autowired private CoboardDAO c_dao;
	@Autowired private Board_likeDAO bl_dao;
	@Autowired private AdminReplyDAO r_dao;
	private final String serverIp = "192.168.0.70";
	private final int serverPort = 22;
	private final String serverUser = "root";
	private final String serverPass = "1";
	private ChannelSftp chsftp = null;
	
	
	
	public List<boardDTO> list(Paging paging,HashMap<String, Object>param) {
		// TODO Auto-generated method stub
		param.put("offset", paging.getOffset());
		param.put("perPage",paging.getPerPage());
		return dao.list(param);
	}
	public int insert(boardDTO dto) throws IllegalStateException, SftpException, JSchException, IOException {

		if(dto.getFile().isEmpty()) {
		dto.setBoard_file("");
		return dao.insert(dto);
		}
		dto.ready();
		return dao.insert(dto);
	}
	public boardDTO selectOne(int board_number) {

		boardDTO dto = dao.selectOne(board_number);
		return dto;
	}
	public int update(boardDTO dto) throws IllegalStateException, SftpException, JSchException, IOException {

		if(dto.getFile().isEmpty()) {
			dto.setBoard_file("");
			return dao.update(dto);
		}
		dto.ready();
		return dao.update(dto);
		
	}
	public int boardCount(HashMap<String, Object> param) {

		return dao.boardCount(param);
	}
	public int delete(int board_number) {

		return dao.delete(board_number);
	}
	public String summernote(MultipartFile multipartFile) throws JSchException, IOException, SftpException {
		
		
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
		
		String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자				
		String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
		
		File tmp = new File(multipartFile.getOriginalFilename());
		multipartFile.transferTo(tmp);
	
		FileInputStream fis = new FileInputStream(tmp);
		chsftp.cd("/var/www/html");
		chsftp.put(fis, savedFileName);
		
		System.out.println("sftp> transfer complete !!");

		fis.close();
		chsftp.exit();
		tmp.delete();
		
		System.out.println("sftp>exit");
		
		return "http://" + serverIp + ":1234/"+savedFileName;
	
		
	}
	
	public boardDTO next(int board_number, HashMap<String, Object> param) {

		param.put("board_number", board_number);
		return dao.next(param);
	}
	public boardDTO prev(int board_number, HashMap<String, Object> param) {

		param.put("board_number", board_number);
		return dao.prev(param);
	}
////////////////////////////////////////////리플////////////////////////////	
public int replyInsert(AdminReplyDTO dto) {

return r_dao.replyInsert(dto);
}

///////////////////////////////////////////// 좋아요 구현

public int blselectOne(Board_likeDTO dto) {

return bl_dao.blselectOne(dto);
}
public int blcount(int board_number) {

return bl_dao.blcount(board_number);
}
public int BLinsert(Board_likeDTO dto) {

return bl_dao.BLinsert(dto);
}
public int BLdelete(Board_likeDTO dto) {

return bl_dao.BLdelete(dto);
}

/////////--------------------------사내 게시판 -------------------------------------------------////////////////////////////////////
	
	
	public List<CoboardDTO> clist(Paging paging, HashMap<String, Object> param) {
		
		param.put("offset", paging.getOffset());
		param.put("perPage",paging.getPerPage());
		return c_dao.clist(param);
	}
	public int cboardCount() {
		
		return c_dao.cboardCount();
	}
	public CoboardDTO cselectOne(int co_idx) {
		
		return c_dao.cselectOne(co_idx);
	}
	public CoboardDTO cnext(int co_idx) {
	
		return c_dao.cnext(co_idx);
	}
	public CoboardDTO cprev(int co_idx) {
		
		return c_dao.cprev(co_idx);
	}
	public int cupdate(CoboardDTO dto) {
		
		return c_dao.cupdate(dto);
	}
	public int cinsert(CoboardDTO dto) {
		
		return c_dao.cinsert(dto);
	}
	public int cdelete(int co_idx,HttpSession session) {
		
		CoboardDTO dto =c_dao.cselectOne(co_idx);
		Admin_memberDTO ad_login = (Admin_memberDTO) session.getAttribute("ad_login");
		if(dto.getCo_num().equals(ad_login.getAdmin_num())) {
			return c_dao.cdelete(co_idx);
		}
		return 0;
	}
	
	//  - - - - - - - - - - - 메인 페이지 출력용  - - - - - - - - - - -
	public List<boardDTO> homeNotice() {
		return dao.getNotice();
	}
	public List<boardDTO> homeEvent() {
		return dao.getEvent();
	}
	public List<boardDTO> mainList() {
		return dao.mainList();
	}

}
