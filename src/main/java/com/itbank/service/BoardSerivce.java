package com.itbank.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.itbank.admin_board.CoboardDAO;
import com.itbank.admin_board.CoboardDTO;
import com.itbank.admin_board.Paging;
import com.itbank.admin_board.boardDAO;
import com.itbank.admin_board.boardDTO;
import com.itbank.admin_member.Admin_memberDTO;

@Service
public class BoardSerivce {

	@Autowired private boardDAO dao;
	@Autowired private CoboardDAO c_dao;
	
	public List<boardDTO> list(Paging paging,HashMap<String, Object>param) {
		// TODO Auto-generated method stub
		param.put("offset", paging.getOffset());
		param.put("perPage",paging.getPerPage());
		return dao.list(param);
	}
	public int insert(boardDTO dto) {
		// TODO Auto-generated method stub
		if(dto.getFile().isEmpty()) {
		dto.setBoard_file("");
		return dao.insert(dto);
		}
		dto.ready();
		return dao.insert(dto);
	}
	public boardDTO selectOne(int board_number) {
		// TODO Auto-generated method stub
		boardDTO dto = dao.selectOne(board_number);
		return dto;
	}
	public int update(boardDTO dto) {
		// TODO Auto-generated method stub
		if(dto.getFile().isEmpty()) {
			dto.setBoard_file("");
			return dao.update(dto);
		}
		dto.ready();
		return dao.update(dto);
		
	}
	public int boardCount(HashMap<String, Object> param) {
		// TODO Auto-generated method stub
		return dao.boardCount(param);
	}
	public int delete(int board_number) {
		// TODO Auto-generated method stub
		return dao.delete(board_number);
	}
	public String summernote(MultipartFile multipartFile, HashMap<String, String> jm) {
		String fileRoot = "D:\\upload\\";	//저장될 외부 파일 경로
		String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자				
		String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
		File targetFile = new File(fileRoot + savedFileName);
		try {
			multipartFile.transferTo(targetFile);
		} catch (IllegalStateException | IOException e) {
			targetFile.delete();	//저장된 파일 삭제
			jm.put("responseCode", "error");
			e.printStackTrace();
		}
		return savedFileName;
	}
	public boardDTO next(int board_number, HashMap<String, Object> param) {

		param.put("board_number", board_number);
		return dao.next(param);
	}
	public boardDTO prev(int board_number, HashMap<String, Object> param) {

		param.put("board_number", board_number);
		return dao.prev(param);
	}
/////////--------------------------사내 게시판 -------------------------------------------------////////////////////////////////////
	
	
	public List<CoboardDTO> clist(Paging paging, HashMap<String, Object> param) {
		// TODO Auto-generated method stub
		
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

}
