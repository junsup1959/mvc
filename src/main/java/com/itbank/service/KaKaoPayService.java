package com.itbank.service;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import javax.net.ssl.HttpsURLConnection;

import org.json.JSONObject;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itbank.revervation.ReservDTO;



@Service
public class KaKaoPayService {

public final String IMPORT_TOKEN_URL = "https://api.iamport.kr/users/getToken"; 
public final String KEY = "6753336084250479";
public final String SECRET = "2ad841f85121872df2d0ff5e5ebdfe0d3b9b2e791ee6c7376f8c4128a273e2536b6956000344f865";   
public ObjectMapper mapper =new ObjectMapper();


	
	public String getImportToken() { 
		
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
	public String paymentSearch(String merchant_uid) {
		String url = "https://api.iamport.kr/payments/find/" + merchant_uid;
		URL ur;
		try {
			ur = new URL(url);
			String accesstoken = getImportToken();
			HttpsURLConnection con = (HttpsURLConnection) ur.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("Authorization", "Bearer " + accesstoken);
			
			StringBuilder response = new StringBuilder();
			InputStreamReader reader = new InputStreamReader(con.getInputStream(),"UTF-8");
			BufferedReader li = new BufferedReader(reader);
			String n = null;
			while ((n = li.readLine()) != null) {
				response.append(n);
			}
			li.close();
			con.disconnect();
			
			return response.toString();
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	
////////////////////////////////////////////////	////////// 결제 취소 및 java로 form 데이터 전송하기///////////////////

    public String Cancle(HashMap < String, Object > param) throws IOException {
    	
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
    //////////////////// 환불 파라미터 ////////////////////////////////////////////
    public HashMap<String, Object> cancleParam(String imp_uid,String merchant_uid,double amount,String reason){
    	HashMap<String, Object>param = new HashMap<String, Object>();
    	param.put("imp_uid", imp_uid);
    	param.put("merchant_uid", merchant_uid);
    	if( amount!= 0) {
    	param.put("amount", amount);
    	}
    	param.put("reason", reason);
    	
    	return param;
    }
    /////////////////////비교////////////////////////
    public boolean compare(ReservDTO dto,JsonNode json) throws IOException {	
    	
    	String email=dto.getMember_email();
		String cemail=json.get("response").get("buyer_email").toString().replaceAll("\"", "");
		String name=dto.getMember_name();
		String cname=json.get("response").get("buyer_name").toString().replaceAll("\"", "");
		String pay=dto.getPay();
		String cpay=json.get("response").get("amount").toString();
		
		if(email.equals(cemail)&name.equals(cname)&pay.equals(cpay)) {
		//DB에 넣는부분
			return true;
		}
		// form 데이터와 아임포트 스크립트쪽 변수값이 틀리므로 강제 취소
    	return false;
	}
	
}