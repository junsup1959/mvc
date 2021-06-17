package com.itbank.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itbank.admin_board.Paging;
import com.itbank.admin_board.boardDTO;
import com.itbank.service.BoardSerivce;

@Controller
@RequestMapping("/event")
public class EventController {

	private ObjectMapper mapper = new ObjectMapper();
	@Autowired private BoardSerivce bs;
	@GetMapping("")
	public ModelAndView event(@RequestParam HashMap<String, Object>param, int page) {
		ModelAndView mav= new ModelAndView("event/event");
		int boardCount =  bs.boardCount();
		Paging paging = new Paging(page, boardCount);
		List<boardDTO>list=bs.list(paging, param);
		mav.addObject("list", list);
		mav.addObject("paging",paging);
		
		return mav;
	}
	
	@GetMapping(value = "/read/{number}",produces = "application/json; charset=utf-8")
	@ResponseBody
	public String read(@PathVariable int number) throws JsonProcessingException {
	  String json = null;
	  boardDTO dto= bs.selectOne(number);
	  json = mapper.writeValueAsString(dto);
	  return json;
	}
	@GetMapping(value = "/read/prev/{number}",produces = "application/json; charset=utf-8")
	@ResponseBody
	public String prev(@PathVariable int number) throws JsonProcessingException {
		  String json = null;
		  boardDTO pre= bs.prev(number);
		  int prev = pre.getBoard_prev();
		  if(prev != 0) {
		  boardDTO dto = bs.selectOne(prev);
			  json = mapper.writeValueAsString(dto);
		  }
		  return json;
	}

	@GetMapping(value = "/read/next/{number}",produces = "application/json; charset=utf-8")
	@ResponseBody
	public String next(@PathVariable int number) throws JsonProcessingException {
		
		
		  String json = null;
		  boardDTO nex= bs.next(number);
		  int next = nex.getBoard_next();
		  if(next != 0) {
		  boardDTO dto = bs.selectOne(next);
			  json = mapper.writeValueAsString(dto);
		  }
		  return json;
		}
}
