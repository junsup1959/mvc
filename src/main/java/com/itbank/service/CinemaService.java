package com.itbank.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.cinema.CinemaDAO;
import com.itbank.cinema.CinemaDTO;
import com.itbank.cinema.Theater_infoDTO;

@Service
public class CinemaService {

	@Autowired private CinemaDAO dao;

	public int insertCinema(CinemaDTO cinema) {
		return dao.insertCinema(cinema);
	}

	public List<CinemaDTO> selectAllCinema() {
		return dao.selectAllCinema();
	}

	public boolean getBranch(String branch) {
		int row = dao.getBranch(branch);
		return  row == 1 ? true : false;
	}

	public String getBranchCode(String branch) {
		return dao.getBranchCode(branch);
	}

	public List<CinemaDTO> selectAllScreen(String branch) {
		return dao.selectAllScreen(branch);
	}

	public int deleteScreen(String screen_code) {
		return dao.deleteScreen(screen_code);
	}

	public int insertTheater_info(Theater_infoDTO info) {
		return dao.insertTheater_info(info);
	}

	public List<Theater_infoDTO> screenCodes(String screenName) {
		return dao.screenCodes(screenName);
	}

	public List<Theater_infoDTO> screenCodes2(String screenName) {
		return dao.screenCodes2(screenName);
	}

	public List<Theater_infoDTO> selectAlltheater_info() {

		return dao.selectAlltheater_info();
	}

	public int modifyScreen(CinemaDTO cinema) {
		return dao.modifyScreen(cinema);
	}

	public List<Theater_infoDTO> selectAllmovieList(String branch) {
		return dao.selectAllmovieList(branch);
	}

	public List<Theater_infoDTO> selectAlldate() {
		return dao.selectAlldate();
	}



}