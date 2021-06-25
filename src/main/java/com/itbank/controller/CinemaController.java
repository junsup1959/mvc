package com.itbank.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itbank.cinema.CinemaDTO;
import com.itbank.service.CinemaService;

@Controller
@RequestMapping("/admin/cinema")
public class CinemaController {

	@Autowired CinemaService cs;
	
	@ResponseBody
	@PostMapping("/cinema")
	public String createScreen(CinemaDTO cinema) {
		
		int row = cs.insertCinema(cinema);
		return row + "";
	}
	
	
	@GetMapping("/cinema")
	public void cinema() {}
	
	
}
