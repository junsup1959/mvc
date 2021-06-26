package com.itbank.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.cinema.CinemaDTO;
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

	@GetMapping("/addCinema")
	public void addCinema() {}
	
	
	@ResponseBody
	@GetMapping(value = "/screenCodes/{branch}", produces = "application/json; charset=utf-8")
	public List<String> addCinema(@PathVariable String branch) {
		List<CinemaDTO> cinemaList = cs.selectAllScreen(branch);
		List<String> screenList = new ArrayList<String>();
		for(int i=0; i < cinemaList.size(); i++) {
			System.out.println(cinemaList.get(i).getScreen_code());
			screenList.add(i, cinemaList.get(i).getScreen_code());
		}
		
		return screenList;
		
	}
}
