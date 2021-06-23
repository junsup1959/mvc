package com.itbank.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.itbank.admin_member.Admin_memberDAO;
import com.itbank.admin_member.Admin_memberDTO;

@Service
public class AdminService {

	@Autowired private Admin_memberDAO dao;

	public int insert(Admin_memberDTO dto) {
		// TODO Auto-generated method stub
		return dao.insert(dto);
	}

	public List<Admin_memberDTO> selectAll() {
		// TODO Auto-generated method stub
		return dao.selectAll();
	}

	public Admin_memberDTO login(Admin_memberDTO dto) {
		return dao.login(dto);
	}

	public Admin_memberDTO selectOne(String admin_num) {
		// TODO Auto-generated method stub
		return dao.selectOne(admin_num);
	}

	public int update(Admin_memberDTO dto) {
		System.out.println("deleted : " + dto.getDeleted());
		return dao.adminMemberUpdate(dto);
	}

	public int adminCount() {
		return dao.adminCount();
	}

	
	
}
