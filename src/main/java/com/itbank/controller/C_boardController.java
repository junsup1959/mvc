package com.itbank.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
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
import org.springframework.web.servlet.ModelAndView;

import com.itbank.admin_board.CoboardDTO;
import com.itbank.admin_board.Paging;
import com.itbank.service.BoardSerivce;

@Controller

@RequestMapping("/admin/c_board")
public class C_boardController {
	
	@Autowired private BoardSerivce bs;
	private final int perPage =10;
	
	@GetMapping({"","/"})
	public ModelAndView board(@RequestParam HashMap<String, Object> param, int page) {
		ModelAndView mav= new ModelAndView("admin/c_board/boardList");
		int baordCount = bs.cboardCount();
		Paging paging = new Paging(page, baordCount,perPage);
		
		List<CoboardDTO> list=bs.clist(paging,param);
		mav.addObject("list", list);
		mav.addObject("paging", paging);
		return mav;
	}
	
	@GetMapping("read/{co_idx}")
	public ModelAndView read(@PathVariable int co_idx) {
		ModelAndView mav= new ModelAndView("admin/c_board/read");
		CoboardDTO dto=bs.cselectOne(co_idx);
		CoboardDTO np=bs.cnext(co_idx);
		System.out.println();
		dto.setCo_next(np.getCo_next());
		np=bs.cprev(co_idx);
		System.out.println(np);
		dto.setCo_prev(np.getCo_prev());
		
		
		mav.addObject("dto",dto);
		
		if(dto.getCo_next()!=0) {
			CoboardDTO next = bs.cselectOne(dto.getCo_next());
			mav.addObject("next", next);
		}
		System.out.println(dto.getCo_prev());
		if(dto.getCo_prev()!=0) {
			CoboardDTO prev = bs.cselectOne(dto.getCo_prev());
			mav.addObject("prev", prev);
		}
		return mav;
	}
	@GetMapping("update/{co_idx}")
	public ModelAndView update(@PathVariable int co_idx) {
		
		ModelAndView mav= new ModelAndView("admin/c_board/update");
		CoboardDTO dto = bs.cselectOne(co_idx);
		mav.addObject("dto",dto);
		return mav;
	}
	@PostMapping("update/{co_idx}")
	public String update(CoboardDTO dto,@RequestParam String search,String keyword,int page) throws UnsupportedEncodingException {
		String word = URLEncoder.encode(keyword, "UTF-8");
		int row = bs.cupdate(dto);
		return "redirect:/admin/c_board/read/"+dto.getCo_idx()+"?search="+search+"&keyword="+keyword+"&page="+page;
	}
	
	//'${cpath}/admin/c_board/delete/${dto.co_idx}?search=${param.search }&keyword=${param.keyword }&page=${param.page}'
	@GetMapping("delete/{co_idx}")
	public String delete(@PathVariable int co_idx,HttpSession session,@RequestParam String search,String keyword,int page) throws UnsupportedEncodingException {
		String word = URLEncoder.encode(keyword, "UTF-8");
		
		int row =bs.cdelete(co_idx,session);
		System.out.println(row);
		return "redirect:/admin/c_board/?search="+search+"&keyword="+keyword+"&page="+page;
	}
	
	@GetMapping("write")
	public String write() {
		return "admin/c_board/write";
	}
	
	@PostMapping("write")
	public String write(CoboardDTO dto,@RequestParam String search,String keyword,int page) throws UnsupportedEncodingException {
		
		String word = URLEncoder.encode(keyword, "UTF-8");
		int row =bs.cinsert(dto);
		
		return "redirect:/admin/c_board/?search="+search+"&keyword="+keyword+"&page=1";
	}

	
}