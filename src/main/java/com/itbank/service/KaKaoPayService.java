package com.itbank.service;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.MalformedURLException;
import java.net.URL;
import javax.net.ssl.HttpsURLConnection;

import org.json.JSONObject;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonObject;



@Service
public class KaKaoPayService {


public static final String IMPORT_TOKEN_URL = "https://api.iamport.kr/users/getToken"; 

public static final String KEY = "6753336084250479";
public static final String SECRET = "2ad841f85121872df2d0ff5e5ebdfe0d3b9b2e791ee6c7376f8c4128a273e2536b6956000344f865";   

	ObjectMapper mapper =new ObjectMapper();
	
	public JSONObject getImportToken() { 
		
		try {
			URL url=new URL(IMPORT_TOKEN_URL);
			
			HttpsURLConnection con = (HttpsURLConnection) url.openConnection();
			con.setDoOutput(true); //파라미터 전달할때(바디에..)
			con.setRequestMethod("POST");
			con.setRequestProperty("Content-Type", "application/json");
			
			
			
			JsonObject auth = new JsonObject();
			auth.addProperty("imp_key", KEY);
			auth.addProperty("imp_secret", SECRET);
			
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
			System.out.println(response.toString());
			 
			JSONObject token = new JSONObject(response.toString());
			return token;
			
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	
	//GET /payments/prepare/{merchant_uid}
	public JSONObject prepare1(String merchant_uid,String accesstoken) {
		
		try {
			URL url=new URL("/payments/prepare/"+merchant_uid);
			HttpsURLConnection con = (HttpsURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("Authorization", accesstoken);
			
			
			StringBuilder response = new StringBuilder();
			BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
			String line;
			while((line = in.readLine()) !=null) {
				response.append(line);
			}
			in.close();
			con.disconnect();
			System.out.println(response.toString());
			
			JSONObject jsonobj =new JSONObject(response.toString());
			return jsonobj;
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
		
	}
		
}
