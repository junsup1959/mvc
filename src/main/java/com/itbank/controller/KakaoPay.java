package com.itbank.controller;

import java.util.HashMap;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonParser;
import com.itbank.service.KaKaoPayService;

@Controller
public class KakaoPay {

	
	@GetMapping("/test")
	public String aaa() {
		return"../test";
	}
	
	@Autowired private KaKaoPayService kp;
	@RequestMapping(value = "/payments", method = RequestMethod.POST,consumes = "application/json; charset=utf-8" )
	@ResponseBody
	public String Kakaopay(@RequestBody HashMap<String, String>param) {
		System.out.println(param); //주문번호 가맹점번호 파라미터로 받아옴. DB에 저장할 데이터도 차후 받아오기.
		
	
		
		return 1+"";
	}
}
