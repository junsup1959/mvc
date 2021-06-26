package com.itbank.service;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.net.ssl.HttpsURLConnection;

import org.json.JSONObject;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;



@Service
public class KaKaoPayService {

public static final String IMPORT_TOKEN_URL = "https://api.iamport.kr/users/getToken"; 
public static final String KEY = "6753336084250479";
public static final String SECRET = "2ad841f85121872df2d0ff5e5ebdfe0d3b9b2e791ee6c7376f8c4128a273e2536b6956000344f865";   
public static ObjectMapper mapper =new ObjectMapper();


	
	public static String getImportToken() { 
		
		try {
			URL url=new URL(IMPORT_TOKEN_URL);
			
			HttpsURLConnection con = (HttpsURLConnection) url.openConnection();
			con.setDoOutput(true); //파라미터 전달할때(바디에..)
			con.setRequestMethod("POST");
			con.setRequestProperty("Content-Type", "application/json");
			
			
			
			JSONObject auth = new JSONObject();
			auth.put("imp_key", KEY);
			auth.put("imp_secret", SECRET);
			
			OutputStream stream = con.getOutputStream();
//			stream.write(auth.toString().getBytes("UTF-8"));
			DataOutputStream dataStream = new DataOutputStream(stream);
			dataStream.writeBytes(auth.toString());
			dataStream.close();  //close 를 하면 flush()를 자동으로 실행
//			stream.flush();
			stream.close();
			
//			int rlt = con.getResponseCode(); // 결과 코드 200일때 성공
			
			//...
			StringBuilder response = new StringBuilder();
			BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
			
			String line;

			while ((line = in.readLine()) != null) {
			  response.append(line);
			}
			in.close();
			con.disconnect();
			 
			JSONObject token = new JSONObject(response.toString());
			JSONObject rsp =token.getJSONObject("response");
			String acctoke = rsp.getString("access_token");
			return acctoke;
			
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	

////////////////////////////////////주문내역 조회/////////////////////////////////////////////////////////////
	public static JsonNode paymentList(String merchant_uid) {
		String url = "https://api.iamport.kr/payments/findAll/" + merchant_uid;
		URL ur;
		try {
			ur = new URL(url);
			String accesstoken = getImportToken();
			HttpsURLConnection con = (HttpsURLConnection) ur.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("Authorization", "Bearer " + accesstoken);
			
			StringBuilder response = new StringBuilder();
			InputStreamReader reader = new InputStreamReader(con.getInputStream());
			BufferedReader li = new BufferedReader(reader);
			String n = null;
			while ((n = li.readLine()) != null) {
				response.append(n);
			}
			JsonNode rsp = mapper.readTree(response.toString());
			System.out.println(rsp.toString());
			return rsp;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	
////////////////////////////////////////////////	////////// 결제 취소 및 java로 form 데이터 전송하기///////////////////
/*
 * 파라미터 목록 ex)
 		("imp_uid", "imp_12321345"); 결제 고유번호 따로 있음
		("merchant_uid", "merchant_1624363104561"); 거래 고유번호
		("amount", (double)1500.0); 금액 double
		("reason", "테스트"); 취소이유
 */
	
    public static String Cancle(HashMap < String, Object > param) throws IOException {
    	
    	StringBuilder data = new StringBuilder();
    	for(Map.Entry<String,Object> p : param.entrySet()) {
    		if(data.length() !=0)
    			data.append("&");
    		data.append(URLEncoder.encode(p.getKey(), "UTF-8"));
    		data.append("=");
    		data.append(URLEncoder.encode(String.valueOf(p.getValue()), "UTF-8"));
    	}
    	byte[] postdata = data.toString().getBytes();
    	String accesstoken = getImportToken();
    	URL url = new URL("https://api.iamport.kr/payments/cancel");
    	HttpsURLConnection con = (HttpsURLConnection) url.openConnection();
    	con.setRequestMethod("POST");
    	con.setRequestProperty("Authorization", "Bearer " + accesstoken);
		con.setRequestProperty( "Content-Type", "application/x-www-form-urlencoded"); 
		con.setRequestProperty( "charset", "utf-8");
		con.setRequestProperty( "Content-Length", String.valueOf( postdata.length ));
		con.setDoOutput(true);
		
		con.getOutputStream().write(postdata);

		
		StringBuilder response = new StringBuilder();
		BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
		
		String line;

		while ((line = in.readLine()) != null) {
		  response.append(line);
		}
		in.close();
		con.disconnect();
		
//		return JsonNode response;
		return response.toString();
    }
}