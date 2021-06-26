package com.itbank.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.admin_board.boardDTO;
import com.itbank.service.BoardSerivce;

@Controller
public class HomeController {
	@Autowired private BoardSerivce bs;
	
	@GetMapping({"","/"})
	public ModelAndView home() {
		ModelAndView mav = new ModelAndView("home");
		// 공지사항 
		List<boardDTO> notice = bs.homeNotice();
		mav.addObject("notice", notice);
		
		//이벤트
		List<boardDTO> event = bs.homeEvent();
		mav.addObject("event", event);
		return mav;
	}
}
