package com.itbank.theater;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface TheaterDAO {

	@Select("select * from theater where deleted='n'")
	List<TheaterDTO> selectAll();

	@Insert("insert into Theater(branch,branchcode,capacity)"
			+ " values("
			+ "#{branch}"
			+ ",#{branchcode}"
			+ ",#{capacity})")
	int insert(TheaterDTO dto);

	@Select("select * from theater where deleted='n' and branchcode=#{branchcode}")
	TheaterDTO selectOne(String branchcode);

	@Update("update theater set capacity=#{capacity} , usable =#{usable} where branchcode = #{branchcode}")
	int update(TheaterDTO dto);

	@Update("update theater set deleted ='y' where branchcode = #{branchcode}")
	int delete(String branchcode);


}