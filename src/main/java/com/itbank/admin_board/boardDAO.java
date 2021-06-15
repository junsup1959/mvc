package com.itbank.admin_board;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Update;

public interface boardDAO {

	int insert(boardDTO dto);

	List<boardDTO> list(HashMap<String, Object> param);

	boardDTO selectOne(int board_number);

	int update(boardDTO dto);

	int boardCount();

	@Update("UPDATE board SET board_deleted='y' where board_number=#{board_number}")
	int delete(int board_number);

	
}
