package com.itbank.controller;

import java.util.HashMap;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonParser;
import com.itbank.service.KaKaoPayService;

@RestController
public class KakaoPay {

	@Autowired private KaKaoPayService kp;
	@RequestMapping(value = "/payments", method = RequestMethod.POST,consumes = "application/json; charset=utf-8" )
	public String Kakaopay(@RequestBody HashMap<String, Object>param) {
		System.out.println(param); //주문번호 가맹점번호 파라미터로 받아옴. DB에 저장할 데이터도 차후 받아오기.
		JSONObject token =kp.getImportToken();
		//{"code":0,"message":null,"response":{"access_token":"c659d28525e034bfe0e75be9d71122585da0c97e","now":1624322656,"expired_at":1624324456}}
		JSONObject response =token.getJSONObject("response");
		
		System.out.println(response.toString());
		
		String accesstoken = "access_token: "+ response.getString("access_token");
		int expired_at = response.getInt("expired_at");
//	
		System.out.println(accesstoken);
		System.out.println(expired_at);
		
		return 1+"";
	}
}
