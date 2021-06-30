package com.itbank.controller;

import java.util.ArrayList;
import java.util.List;
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
	@PostMapping("/modify")
	public String modifyScreen(CinemaDTO cinema) {
		System.out.println(cinema.getSeat_amount());
		System.out.println(cinema.getUsable());
		System.out.println(cinema.getScreen_code());
		int row = cs.modifyScreen(cinema);
		
		return row + "";
	}
	
	
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
	
	@ResponseBody
	@DeleteMapping(value = "/{screen_code}", produces = "application/json; charset=utf-8")
	public int deleteScreen(@PathVariable String screen_code) {
		int row = cs.deleteScreen(screen_code);
		
		return row;
	}
	
	@ResponseBody
	@PostMapping("/insertTheaterInfo")
	public String insertTheater_info(Theater_infoDTO info) {
		String startTime = info.getStart_time();
		startTime = startTime.replace(":", "");
		info.setStart_time(startTime);
		int hour = (info.getRuntime()/60); 
		int minute = (info.getRuntime()%60);
		String runTime = Integer.toString(hour) + Integer.toString(minute);
		info.setRuntime(Integer.parseInt(runTime));
		int end_time = (Integer.parseInt(info.getStart_time()) + info.getRuntime());
		if((end_time % 100) >= 60 ) {
			end_time += 40;
		}
		info.setEnd_time(Integer.toString(end_time));

		int row = 0;
		int i_s = Integer.parseInt(info.getStart_time());
		int i_e = Integer.parseInt(info.getEnd_time());
		
		int i2_s = Integer.parseInt(info.getStart_date().replace("-", ""));
		int i2_e = Integer.parseInt(info.getEnd_date().replace("-", ""));
		
//		System.out.println("입력 상영관 영화 시작시간: "+i_s);
//		System.out.println("입력 상영관 영화 마감시간: "+i_e);
//		System.out.println("=============================================");
		List<Theater_infoDTO> screenCodes = cs.screenCodes(info.getScreen_code());
		
		for(int i = 0; i < screenCodes.size(); i++) {
			int s_s = Integer.parseInt(screenCodes.get(i).getStart_time());
			int s_e = Integer.parseInt(screenCodes.get(i).getEnd_time());
			int s2_s = Integer.parseInt(screenCodes.get(i).getStart_date().replace("-", ""));
			int s2_e = Integer.parseInt(screenCodes.get(i).getEnd_date().replace("-", ""));
			
//			System.out.println("입력 되어있는 상영관 영화 마감시간: "+ s_s);
//			System.out.println("입력 되어있는 상영관 영화 마감시간: "+s_e);
			if((i2_s < s2_s && i2_e < s2_s) || (i2_s > s2_e && i2_s> s2_e)) {
				row = cs.insertTheater_info(info);
				 return row + "";
			}else {
				if((i_s < s_s && i_e < s_s) || (i_s > s_e && i_s> s_e)) {
					row = cs.insertTheater_info(info);
					return row + "";
				}
			}
		}
		if(screenCodes.size() == 0) {
			row = cs.insertTheater_info(info);
			return row+"";
		}
//		System.out.println("row : " + row);

		return i_s + " ~ " + i_e;
	}
	
	@ResponseBody
	@GetMapping(value = "/getScreenCodes/{screenName}", produces = "application/json; charset=utf-8")
	public List<Theater_infoDTO> screenList(@PathVariable String screenName) {
		List<Theater_infoDTO> screenCodes = cs.screenCodes2(screenName);
		return screenCodes;
	}
	
	
}
