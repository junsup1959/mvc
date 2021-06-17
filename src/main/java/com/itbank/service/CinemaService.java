package com.itbank.service;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.theater.TheaterDAO;
import com.itbank.theater.TheaterDTO;

@Service
public class CinemaService {

	@Autowired private TheaterDAO dao;

	public List<TheaterDTO> selectAll() {
		// TODO Auto-generated method stub
		return dao.selectAll();
	}

	public int insert(TheaterDTO dto) {
		String branchcode=dto.getBranch();
		branchcode += UUID.randomUUID().toString().split("-")[0];
		dto.setBranchcode(branchcode);
		return dao.insert(dto);
		}

	public TheaterDTO selectOne(String branchcode) {
		// TODO Auto-generated method stub
		return dao.selectOne(branchcode);
	}

	public int update(TheaterDTO dto) {
		// TODO Auto-generated method stub

		return dao.update(dto);
	}

	public int delete(String branchcode) {
		// TODO Auto-generated method stub
		return dao.delete(branchcode);
	}
}