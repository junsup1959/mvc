package com.itbank.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.admin_board.CoboardDTO;
import com.itbank.admin_board.Paging;
import com.itbank.admin_board.boardDTO;
import com.itbank.service.BoardSerivce;

@Controller

@RequestMapping("/admin/c_board")
public class C_boardController {
	
	@Autowired private BoardSerivce bs;
	
	@GetMapping({"","/"})
	public ModelAndView board(@RequestParam HashMap<String, Object> param, int page) {
		ModelAndView mav= new ModelAndView("admin/c_board/boardList");
		int baordCount = bs.cboardCount();
		Paging paging = new Paging(page, baordCount);
		
		List<CoboardDTO> list=bs.clist(paging,param);
		mav.addObject("list", list);
		mav.addObject("paging", paging);
		return mav;
	}
	
	@GetMapping("read/{board_number}")
	public ModelAndView read(@PathVariable int board_number) {
		ModelAndView mav= new ModelAndView("admin/c_board/read");
		CoboardDTO dto=bs.cselectOne(board_number);
		CoboardDTO np=bs.cnext(board_number);
		dto.setBoard_next(np.getCo_next());
		np=bs.cprev(board_number);
		dto.setCo_prev(np.getCo_prev());
		
		
		mav.addObject("dto",dto);
		
		if(dto.getCo_next()!=0) {
			boardDTO next = bs.selectOne(dto.getCo_next());
			mav.addObject("next", next);
		}
		if(dto.getCo_prev()!=0) {
			boardDTO prev = bs.selectOne(dto.getCo_prev());
			mav.addObject("prev", prev);
		}
		return mav;
	}
	@GetMapping("update/{board_number}")
	public ModelAndView update(@PathVariable int board_number) {
		
		ModelAndView mav= new ModelAndView("admin/c_board/update");
		CoboardDTO dto = bs.cselectOne(board_number);
		mav.addObject("dto",dto);
		return mav;
	}

	
}