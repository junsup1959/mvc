package com.itbank.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.net.ssl.HttpsURLConnection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.review.ReviewDAO;
import com.itbank.review.ReviewDTO;

@Service
public class ReviewService {

	@Autowired private ReviewDAO dao;
	
	  private final String AUTH_KEY = "0c5277606b20ef880a6c3aec340bb83b";
	  private final SimpleDateFormat DATE_FMT = new SimpleDateFormat("yyyyMMdd");
	  
	  
	public String dayily() throws IOException {
		String REQUEST_URL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json";

		  Calendar cal = Calendar.getInstance();
		  cal.setTime(new Date());
		  cal.add(Calendar.DATE, -1);
		  Map<String, String> paramMap = new HashMap<String, String>();
		  paramMap.put("key"          , AUTH_KEY);                        // 발급받은 인증키
		  paramMap.put("targetDt"     , DATE_FMT.format(cal.getTime()));  // 조회하고자 하는 날짜
		  paramMap.put("itemPerPage"  , "10");                            // 결과 ROW 의 개수( 최대 10개 )
		//  paramMap.put("multiMovieYn" , "N");                             // Y:다양성 영화, N:상업영화, Default:전체
		//  paramMap.put("repNationCd"  , "F");                             // K:한국영화, F:외국영화, Default:전체

  
	      URL requestURL = new URL(REQUEST_URL+"?"+makeQueryString(paramMap));
	      HttpURLConnection conn = (HttpURLConnection) requestURL.openConnection();
	
	      conn.setRequestMethod("GET");
	      conn.setDoInput(true);
	
	      BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
	      String readline = null;
	      StringBuffer response = new StringBuffer();
	      while ((readline = br.readLine()) != null) {
	          response.append(readline);
	      }
	      br.close();
        conn.disconnect();
	      return response.toString();
	}
	
	public String weekley() throws IOException{
	
		String REQUEST_URL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json";	
		Calendar cal = Calendar.getInstance();
		 Map<String, String> paramMap = new HashMap<String, String>();
	     paramMap.put("key"          , AUTH_KEY);                        // 발급받은 인증키
	     paramMap.put("targetDt"     , DATE_FMT.format(cal.getTime()));  // 조회하고자 하는 날짜
	     paramMap.put("weekGb"  , "0");                            //  “0” : 주간 (월~일) “1” : 주말 (금~일) (default)  “2” : 주중 (월~목)
	     paramMap.put("itemPerPage"  , "10");                            // 결과 ROW 의 개수( 최대 10개 )

     
         URL requestURL = new URL(REQUEST_URL+"?"+makeQueryString(paramMap));
         HttpURLConnection conn = (HttpURLConnection) requestURL.openConnection();

         conn.setRequestMethod("GET");
         conn.setDoInput(true);

         BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
         String readline = null;
         StringBuffer response = new StringBuffer();
         while ((readline = br.readLine()) != null) {
             response.append(readline);
         }
         br.close();
         conn.disconnect();
         
        return response.toString();
	}
	
	public String movieSearch (String query) throws IOException{
		
		
		String client_id = "p3EkwlpyD99frDpNN5th";
		String client_secret = "_t4XeBaQvU";
		String EQquery = URLEncoder.encode(query, "UTF-8");
		String url = "https://openapi.naver.com/v1/search/movie.json?query="+EQquery;
		URL ur = new URL(url);
		HttpsURLConnection con = (HttpsURLConnection) ur.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("X-Naver-Client-Id", client_id);
		con.setRequestProperty("X-Naver-Client-Secret", client_secret);
		
		int code = con.getResponseCode();
		
		InputStreamReader read = new InputStreamReader(con.getInputStream(), "UTF-8");
		BufferedReader bffread = new BufferedReader(read);
		StringBuilder response = new StringBuilder();
		String li= null;
		
		while((li = bffread.readLine())!=null) {
			response.append(li);
		}
		bffread.close();
		read.close();
		con.disconnect();
		
		return response.toString();
		
	}

	
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
//////////////////////////////////DB 관련 함수////////////////////////////////
	public int insert(ReviewDTO dto) {
		return dao.insert(dto);
	}

	public List<ReviewDTO> selectAll(int moviecode) {
		return dao.selectAll(moviecode);
	}
	 

}
