package com.itbank.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
 
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itbank.cinema.Theater_infoDTO;
import com.itbank.service.CinemaService;
 
@Controller
public class MovieController {
 
	ObjectMapper mapper = new ObjectMapper();
	@Autowired private CinemaService cs;
    // 상수 설정
    //   - 요청(Request) 요청 변수
    private final String AUTH_KEY = "0c5277606b20ef880a6c3aec340bb83b";
 
    //   - 일자 포맷
    private final SimpleDateFormat DATE_FMT = new SimpleDateFormat("yyyyMMdd");
 

	@GetMapping("/movie/cinema")
	public void cinema() {}
    
    
    
    // API요청
    @GetMapping(value = {"/movie/dailyMovie","/movie/ticket","/admin/cinema/insertTheaterInfo"})
    public ModelAndView dailyMovie() {
    	
    	String REQUEST_URL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json";

//        // 변수설정
//        //   - 하루전 닐짜
    	
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        cal.add(Calendar.DATE, -1);
 
        // 변수 설정
        //   - 요청(Request) 인터페이스 Map
        //   - 어제자 다양성 한국영화 10개 조회
        Map<String, String> paramMap = new HashMap<String, String>();
        paramMap.put("key"          , AUTH_KEY);                        // 발급받은 인증키
        paramMap.put("targetDt"     , DATE_FMT.format(cal.getTime()));  // 조회하고자 하는 날짜
        paramMap.put("itemPerPage"  , "10");                            // 결과 ROW 의 개수( 최대 10개 )
//        paramMap.put("multiMovieYn" , "N");                             // Y:다양성 영화, N:상업영화, Default:전체
//        paramMap.put("repNationCd"  , "F");                             // K:한국영화, F:외국영화, Default:전체
 
        
        ModelAndView mav = new ModelAndView();
        try {
            // Request URL 연결 객체 생성
            URL requestURL = new URL(REQUEST_URL+"?"+makeQueryString(paramMap));
            HttpURLConnection conn = (HttpURLConnection) requestURL.openConnection();
 
            // GET 방식으로 요청
            conn.setRequestMethod("GET");
            conn.setDoInput(true);
 
            // 응답(Response) 구조 작성
            //   - Stream -> JSONObject
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            String readline = null;
            StringBuffer response = new StringBuffer();
            while ((readline = br.readLine()) != null) {
                response.append(readline);
            }
 
            // JSON 객체로  변환
            JSONObject responseBody = new JSONObject(response.toString());
 
            // 데이터 추출
            JSONObject boxOfficeResult = responseBody.getJSONObject("boxOfficeResult");
 
            // 박스오피스 목록 출력
            JSONArray dailyBoxOfficeList = boxOfficeResult.getJSONArray("dailyBoxOfficeList");
            
            if(requestURL.equals("dailyMovie")) {
            	mav.setViewName("movie/dailyMovie");
            	}
            if(requestURL.equals("ticket")){
        		mav.setViewName("movie/ticket");
            	}
            
            List<Theater_infoDTO>list = cs.selectAlltheater_info();
            String json = mapper.writeValueAsString(list);
            mav.addObject("list", list);
            mav.addObject("json", json);
            mav.addObject("dailyMovie", response);
            return mav;
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        
        
        mav.setViewName("home");
        return mav;
        
    }
 
    // API요청
    @GetMapping("/movie/weeklyMovie")
    public ModelAndView weeklyMovie() {
    	
    	String REQUEST_URL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json";

//        // 변수설정
//        //   - 하루전 닐짜
    	
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        cal.add(Calendar.DATE, -7);
 
        // 변수 설정
        //   - 요청(Request) 인터페이스 Map
        //   - 어제자 다양성 한국영화 10개 조회
        Map<String, String> paramMap = new HashMap<String, String>();
        paramMap.put("key"          , AUTH_KEY);                        // 발급받은 인증키
        paramMap.put("targetDt"     , DATE_FMT.format(cal.getTime()));  // 조회하고자 하는 날짜
        paramMap.put("weekGb"  , "0");                            //  “0” : 주간 (월~일) “1” : 주말 (금~일) (default)  “2” : 주중 (월~목)
        paramMap.put("itemPerPage"  , "10");                            // 결과 ROW 의 개수( 최대 10개 )
//        paramMap.put("multiMovieYn" , "N");                             // Y:다양성 영화, N:상업영화, Default:전체
//        paramMap.put("repNationCd"  , "F");                             // K:한국영화, F:외국영화, Default:전체
 
        
        ModelAndView mav = new ModelAndView();
        try {
            // Request URL 연결 객체 생성
            URL requestURL = new URL(REQUEST_URL+"?"+makeQueryString(paramMap));
            HttpURLConnection conn = (HttpURLConnection) requestURL.openConnection();
 
            // GET 방식으로 요청
            conn.setRequestMethod("GET");
            conn.setDoInput(true);
 
            // 응답(Response) 구조 작성
            //   - Stream -> JSONObject
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            String readline = null;
            StringBuffer response = new StringBuffer();
            while ((readline = br.readLine()) != null) {
                response.append(readline);
            }
 
            // JSON 객체로  변환
            JSONObject responseBody = new JSONObject(response.toString());
 
            // 데이터 추출
            JSONObject boxOfficeResult = responseBody.getJSONObject("boxOfficeResult");
            // 박스오피스 목록 출력
            JSONArray weeklyBoxOfficeList = boxOfficeResult.getJSONArray("weeklyBoxOfficeList");

            mav.setViewName("movie/weeklyMovie");
            mav.addObject("weeklyMovie", response);
            return mav;
        } catch (IOException e) {
            e.printStackTrace();
        }
        mav.setViewName("home");
        return mav;
        
    }
    
    // Map -> QueryString
    private String makeQueryString(Map<String, String> paramMap) {
        final StringBuilder sb = new StringBuilder();
 
        paramMap.entrySet().forEach(( entry )->{
            if( sb.length() > 0 ) {
                sb.append('&');
            }
            sb.append(entry.getKey()).append('=').append(entry.getValue());
        });
 
        return sb.toString();
    }
    
    
    @GetMapping("/movie/ticket2")
    public void ticket() {}
    
    
}