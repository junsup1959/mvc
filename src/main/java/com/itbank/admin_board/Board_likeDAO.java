package com.itbank.admin_board;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

public interface Board_likeDAO {

	@Select("select count(*) from board_like where board_number=#{board_number} and user_email=#{user_email}")
	int blselectOne(Board_likeDTO dto);

	@Select("select count(*) from board_like where board_number =#{board_number}")
	int blcount(int board_number);
	
	@Insert("insert into board_like(el_idx,user_email,board_number) values(el_seq.nextval,#{user_email},#{board_number})")
	int BLinsert(Board_likeDTO dto);

	@Select("select * from board_like where board_number=#{board_number}")
	List<Board_likeDTO> blselectAll(int board_number);
	
	@Delete("delete board_like where board_number =#{board_number} and user_email=#{user_email} ")
	int BLdelete(Board_likeDTO dto);
}
