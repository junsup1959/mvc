package com.itbank.controller;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itbank.member.KakaoProfile;
import com.itbank.member.MemberDTO;
import com.itbank.member.OauthToken;
import com.itbank.service.MemberService;

@Controller
@RequestMapping("/member")
public class KakaoMemberController {

	@Autowired MemberService ms;
	
	/*
	 * 문제점123123
	 * 가입시 카카오에서 없는 정보에 대한 처리 - member_addr, member_phone => 카카오로 로그인 후 설정??
	 * member_password 또한 없는 정보 -> 카카오 로그인 후 다시 설정하는것도 이상 / 하지만 개인정보 수정할 때 비밀번호를 받아서 수정하기 때문에 설정이 필요
	 * 개인정보 수정 때 마찬가지로 api로 처리??
	 * 
	 * 전부 다 실패 했을 경우 msg 를 alert 로 보내주는 코드 하나 작성 !!!!
	 * 
	 * 카카오톡에서 직접 프로필을 변경하면 우리서버에서 연동할 방법이 없음
	 * 최초 로그인 정보를 카톡에 저장하기 때문에
	 * => 로그인 할때마다 정보 업데이트??
	 * 
	 * 네아로는 심지어 주소 등을 추가로 못받게함
	 * 
	 * */
	
	
	// 카카오 API 사용
	@GetMapping(value="/auth/kakao/callback", produces="text/json;charset=UTF-8")
	public ModelAndView kakaoCallback(String code, HttpSession session) {
		
		//post 방식으로 key=value 데이터를 요청(카카오쪽으로)
		//라이브러리 모음
		//Retrofit2 - 안드로이드에서 많이 사용
		//OkHttp
		//RestTemplate
		
		RestTemplate rt = new RestTemplate();
		
		//HttpHeader 오브젝트 생성
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
	
		
		String grant_type = "authorization_code";
		String client_id ="7d7a89444c3dc7117978512358c75028";
		String redirect_uri = "http://localhost:8081/team/member/auth/kakao/callback";
	
		//HttpBody 오브젝트 생성
		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
		params.add("grant_type", grant_type);
		params.add("client_id", client_id);
		params.add("redirect_uri", redirect_uri);
		params.add("code", code);
		
		//HttpHeader와 HttpBody 를 하나의 오브젝트에 담기
		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = 
				new HttpEntity<MultiValueMap<String,String>>(params, headers);
		
		//Http 요청하기 - Post방식으로 - 그리고 response 변수의 응답 받음
		ResponseEntity<String> response = rt.exchange(
				"https://kauth.kakao.com/oauth/token",
				HttpMethod.POST,
				kakaoTokenRequest,
				String.class
				);
		
		// Gson, Json Simple, ObjectMapper
		ObjectMapper objectMapper = new ObjectMapper();
		OauthToken oauthToken = null;
		try {
			oauthToken = objectMapper.readValue(response.getBody(), OauthToken.class);
		} catch (JsonParseException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		RestTemplate rt2 = new RestTemplate();
		
		//HttpHeader 오브젝트 생성
		HttpHeaders headers2 = new HttpHeaders();
		headers2.add("Authorization", "Bearer " + oauthToken.getAccess_token());
		headers2.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
	
		//HttpHeader와 HttpBody 를 하나의 오브젝트에 담기
		HttpEntity<MultiValueMap<String, String>> kakaoProfileRequest = 
				new HttpEntity<>(headers2);
		
		//Http 요청하기 - Post방식으로 - 그리고 response 변수의 응답 받음
		ResponseEntity<String> response2 = rt2.exchange(
				"https://kapi.kakao.com/v2/user/me",
				HttpMethod.POST,
				kakaoProfileRequest,
				String.class
				);
		
		ObjectMapper objectMapper2 = new ObjectMapper();
		KakaoProfile kakaoProfile = null;
		try {
			kakaoProfile = objectMapper2.readValue(response2.getBody(), KakaoProfile.class);
		} catch (JsonParseException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	
		// member 오브젝트 : member_name, member_email, memeber_password, member_nick, member_phone, member_gender, member_addr
		//member_addr, member_phone => 카카오로 로그인 후 설정??
//		System.out.println("member_name : " + kakaoProfile.getProperties().getNickname() ); 
//		System.out.println("member_email : " + kakaoProfile.getKakao_account().getEmail());
//		System.out.println("member_password : " + tempPw); // 의미없는 값이기 때문에 uuid로 처리
//		System.out.println("member_nick : " + kakaoProfile.getKakao_account().getProfile().getNickname());  // 기존에 존재하는 nick 과 충돌은 어떻게 처리??
//		System.out.println("member_gender : " + kakaoProfile.getKakao_account().getGender());
		
		
		
		MemberDTO member = new MemberDTO();
		member.setMember_name(kakaoProfile.getProperties().getNickname());
		member.setMember_email(kakaoProfile.getKakao_account().getEmail());
		String tempPw = UUID.randomUUID().toString().split("-")[0];
		member.setMember_password(tempPw);
		member.setMember_nick(kakaoProfile.getKakao_account().getProfile().getNickname());
		member.setMember_gender(kakaoProfile.getKakao_account().getGender().toUpperCase().substring(0, 1));
		member.setMember_addr1("United State");
		member.setMember_addr2("123");
		member.setMember_phone("01012345678");
		
	
		ModelAndView mav = new ModelAndView();
		// kakaoProfile.getKakao_account().getEmail() 가 존재하면 바로 홈페이지로 보내주고
		if(ms.select(kakaoProfile.getKakao_account().getEmail()) == 1) {

			// 비밀번호는 검증할때마다 uuid 로 변하기 때문에 다른 unique 값인 member_email 만으로 멤버 객체 가져오기
			mav = login(member, session);
			return mav;
		}
		
		// kakaoProfile.getProperties().getNickname() 가 없으면 회원가입 시키고 홈페이지로
		
		int row = ms.insert(member);
		if(row == 1) {
			mav = login(member, session);
			return mav;
			}
		// 전부 다 실패 했을 경우 msg 를 alert 로 보내주는 코드 하나 작성 !!!!
		mav.addObject("kakaoError", "로그인을 실행할 수 없습니다. 관리자에게 문의하세요");
		mav.setViewName("member/login");
		return mav;
		
	}
	
	
	
	private ModelAndView login(MemberDTO member, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		MemberDTO login = ms.selectOne2(member);
		if(login != null) {
			mav.setViewName("home");
			session.setAttribute("login", login);
			session.setMaxInactiveInterval(60*60*3);
//			System.out.println("로그인 성공");
			return mav;
			
		}
		mav.setViewName("member/login");
//		System.out.println("로그인 실패");
		return mav;
	}
	
}
