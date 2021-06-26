package com.itbank.controller;

import java.util.List;

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
		System.out.println("cinema.edate " + cinema.getBranch_edate());
		System.out.println("cinema.sdate " + cinema.getBranch_sdate());
		System.out.println("cinema.usable " + cinema.getUsable());
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

	
	@GetMapping("/addCinema/{branch_code}")
	public String addCinema(@PathVariable String branch_code) {
//		cs.selectBranch(branch_code);
		return "admin/cinema/addCinema";
	}
}
