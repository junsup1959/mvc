package com.itbank.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.cinema.CinemaDTO;
import com.itbank.cinema.Theater_infoDTO;
import com.itbank.service.CinemaService;

@Controller
@RequestMapping("/admin/cinema")
public class CinemaController {

	@Autowired CinemaService cs;
	
	@ResponseBody
	@PostMapping("/cinema")
	public String createScreen(CinemaDTO cinema) {
		String ran =  UUID.randomUUID().toString().split("-")[1];
		cinema.setBranch_code(cinema.getBranch() + ran);
		if(cs.getBranch(cinema.getBranch())) {
			cinema.setBranch_code(cs.getBranchCode(cinema.getBranch()));
		}
		int row = cs.insertCinema(cinema);
		return row + "";
	}
	
	
	@GetMapping("/cinema")
	public ModelAndView cinema() {
		ModelAndView mav = new ModelAndView();
		List<CinemaDTO> cinemaList = cs.selectAllCinema();
		mav.addObject("cinemaList", cinemaList);
		
		return mav;
	}
	
	
	@ResponseBody
	@GetMapping(value = "/screenCodes/{branch}", produces = "application/json; charset=utf-8")
	public List<String> addCinema(@PathVariable String branch) {
		List<CinemaDTO> cinemaList = cs.selectAllScreen(branch);
		List<String> screenList = new ArrayList<String>();
		for(int i=0; i < cinemaList.size(); i++) {
//			System.out.println(cinemaList.get(i).getScreen_code());
			screenList.add(i, cinemaList.get(i).getScreen_code());
		}
		return screenList;
	}
	
//	@ResponseBody
//	@DeleteMapping(value = "/{screen_code}", produces = "application/json; charset=utf-8")
//	public int deleteScreen(@PathVariable String screen_code) {
//		int row = cs.deleteScreen(screen_code);
//		
//		return row;
//	}
	
	@ResponseBody
	@PostMapping("/insertTheaterInfo")
	public String insertTheater_info(Theater_infoDTO info) {
		String startTime = info.getStart_time();
		startTime = startTime.replace(":", "");
		info.setStart_time(startTime);
		System.out.println(info.getRuntime());
		int hour = (info.getRuntime()/60); 
		System.out.println("hour : "+hour);
		int minute = (info.getRuntime()%60);
		System.out.println("minute : "+ minute);
		String runTime = Integer.toString(hour) + Integer.toString(minute);
		System.out.println(runTime);
		info.setRuntime(Integer.parseInt(runTime));
		
		
		int row = cs.insertTheater_info(info);
		
		System.out.println("row : "+row);
		return row + "";
	}
	
	@ResponseBody
	@GetMapping(value = "/getScreenCodes/{screenName}", produces = "application/json; charset=utf-8")
	public List<Theater_infoDTO> screenList(@PathVariable String screenName) {
		System.out.println(screenName);
		List<Theater_infoDTO> screenCodes = cs.screenCodes(screenName);
		List<String> screenList = new ArrayList<String>();
		for(int i=0; i < screenCodes.size(); i++) {
//			System.out.println(screenCodes.get(i).get);
//			screenList.add(i, screenCodes.get(i).getScreen_code());
		}
		return screenCodes;
	}
	
	
}
