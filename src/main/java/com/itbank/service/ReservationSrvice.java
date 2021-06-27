package com.itbank.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.revervation.ReservDAO;
import com.itbank.revervation.ReservDTO;

@Service
public class ReservationSrvice {

	@Autowired private ReservDAO dao;
	
	public int insert(ReservDTO dto) {
		return dao.insert(dto);
	}

}
