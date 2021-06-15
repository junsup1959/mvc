package com.itbank.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.admin_board.Paging;
import com.itbank.admin_board.boardDAO;
import com.itbank.admin_board.boardDTO;

@Service
public class BoardSerivce {

	@Autowired private boardDAO dao;
	
	
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
		return dao.selectOne(board_number);
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
	public int boardCount() {
		// TODO Auto-generated method stub
		return dao.boardCount();
	}
	public int delete(int board_number) {
		// TODO Auto-generated method stub
		return dao.delete(board_number);
	}

}
