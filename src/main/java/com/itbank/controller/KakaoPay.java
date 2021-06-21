package com.itbank.controller;

import java.util.HashMap;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.itbank.service.KaKaoPayService;

@RestController
public class KakaoPay {

	@Autowired private KaKaoPayService kp;
	@RequestMapping(value = "/payments", method = RequestMethod.POST,consumes = "application/json; charset=utf-8" )
	public String Kakaopay(@RequestBody HashMap<String, Object>param) {
		System.out.println(param); //주문번호 가맹점번호 파라미터로 받아옴. DB에 저장할 데이터도 차후 받아오기.
		JSONObject token =kp.getImportToken();
		JSONArray response = token.getJSONArray("response");
		String accesstoken = "access_token: "+response.getString(0);
		
		System.out.println(accesstoken);

		
		return 1+"";
	}
}
