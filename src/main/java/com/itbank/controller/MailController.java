package com.itbank.controller;


import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Scanner;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.itbank.member.MemberDTO;
import com.itbank.service.MailService;

@RestController
@RequestMapping("/admin")
public class MailController {

	@Autowired private MailService mailService;
	
	@GetMapping(value = "/customer/mailList", produces = "application/text; charset=utf-8")
	public String mail(String title,String textBody,String listType , HttpSession session) throws IOException {
		
		System.out.println(title);
		System.out.println(listType);
		System.out.println(textBody);
		// 지정한 파일에 기록된 계정 정보를 문자열 형태로 불러오기
		String filePath = session.getServletContext().getRealPath("WEB-INF/data/mailAccount.dat");
		File f = new File(filePath);
		if(f.exists() == false) {
			return "메일 전송에 필요한 계정 정보를 찾을 수 없습니다.";
		}
		Scanner sc = new Scanner(f);
		String account = null;
		while(sc.hasNextLine()) {
			account = sc.nextLine();
		}
		sc.close();
		
		List<MemberDTO> customerList = mailService.emailList(listType);
		Iterator<MemberDTO> li= customerList.iterator();
		MemberDTO dto = null;
		while(li.hasNext()) {
			dto = li.next();
			System.out.println(dto.getMember_email());
			mailService.sendMail(account, dto.getMember_email() ,title,textBody,listType);
		}
		
		return "메일을 성공적으로 전송하였습니다.";
	}
	
	
}
