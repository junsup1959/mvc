package com.itbank.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itbank.review.MovieJson;
import com.itbank.service.ReviewService;

@Controller
@RequestMapping("movie/review")
public class ReivewController {

	@Autowired private ReviewService rs;
	ObjectMapper mapper = new ObjectMapper();
	
	@GetMapping("")
	public ModelAndView review() {
		ModelAndView mav = new ModelAndView("movie/review/reviewList");
		return mav;
	}
	@GetMapping("/result")
	public ModelAndView result(@RequestParam String query) throws IOException{
		ModelAndView mav = new ModelAndView("movie/review/result");
		
		JsonNode response = mapper.readTree(rs.movieSearch(query));
		Iterator<JsonNode> it = response.get("items").iterator();
		
		List<MovieJson>list = new ArrayList<>();
		
		while(it.hasNext()) {
			MovieJson moive=new MovieJson(it.next());
			list.add(moive);
		}
		mav.addObject("list",list);
		return mav;
	}
	@GetMapping("/board")
	public ModelAndView reviewBoard(@RequestParam int moviecode) {
		ModelAndView mav = new ModelAndView("movie/review/review");
		
		return mav;
	}
	
	@GetMapping(value = "/autoSearch/",produces = "application/json; charset=utf-8")
	@ResponseBody
	public String autoSeach(@RequestParam String query) throws IOException {
	
		String response = rs.autoSearch(query);
		String json = mapper.writeValueAsString(response);
		
		return json;
	}
}
