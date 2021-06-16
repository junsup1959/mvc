package com.itbank.service;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.admin_board.Paging;
import com.itbank.member.MemberDAO;
import com.itbank.member.MemberDTO;

@Service
public class MemberService {

	@Autowired MemberDAO dao;

	private String getHash(String input) {
		String hash = null;
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-512");
			md.reset();
			md.update(input.getBytes("UTF-8"));
			hash = String.format("%0128x", new BigInteger(1, md.digest()));
		} catch (NoSuchAlgorithmException | UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return hash;
	}
	
	
	
	public int insert(MemberDTO member) {
//		member.setMember_password(getHash(member.getMember_password()));
		String[] user_num = UUID.randomUUID().toString().split("-");
		member.setMember_number(user_num[0]);
		System.out.println(user_num[0]);
		return dao.insert(member);
	}

	public MemberDTO selectOne(MemberDTO member) {
//		member.setMember_password(getHash(member.getMember_password()));
		return dao.selectOne(member);
	}
	
	public MemberDTO selectOne2(MemberDTO member) {
//		member.setMember_password(getHash(member.getMember_password()));
		return dao.selectOne2(member);
	}
		

	public int selectOne3(MemberDTO dto) {
//		member.setMember_password(getHash(member.getMember_password()));
		return dao.selectOne3(dto);
	}

	
	public MemberDTO selectOne4(String member_number) {
		return dao.selectOne4(member_number);
	}

	public int select(String member_email) {
		return dao.select(member_email);
	}
	
	public int selectNick(String member_nick) {
		return dao.selectNick(member_nick);
	}



	public MemberDTO doubleCheck(MemberDTO member) {
//		member.setMember_password(getHash(member.getMember_password()));
		return dao.doubleCheck(member);
	}



	public int modify(MemberDTO member) {
//		member.setMember_password(getHash(member.getMember_password()));
		return dao.modify(member);
	}



	public MemberDTO findId(MemberDTO member) {
		return dao.findId(member);
	}



	public MemberDTO findPw(MemberDTO member) {
		return dao.findPw(member);
	}



	public int updatePw(MemberDTO member) {
		return dao.updatePw(member);
	}



	public int deleteMember(MemberDTO member) {
//		member.setMember_password(getHash(member.getMember_password()));
		return dao.deleteMember(member);
	}



	public int memberCount() {
		return dao.memberCount();
	}



	public List<MemberDTO> customerDateList(Paging paging, HashMap<String, Object> param) {
		param.put("offset", paging.getOffset());
		param.put("perPage",paging.getPerPage());
		return dao.customerDateList(param);
	}



	public List<MemberDTO> customerGradeList(Paging paging, HashMap<String, Object> param) {
		param.put("offset", paging.getOffset());
		param.put("perPage",paging.getPerPage());
		return dao.customerGradeList(param);
	}



	public List<MemberDTO> customerThisList(Paging paging, HashMap<String, Object> param) {
		param.put("offset", paging.getOffset());
		param.put("perPage",paging.getPerPage());
		return dao.customerThisList(param);
	}



	public List<MemberDTO> customerLastList(Paging paging, HashMap<String, Object> param) {
		param.put("offset", paging.getOffset());
		param.put("perPage",paging.getPerPage());
		return dao.customerLastList(param);
	}






}
