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

import com.itbank.admin_board.Paging;
import com.itbank.admin_board.boardDTO;

@Controller
@RequestMapping("/admin/c_board")
public class C_boardController {

	@Autowired
	
	@GetMapping({"","/"})
	public ModelAndView board(@RequestParam HashMap<String, Object> param, int page) {
		ModelAndView mav= new ModelAndView("admin/c_board/boardList");
//		int baordCount = bs.boardCount();
//		Paging paging = new Paging(page, baordCount);
//		
//		List<boardDTO> list=bs.list(paging,param);
//		mav.addObject("list", list);
//		mav.addObject("paging", paging);
		return mav;
	}
	@GetMapping("/read/{board_number}")
	public ModelAndView read(@PathVariable int board_number) {
		ModelAndView mav= new ModelAndView("admin/c_board/read");
//		boardDTO dto=bs.selectOne(board_number);
//		boardDTO np=bs.next(board_number);
//		dto.setBoard_next(np.getBoard_next());
//		np=bs.prev(board_number);
//		dto.setBoard_prev(np.getBoard_prev());
//		
//		
//		mav.addObject("dto",dto);
//		
//		if(dto.getBoard_next()!=0) {
//			boardDTO next = bs.selectOne(dto.getBoard_next());
//			mav.addObject("next", next);
//		}
//		if(dto.getBoard_prev()!=0) {
//			boardDTO prev = bs.selectOne(dto.getBoard_prev());
//			mav.addObject("prev", prev);
//		}
		return mav;
	}
	
	@GetMapping("/write")
	public String write() {
		return "admin/c_board/write";

	}
	
	@PostMapping("/write")
	public String board(boardDTO dto,@RequestParam String search,String keyword,int page) throws UnsupportedEncodingException {
//		int row=bs.insert(dto);
		String word= URLEncoder.encode(keyword, "UTF-8");
		
	return "redirect:/admin/c_board?search="+search+"&keyword="+word+"&page="+page;
	}
	
	@GetMapping("/update/{board_number}")
	public ModelAndView update(@PathVariable int board_number) {
		
		ModelAndView mav= new ModelAndView("admin/c_board/update");
		
		
//		mav.addObject("dto",dto);
		
		return mav;
	}
	@PostMapping("/update/{board_number}")
	public String update(boardDTO dto,@RequestParam String search,String keyword,int page) throws UnsupportedEncodingException {
		String word= URLEncoder.encode(keyword, "UTF-8");
		
		
		return "redirect:/admin/c_board/read/"+dto.getBoard_number()+"?search="+search+"&keyword="+word+"&page="+page;
	}
	
	
	@GetMapping("/delete/{board_number}")
	public String delete(@PathVariable int board_number,@RequestParam String search,String keyword,int page) throws UnsupportedEncodingException {
		String word= URLEncoder.encode(keyword, "UTF-8");
		
		return "redirect:/admin/c_board?search="+search+"&keyword="+word+"&page="+page;
	}
	
}
