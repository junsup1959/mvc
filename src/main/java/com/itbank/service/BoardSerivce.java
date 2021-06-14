package com.itbank.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.admin_board.boardDAO;
import com.itbank.admin_board.boardDTO;

@Service
public class BoardSerivce {

	@Autowired private boardDAO dao;
	
	
	public List<boardDTO> boardAll() {
		// TODO Auto-generated method stub
		return dao.list();
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

}
