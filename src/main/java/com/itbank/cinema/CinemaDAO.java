package com.itbank.cinema;

import java.util.List;

import org.apache.ibatis.annotations.Select;

public interface CinemaDAO {

	int insertCinema(CinemaDTO cinema);

	@Select("select * from theater order by screen_code")
	List<CinemaDTO> selectAllCinema();



}