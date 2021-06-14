package com.itbank.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itbank.member.MemberDTO;
import com.itbank.service.MemberService;

@RestController
@RequestMapping("/member")
public class AjaxController {

	@Autowired MemberService ms;
	private ObjectMapper mapper = new ObjectMapper();

	
	@GetMapping(value = "/{member_email}/", produces = "application/json; charset=utf-8")
	public String member(@PathVariable String member_email) throws JsonProcessingException{
		System.out.println("emial check : " + member_email ) ;
		int row = ms.select(member_email);
		return row +"";
	}
	
	@GetMapping(value = "/nick/{member_nick}", produces = "application/json; charset=utf-8")
	public String memberNick(@PathVariable String member_nick) throws JsonProcessingException{
		System.out.println("nick check : " + member_nick ) ;
		int row = ms.selectNick(member_nick);
		return row +"";
	}
}
