package com.itbank.admin_board;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface boardDAO {

	int insert(boardDTO dto);

	List<boardDTO> list(HashMap<String, Object> param);

	boardDTO selectOne(int board_number);

	int update(boardDTO dto);

	int boardCount(HashMap<String, Object> param);

	@Update("UPDATE board SET board_deleted='y' where board_number=#{board_number}")
	int delete(int board_number);

	boardDTO next(HashMap<String, Object> param);

	boardDTO prev(HashMap<String, Object> param);

	int eboardCount();

	// 메인 출력용
	@Select("select board_number, board_title, board_store, board_bdate" + 
			" from board" + 
			" where board_notice='N' and board_deleted='n'  and ROWNUM <= 5" + 
			" order by board_bdate desc, board_number desc")
	List<boardDTO> getNotice();

	@Select("select  board_number, board_title, board_store, board_file, board_bdate, board_edate " + 
			"from board " + 
			"where board_notice='E' and sysdate between board_bdate and board_edate and board_deleted='n'  and ROWNUM <= 3 " + 
			"order by board_bdate desc, board_edate")
	List<boardDTO> getEvent();

	// admin 메인 출력용
	@Select("select board_number, board_title, board_store, board_bdate, board_notice "
			+ "from board "
			+ "where ROWNUM <= 5 and board_deleted='n' "
			+ "order by board_bdate desc")
	List<boardDTO> mainList();
	
}
