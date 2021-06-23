package com.itbank.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itbank.admin_board.Paging;
import com.itbank.admin_board.boardDTO;
import com.itbank.service.BoardSerivce;

@Controller

public class EventController {

	private ObjectMapper mapper = new ObjectMapper();
	@Autowired private BoardSerivce bs;
	@GetMapping("/event")
	public ModelAndView event(@RequestParam HashMap<String, Object>param, int page) {
		ModelAndView mav= new ModelAndView("event/event");
		int boardCount =  bs.boardCount(param);
		Paging paging = new Paging(page, boardCount);
		List<boardDTO>list=bs.list(paging,param);
		mav.addObject("list", list);
		mav.addObject("paging",paging);
		
		return mav;
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
		  System.out.println(param);
		  boardDTO pre= bs.prev(number,param);
		  int prev = pre.getBoard_prev();
		  boardDTO dto = bs.selectOne(prev);
		  json = mapper.writeValueAsString(dto);
		  return json;
	}

	@GetMapping(value = "/event/read/next/{number}",produces = "application/json; charset=utf-8")
	@ResponseBody
	public String next(@PathVariable int number,@RequestParam HashMap<String, Object> param) throws JsonProcessingException {
		
		System.out.println(param);
		  String json = null;
		  boardDTO nex= bs.next(number,param);
		  int next = nex.getBoard_next();
		  boardDTO dto = bs.selectOne(next);
		  json = mapper.writeValueAsString(dto);
		  return json;
		}
	@GetMapping("/notice")
	public ModelAndView notice(@RequestParam HashMap<String, Object>param, int page) {
		ModelAndView mav=new ModelAndView("/event/notice");
		int boardCount =  bs.boardCount(param);
		Paging paging = new Paging(page, boardCount);
		List<boardDTO>list=bs.list(paging, param);
		mav.addObject("list", list);
		mav.addObject("paging",paging);
		return mav;
	}
	@GetMapping("notice/{board_number}")
	public ModelAndView notice(@PathVariable int board_number) {
		ModelAndView mav = new ModelAndView("/event/read");
		boardDTO dto=bs.selectOne(board_number);
		mav.addObject("dto", dto);
		return mav;
	}
	
}
