package com.itbank.theater;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

public interface TheaterDAO {

	@Select("select * from theater")
	List<TheaterDTO> selectAll();

	@Insert("insert into Theater(branch,branchcode,capacity)"
			+ " values("
			+ "#{branch}"
			+ ",#{branchcode}"
			+ ",#{capacity})")
	int insert(TheaterDTO dto);


}