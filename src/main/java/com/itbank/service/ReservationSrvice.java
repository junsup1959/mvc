package com.itbank.service;

import java.util.HashMap;
import java.util.List;

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

	public List<ReservDTO> selectList(String member_email) {
		
		return dao.selectlist(member_email);
	}

	public int delete(HashMap<String, Object> param, String member_email) {
		param.put("member_email", member_email);
		
		return dao.delete(param);
	}

	public List<ReservDTO> selectSeatNum(HashMap<String, Object> param) {
		// TODO Auto-generated method stub
		return dao.selectSeatNum(param);
	}

}
