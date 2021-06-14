package com.itbank.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@RestController

public class SummerNoteFile {
	
	
	
	private ObjectMapper mapper=new ObjectMapper();
	@RequestMapping(value="/uploadSummernoteImageFile",method = RequestMethod.POST, produces = "application/json; charset=utf8")
	@ResponseBody
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile) throws JsonProcessingException {
		
		//JsonObject jsonObject = new JsonObject();
		String json=null;
		HashMap<String, String> jm=new HashMap<>();
		
		String fileRoot = "D:\\upload\\";	//저장될 외부 파일 경로
		String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
				
		String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
		
		File targetFile = new File(fileRoot + savedFileName);	
		
		try {
			multipartFile.transferTo(targetFile);	//파일 저장
			//jsonObject.addProperty("url", "/upload/"+savedFileName);
			//jsonObject.addProperty("responseCode", "success");
			jm.put("url", "/upload/"+savedFileName);
			jm.put("responseCode", "success");
		} catch (IOException e) {
			targetFile.delete();	//저장된 파일 삭제
			//jsonObject.addProperty("responseCode", "error");
			jm.put("responseCode", "error");
			e.printStackTrace();
		}
		
		
		json=mapper.writeValueAsString(jm);
		//return jsonObject;
		return json;
	}
}

