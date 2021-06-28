package com.itbank.cinema;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;

public interface CinemaDAO {

	int insertCinema(CinemaDTO cinema);

	@Select("select * from theater order by screen_code")
	List<CinemaDTO> selectAllCinema();

	@Select("select count(distinct branch) from theater where branch = #{branch}")
	int getBranch(String branch);

	@Select("select distinct branch_code from theater where branch = #{branch}")
	String getBranchCode(String branch);

	@Select("select screen_code from theater where branch = #{branch} order by screen_code")
	List<CinemaDTO> selectAllScreen(String branch);

	@Delete("delete from theater where screen_code = #{screen_code}")
	int deleteScreen(String screen_code);

	int insertTheater_info(Theater_infoDTO info);

	@Select("select start_date, end_date, start_time, end_time, runtime from theater_info where screen_code=#{screen_code}")
	List<Theater_infoDTO> screenCodes(String screenName);





}