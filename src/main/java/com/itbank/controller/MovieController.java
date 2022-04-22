package com.itbank.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
 
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itbank.cinema.CinemaDTO;
import com.itbank.cinema.Theater_infoDTO;
import com.itbank.revervation.ReservDTO;
import com.itbank.service.CinemaService;
import com.itbank.service.ReservationSrvice;
 
@Controller
public class MovieController {
 
	ObjectMapper mapper = new ObjectMapper();
	@Autowired private CinemaService cs;
	@Autowired private ReservationSrvice rs;
    // 상수 설정
    //   - 요청(Request) 요청 변수
    private final String AUTH_KEY = "0c5277606b20ef880a6c3aec340bb83b";
 
    //   - 일자 포맷
    private final SimpleDateFormat DATE_FMT = new SimpleDateFormat("yyyyMMdd");
 

	@GetMapping("/movie/cinema")
	public void cinema() {}
    
    
    
    // API요청
    @GetMapping(value = {"/movie/dailyMovie","/admin/cinema/insertTheaterInfo"})
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
 
            System.out.println(response.toString());
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
    public ModelAndView ticket2(@RequestParam HashMap<String, Object>param) throws JsonProcessingException {
    	ModelAndView mav= new ModelAndView("/movie/ticket2");
    	List<ReservDTO>list = rs.selectSeatNum(param);
    	List<ReservDTO>seatList = new ArrayList<ReservDTO>();
    	List<String> seatarray = new ArrayList<String>();
    	Iterator<ReservDTO>it = list.iterator();

    	while(it.hasNext()) {
    		String[] seat= it.next().getSeatNum().split(",");
    		for(int i = 0 ;i<seat.length;i++) {
    			ReservDTO dto = new ReservDTO();
    			dto.setSeatNum(seat[i]);
    			seatList.add(dto);
    		}
    	}
    	String json = mapper.writeValueAsString(seatList);
    	mav.addObject("list", seatList);
    	
    	it = seatList.iterator();
    	while(it.hasNext()){
    		System.out.println(it.next().getSeatNum());
    	}
    	
    	mav.addObject("seatarray",seatarray.toArray(new String[0]));
    	mav.addObject("json",json);
    	return mav;
    }
    
    @GetMapping("/movie/ticket")
    public void ticket() {}
    
    
    @GetMapping(value = "/movie/movieList",produces = "application/json; charset=utf-8")
    @ResponseBody
    public String movieList(@RequestParam String branch) throws JsonProcessingException {
    	String json = null;
    	List<Theater_infoDTO> movieList = cs.selectAllmovieList(branch);
    	json = mapper.writeValueAsString(movieList);
    	
    	return json;
    }
    
    @GetMapping(value = "/movie/dateList",produces = "application/json; charset=utf-8")
    @ResponseBody
    public String dateList(@RequestParam(value="date", required=false,defaultValue = "0" ) int date, 
    		@RequestParam(value="branch",required=false,defaultValue = "0" ) String branch,
    		@RequestParam(value = "movie_title",required=false,defaultValue = "0" ) String movie_title ) throws JsonProcessingException {
    	String json = null;
    	System.out.println(branch);
    	System.out.println(date);
    	System.out.println(movie_title);
    	if(branch.equals("0") || date == 0 || movie_title.equals("0")) {
    		return json;
    	}
    	List<Theater_infoDTO> dateList = cs.selectAlldate();
    	for(int i=0; i < dateList.size(); i++) {
    		int s_s = Integer.parseInt(dateList.get(i).getStart_date().replace("-", "").substring(4));
			int s_e = Integer.parseInt(dateList.get(i).getEnd_date().replace("-", "").substring(4));
			if(s_s <= date && date <= s_e) {
				List<Theater_infoDTO> movieList = cs.selectDateList(branch, movie_title);
				System.out.println(movieList.toString());
				json = mapper.writeValueAsString(movieList);
				return json;
				
			}
		}
    	return json;
    	
    }
    
}