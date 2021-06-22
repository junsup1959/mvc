package com.itbank.service;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Iterator;
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
 		("imp_uid", "imp22022976"); iamport 고유번호
		("merchant_uid", "merchant_1624363104561"); 거래 고유번호
		("amount", (double)1500.0); 금액 double
		("reason", "테스트"); 취소이유
 */
	
    public static JsonNode Cancle(HashMap < String, Object > Form) {

    	String ur = "https://api.iamport.kr/payments/cancel"; // api 주소값
        try {
            //   URL 설정하고 접속하기 
            URL url = new URL(ur); // URL 설정 
            String accesstoken = getImportToken();
            
            HttpsURLConnection con = (HttpsURLConnection) url.openConnection(); // 접속 
            //-------------------------- 
            //   전송 모드 설정 - 기본적인 설정 
            //-------------------------- 
            con.setDefaultUseCaches(false);
            con.setDoOutput(true); 
            con.setRequestMethod("POST"); // 전송 방식은 POST
            
            //--------------------------
            // 헤더 세팅
            //--------------------------
            // 서버에게 웹에서 <Form>으로 값이 넘어온 것과 같은 방식으로 처리하라는 걸 알려준다 
            con.setRequestProperty("Authorization", "Bearer " + accesstoken);
            con.setRequestProperty("content-type", "application/x-www-form-urlencoded");


            StringBuffer buffer = new StringBuffer();

            //HashMap으로 전달받은 파라미터가 null이 아닌경우 버퍼에 넣어준다
            System.out.println(Form);
            if (Form != null) {

                Set<String> key = Form.keySet();
                buffer.append("{");
                
                for (Iterator<String> iterator = key.iterator(); iterator.hasNext();) {
                    String keyName = (String) iterator.next();
	                    String valueName = (String) Form.get(keyName);
	                    buffer.append(keyName).append("=").append(valueName).append(", ");
                    }
                buffer.deleteCharAt(buffer.lastIndexOf(","));
                buffer.deleteCharAt(buffer.lastIndexOf(" "));
                buffer.append("}");
            }
            System.out.println(buffer.toString());
            OutputStreamWriter outStream = new OutputStreamWriter(con.getOutputStream(), "UTF-8");
            PrintWriter writer = new PrintWriter(outStream);
            writer.write(buffer.toString());
            writer.flush();



         
            InputStreamReader tmp = new InputStreamReader(con.getInputStream(), "UTF-8");
            BufferedReader reader = new BufferedReader(tmp);
            StringBuilder reponse = new StringBuilder();
            String str;
            while ((str = reader.readLine()) != null) {
            	reponse.append(str + "\n");
            }
            ObjectMapper mapper =new ObjectMapper();
            JsonNode rsp = mapper.readTree(reponse.toString());
            System.out.println(rsp.toString());
            return rsp;

        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

		
}
