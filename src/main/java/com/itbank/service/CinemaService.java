package com.itbank.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.cinema.CinemaDAO;
import com.itbank.cinema.CinemaDTO;

@Service
public class CinemaService {

	@Autowired private CinemaDAO dao;

	public int insertCinema(CinemaDTO cinema) {
		return dao.insertCinema(cinema);
	}

	public List<CinemaDTO> selectAllCinema() {
		return dao.selectAllCinema();
	}

}