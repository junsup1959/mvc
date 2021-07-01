package com.itbank.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itbank.member.MemberDTO;
import com.itbank.service.MemberService;

@RestController
@RequestMapping("/member")
public class AjaxController {

	@Autowired MemberService ms;

	
	@PostMapping("/modifyPw")
	@ResponseBody
	public String modifyPw(HttpSession session, MemberDTO dto) {
		MemberDTO member = (MemberDTO) session.getAttribute("login");
		member.setMember_password(dto.getMember_password());
		int row = ms.modifyPw(member);
		if(session != null) {
			session.invalidate();
		}
		return row + "";
	}
	
	@PostMapping("/checkPw")
	@ResponseBody
	public String checkPw(MemberDTO dto) {
		int row = ms.selectOne3(dto);
		return row + "";
	}
	
	@PostMapping("/checkLogin")
	@ResponseBody
	public String member(MemberDTO dto) {
		int row = ms.selectOne3(dto);
		return row + "";
	}
	
	
	@GetMapping(value = "/checkId/{member_email}/", produces = "application/json; charset=utf-8")
	public String member(@PathVariable String member_email) throws JsonProcessingException{
		int row = ms.select(member_email);
		System.out.println(member_email);
		return row +"";
	}
	
	@GetMapping(value = "/nick/{member_nick}", produces = "application/json; charset=utf-8")
	public String memberNick(@PathVariable String member_nick) throws JsonProcessingException{
		int row = ms.selectNick(member_nick);
		return row +"";
	}
}
