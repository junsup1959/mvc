package com.itbank.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
	public ModelAndView reviewBoard(@RequestParam int moviecode,String title) throws IOException {
		//리뷰 서비스에 select(moviecode,title)로 리뷰 보드 LIST 불러오고 model에 추가.
		//리뷰 페이징 처리 필요(paging 클래스 불러오기+ 파라미터 page 추가)
		
		ModelAndView mav = new ModelAndView("movie/review/review");
		JsonNode response = mapper.readTree(rs.movieSearch(title));
		Iterator<JsonNode> it = response.get("items").iterator();
		while(it.hasNext()) {
			MovieJson movie=new MovieJson(it.next());
			if(movie.getMoviecode()==String.valueOf(moviecode))
				System.out.println(it.next().toString());
				mav.addObject("movie", movie);
		}
		return mav;
	}
	@PostMapping("/board")
	public String insertReview(@RequestParam int moviecode,String title) throws UnsupportedEncodingException {
		String etitle= URLEncoder.encode(title, "UTF-8");//파라미터 리뷰 DTO 추가
		//리뷰 서비스에-> 리뷰 보드 insert로 만들기
		//리뷰 수정->ajax로 처리? or java 처리? 둘중 택일.
		//리뷰 삭제는 redirect로 충분 (컨트롤러 주소 추가)
		
		return "redirect:/movie/review/board?moviecode="+moviecode+"&title="+etitle;
	}
	
	@GetMapping(value = "/autoSearch/",produces = "application/json; charset=utf-8")
	@ResponseBody
	public String autoSeach(@RequestParam String query) throws IOException {
	
		String response = rs.movieSearch(query);
		String json = mapper.writeValueAsString(response);
		
		return json;
	}	
}
