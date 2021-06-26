package com.itbank.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itbank.admin_board.Board_likeDTO;
import com.itbank.admin_board.Paging;
import com.itbank.admin_board.boardDTO;
import com.itbank.member.MemberDTO;
import com.itbank.service.BoardSerivce;

@Controller

public class EventController {

	
	@Autowired private BoardSerivce bs;
	
	private ObjectMapper mapper = new ObjectMapper();
	
	@GetMapping("/event")
	public ModelAndView event(@RequestParam HashMap<String, Object>param, int page) {
		int perPage = 100;
		ModelAndView mav= new ModelAndView("event/event");
		int boardCount =  bs.boardCount(param);
		Paging paging = new Paging(page, boardCount,perPage);
		List<boardDTO>list=bs.list(paging,param);
		mav.addObject("list", list);
		mav.addObject("paging",paging);
		
		return mav;
	}
	
	@GetMapping (value = "/event/read/like/{number}")
	@ResponseBody
	public String like(@PathVariable int number) {
		int count = bs.blcount(number);
		return count+"";
	}
		
	@GetMapping (value = "/event/read/already/")
	@ResponseBody
	public String like(@RequestParam int board_number,String user_email) {
		Board_likeDTO like = new Board_likeDTO();
		like.setBoard_number(board_number);
		like.setUser_email(user_email);
		int lcount = bs.blselectOne(like);
		
		if(lcount != 0 )
			return 1+"";
		return 0+"";
	}
	
	
	
	@GetMapping(value = "/event/read/{number}",produces = "application/json; charset=utf-8")
	@ResponseBody
	public String read(@PathVariable int number) throws JsonProcessingException {
	  String json = null;
	  boardDTO dto= bs.selectOne(number);
	  json = mapper.writeValueAsString(dto);
	  return json;
	}
	
	@GetMapping(value = "/event/read/prev/{number}",produces = "application/json; charset=utf-8")
	@ResponseBody
	public String prev(@PathVariable int number,@RequestParam HashMap<String, Object> param) throws JsonProcessingException {
		  String json = null;
		  boardDTO pre= bs.prev(number,param);
		  int prev = pre.getBoard_prev();
		  boardDTO dto = bs.selectOne(prev);
		  json = mapper.writeValueAsString(dto);
		  return json;
	}

	@GetMapping(value = "/event/read/next/{number}",produces = "application/json; charset=utf-8")
	@ResponseBody
	public String next(@PathVariable int number,@RequestParam HashMap<String, Object> param) throws JsonProcessingException {
		
		  String json = null;
		  boardDTO nex= bs.next(number,param);
		  int next = nex.getBoard_next();
		  boardDTO dto = bs.selectOne(next);
		  json = mapper.writeValueAsString(dto);
		  return json;
	}
	
	@GetMapping("/notice")
	public ModelAndView notice(@RequestParam HashMap<String, Object>param, int page) {
		int perPage=10;
		ModelAndView mav=new ModelAndView("/event/notice");
		int boardCount =  bs.boardCount(param);
		Paging paging = new Paging(page, boardCount,perPage);
		List<boardDTO>list=bs.list(paging, param);
		mav.addObject("list", list);
		mav.addObject("paging",paging);
		return mav;
	}
	
	@GetMapping("notice/{board_number}")
	public ModelAndView notice(@PathVariable int board_number,HttpSession session,@RequestParam HashMap<String, Object>param) {
		ModelAndView mav = new ModelAndView("/event/read");
		
		int flag = 1;
		int count = bs.blcount(board_number);
		boardDTO dto=bs.selectOne(board_number);
		MemberDTO login = (MemberDTO) session.getAttribute("login");	
		if(login != null ) {
			Board_likeDTO lg = new Board_likeDTO();
			lg.setBoard_number(board_number);		
			lg.setUser_email(login.getMember_email());
			mav.addObject("dto", dto);
			mav.addObject("blcount",count);
			if(bs.blselectOne(lg) == 0) {
				mav.addObject("check",flag);
				return mav;
			}
		}
		flag = 0;
		
		boardDTO next = bs.next(board_number, param);
		boardDTO prev = bs.prev(board_number, param);
		
		if(next.getBoard_next()!=0) {
			next = bs.selectOne(next.getBoard_next());
			mav.addObject("next", next);
		}
		if(prev.getBoard_prev()!=0) {
			prev =bs.selectOne(prev.getBoard_prev());
			mav.addObject("prev", prev);
			
		}
		mav.addObject("dto", dto);
		mav.addObject("check",flag);
		mav.addObject("blcount",count);
		return mav;
	}
	
	@GetMapping("/event/last")
	public ModelAndView last(@RequestParam HashMap<String, Object> param, int page) {
		int perPage = 100;
		ModelAndView mav= new ModelAndView("event/event");
		int boardCount =  bs.boardCount(param);
		Paging paging = new Paging(page, boardCount,perPage);
		List<boardDTO>list=bs.list(paging,param);
		mav.addObject("list", list);
		mav.addObject("paging",paging);
		
		return mav;
	}
	@PostMapping(value = "/event/like/",consumes = "application/json; charset=utf-8")
	@ResponseBody
	public String inputLikey(@RequestBody Board_likeDTO dto) {
		String result = null;
		int row =bs.BLinsert(dto);
		if(row == 1) {
			int BLcount = bs.blcount(dto.getBoard_number());
			result = Integer.toString(BLcount);
			return result; 
		}else {
			return "n";
		}
	}
	
	@DeleteMapping(value = "/event/like/",consumes = "application/json; charset=utf-8")
	@ResponseBody
	public String delLikey(@RequestBody Board_likeDTO dto) {
		String result = null;
		int row =bs.BLdelete(dto);
		if(row == 1) {
			int BLcount = bs.blcount(dto.getBoard_number());
			result = Integer.toString(BLcount);
			return result; 
		}else {
			return "n";
		}
	}
	
	@GetMapping("/event/qna")
	public void qna() {}
}

