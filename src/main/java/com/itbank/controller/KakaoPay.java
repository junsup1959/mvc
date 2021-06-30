package com.itbank.controller;

import java.io.IOException;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itbank.revervation.ReservDTO;
import com.itbank.service.KaKaoPayService;
import com.itbank.service.ReservationSrvice;

@RestController
public class KakaoPay {
	@Autowired private KaKaoPayService kp;
	@Autowired private ReservationSrvice rs;
	ObjectMapper mapper=new ObjectMapper();

	@RequestMapping(value = "/payments", method = RequestMethod.POST,consumes="application/json; charset=utf-8")
	public String Kakaopay(@RequestBody ReservDTO dto) throws IOException {
		

		System.out.println("seatnum"+ dto.getSeatNum());
		System.out.println("reserv_num : "+dto.getReserv_num());
		JsonNode search = mapper.readTree(kp.paymentSearch(dto.getMerchant_uid()));
		
		if(kp.compare(dto, search)) {
//			디비작업하는 부분
			int row =rs.insert(dto);
			return row+"";
		}
		
		
//		 form 데이터와 아임포트 스크립트쪽 변수값이 틀리므로 강제 취소
		HashMap<String, Object>cancleParam=kp.cancleParam(dto.getImp_uid(),dto.getMerchant_uid(),0,"데이터 불일치");
//		 취소,환불 api에 전달할 파라미터 작성 메소드
//		 숫자는 금액 but 0은 전액취소
		kp.Cancle(cancleParam);
		//취소 메소드.
		return "n";
	}
}
