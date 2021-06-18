package com.itbank.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/movie")
public class MovieLinkController {

	@GetMapping("/ticket")
	public void ticket() {}
	
	@GetMapping("/cinema")
	public void cinema() {}

}
