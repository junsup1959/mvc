package com.itbank.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.admin_board.boardDTO;
import com.itbank.admin_member.Admin_memberDTO;
import com.itbank.service.AdminService;
import com.itbank.service.BoardSerivce;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired private AdminService as;
	@Autowired private BoardSerivce bs;
	
	@GetMapping({"", "/"})
	public String admin(HttpSession session) {
		return "admin/admin_main";
	}
	
	@GetMapping("/login")
	public String login() {
		return "admin/admin_login";
	}
	
	@PostMapping("/login")
	public ModelAndView login(Admin_memberDTO dto, HttpSession session) {
	
		
		String viewName = "redirect:/admin";
		System.out.println("사원번호 : " + dto.getAdmin_num());
		System.out.println("비밀번호 : " + dto.getAdmin_password());
		Admin_memberDTO ad_login = as.login(dto);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName(ad_login != null ? viewName : "msg");
		
		if(ad_login == null) {
			mav.addObject("msg", "로그인 실패");
		}
		
		session.setAttribute("ad_login", ad_login );
		session.setMaxInactiveInterval(60*60);
		return mav;
	}	
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/admin";
	}
	
	@GetMapping("/adminMypage")
	public ModelAndView mypage(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if(session.getAttribute("ad_login") == null) {
			mav.setViewName("msg");
			mav.addObject("msg","잘못된 접근입니다");
		}
		
		return mav;
	}
	
	@GetMapping("/admin_member")
	public ModelAndView admin_member() {
		ModelAndView mav=new ModelAndView("admin/admin_member/admin_member");
		List<Admin_memberDTO>list=as.selectAll();
		mav.addObject("list", list);
		return mav;
	}
	
	@GetMapping("/admin_member/insert")
	public String admin_minsert() {
		return "admin/admin_member/admin_member_insert";
	}
	@PostMapping("/admin_member/insert")
	public String admin_minsert(Admin_memberDTO dto) {
	
		int row =as.insert(dto);
		System.out.println(row);
		return "redirect:/admin/admin_member";
	}

	

	//////////////////////////////////////////////////////////////
	// -----------------------board-------------------------
	
	
	
	
	@GetMapping("/board")
	public ModelAndView board() {
		ModelAndView mav= new ModelAndView("admin/board/boardList");
		List<boardDTO>list= bs.boardAll();
		mav.addObject("list", list);
		return mav;
	}
	@GetMapping("/board/read/{board_number}")
	public ModelAndView read(@PathVariable int board_number) {
		ModelAndView mav= new ModelAndView("admin/board/read");
		boardDTO dto=bs.selectOne(board_number);
		mav.addObject("dto",dto);
		
		return mav;
	}
	
	@GetMapping("/board/write")
	public String write() {
		return "admin/board/write";

	}
	
	@PostMapping("/board/write")
	public String board(boardDTO dto) {
	System.out.println(dto.getFile());
		int row=bs.insert(dto);
	return "redirect:/admin/board";
	}
	
	@GetMapping("/board/update/{board_number}")
	public ModelAndView update(@PathVariable int board_number) {
		
		ModelAndView mav= new ModelAndView("admin/board/update");
		boardDTO dto=bs.selectOne(board_number);
		mav.addObject("dto",dto);
		
		return mav;
	}
	@PostMapping("/board/update/{board_number}")
	public String update1(boardDTO dto) {
		int row =bs.update(dto);
		
		return "redirect:/admin/board/read/"+dto.getBoard_number();
	}
	
	
	@GetMapping("/board/delete/{board_number}")
	public String delete(@PathVariable int board_number) {
	
		return "redirect:/admin/board";
	}
}
