package com.itbank.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.member.MemberDTO;
import com.itbank.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired MemberService ms;
	
	
	
	@GetMapping("/membership")
	public void membership() {}
	
	@PostMapping("/deleteMember")
	public ModelAndView deleteMember(MemberDTO member, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String[] member_email2 = member.getMember_email().toString().split(",");
		member.setMember_email(member_email2[0]);
		int row = ms.deleteMember(member);
		if(row == 1) {
			mav.addObject("msg", "회원 탈퇴가 성공적으로 이루어졌습니다.");
			session.invalidate();
			return mav;
		}
		mav.addObject("msg", "회원 탈퇴를 실패하였습니다.\n관리자에게 문의하세요.");
		return mav;
	}
	
	
	@GetMapping("/deleteMember")
	public void deleteMember() {}
	
	
	@GetMapping("/findPwResult")
	public void findPwResult() {}
	
	@PostMapping("/findPwAlert")
	public ModelAndView findPwAlert(MemberDTO member) {
		ModelAndView mav = new ModelAndView("redirect:/member/findPwAlert");
		System.out.println(member.getMember_email());
		System.out.println(member.getMember_password());
		int findPwResult = ms.updatePw(member);
		if(findPwResult == 1) {
			mav.setViewName("member/findPwAlert");
			mav.addObject("findPwResult", findPwResult);
			return mav;
		}
		mav.addObject("msg", "비밀번호 변경을 실패했습니다.");
		return mav;
	}
	
	@GetMapping("/findPwAlert")
	public void findPwAlert() {}
	
	@GetMapping("/findPw")
	public void findPw() {}
	
	
	@PostMapping("/findPw")
	public ModelAndView findPw(MemberDTO member) {
		ModelAndView mav = new ModelAndView();
		
		MemberDTO findPw = ms.findPw(member);
		mav.setViewName("member/findPw");
		if(findPw != null) {
			mav.addObject("findPw", findPw);
			return mav;
		}
		mav.addObject("msg", "일치하는 정보가 없습니다.");
		
		return mav;
	}

	@PostMapping("/findId")
	public ModelAndView findId(MemberDTO member) {
		ModelAndView mav = new ModelAndView();
		
		MemberDTO findId = ms.findId(member);
		if(findId != null) {
			mav.addObject("id", findId.getMember_email());
			mav.setViewName("member/findIdResult");
			return mav;
		}
		mav.addObject("msg", "일치하는 정보가 없습니다.");
		mav.setViewName("member/findId");
		
		return mav;
	}
	
	@GetMapping("/findId")
	public void findId() {}
	
	
	
	@GetMapping("/modify")
	public void modify() {}
	
	
	@PostMapping("/modify")
	public ModelAndView modify(MemberDTO member, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		int row = ms.modify(member);
		if(row == 1) {
			mav.addObject("msg", "회원정보를 수정하였습니다. 다시 로그인 해주세요.");
			mav.setViewName("redirect:/member/login");
			session.invalidate();
			return mav;
		}
		mav.addObject("msg", "회원정보 수정을 실패하였습니다. 다시 시도해주세요.");
		mav.setViewName("redirect:/member/modify");
		return mav;
	}
	
	@GetMapping("/mypage")
	public void mypage() {}
	
	
	@PostMapping("/mypage")
	public ModelAndView mypage(MemberDTO member, HttpSession modify) {
		ModelAndView mav = new ModelAndView();
		System.out.println(member.getMember_email());
		MemberDTO dto = ms.doubleCheck(member);
		if(dto != null) {
			String[] addr = dto.getMember_addr().toString().split(",");
			dto.setMember_addr1(addr[0]);
			dto.setMember_addr2(addr[1]);
			modify.setAttribute("modify", dto);
			mav.setViewName("redirect:/member/modify");
			return mav;
			// 인터셉터로 다른페이지가 뜰때 modify 라는 session 이 존재하면 removeAttribute("modify") 로 삭제하고 뷰를 띄어준다.
		}
		mav.addObject("msg", "잘못된 비밀번호입니다.");
		mav.setViewName("message");
		return mav;
	}
	
	
	
	// 주소 API 처리
	@RequestMapping(value = "/addrPopup", method = {RequestMethod.GET, RequestMethod.POST})
	public void addrPopup() {}
	
	
	@GetMapping("/addr")
	public void addr() {}
	
	
	@GetMapping("/login")
	public void login() {}
	
	@PostMapping("/login")
	public ModelAndView login(MemberDTO member, HttpSession session) {
		
		MemberDTO login = ms.selectOne(member);
		ModelAndView mav = new ModelAndView();
		if(login != null) {
			mav.setViewName("home");
			session.setAttribute("login", login);
			session.setMaxInactiveInterval(60*60*3);
			return mav;
			
		}
		mav.setViewName("member/login");
		return mav;
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "home";
	}
	
	
	@GetMapping("/join")
	public void join() {}
	
	
	@PostMapping("/join")
	public ModelAndView join(MemberDTO member) {
		ModelAndView mav = new ModelAndView("member/join_complete");
		int row = ms.insert(member);
		if(row == 1) {
			mav.addObject("member", member);
			return mav;
		}
		mav.setViewName("member/join");
		return mav;	
	}
	


	
	
}
