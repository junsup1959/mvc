package com.itbank.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.admin_board.Paging;
import com.itbank.admin_member.Admin_memberDAO;
import com.itbank.admin_member.Admin_memberDTO;

@Service
public class AdminService {

	@Autowired private Admin_memberDAO dao;

	public int insert(Admin_memberDTO dto) {
		// TODO Auto-generated method stub
		return dao.insert(dto);
	}

	public List<Admin_memberDTO> selectAll(Paging paging, HashMap<String, Object> param) {
		param.put("offset",paging.getOffset());
		param.put("perPage",paging.getPerPage());
		
		return dao.selectAll(param);
	}

	public Admin_memberDTO login(Admin_memberDTO dto) {
		return dao.login(dto);
	}

	public Admin_memberDTO selectOne(String admin_num) {
		// TODO Auto-generated method stub
		return dao.selectOne(admin_num);
	}

	public int update(Admin_memberDTO dto) {
		
		if(dto.getAdmin_lday().equals("") ) {
			dto.setDeleted("n");
		}else {
			dto.setDeleted("y");
		}
		System.out.println("퇴사여부 : " + dto.getDeleted());
		return dao.adminMemberUpdate(dto);
	}

	public int adminCount() {
		return dao.adminCount();
	}

	public int changePw(Admin_memberDTO dto) {
		return dao.changePw(dto);
	}

	
	
}
