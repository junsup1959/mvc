package com.itbank.admin_board;

import java.util.List;

public interface boardDAO {

	int insert(boardDTO dto);

	List<boardDTO> list();

	boardDTO selectOne(int board_number);

	int update(boardDTO dto);

	
}
