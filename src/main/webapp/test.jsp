<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="dd"></div>
<script>
const client_id = "I7FzBPCSxmNl4knQfa9r";
const client_secret = "rsSK6i5vJk";
const encText = encodeURI("쥬라기공원");
const url = "https://cors-anywhere.herokuapp.com/https://openapi.naver.com/v1/search/movie.json?query=" + encText; // json 결과
//원래 요청주소 url = "https://openapi.naver.com/v1/search/movie.json?query=" + encText;
//url = "https://cors-anywhere.herokuapp.com/https://openapi.naver.com/v1/search/movie.json?query=" + encText; //cross origin문제시 
const opt ={
		method : 'GET',
		headers : {
			'Content-Type': 'application/json',
			'X-Naver-Client-Id': 'I7FzBPCSxmNl4knQfa9r',
			'X-Naver-Client-Secret': 'rsSK6i5vJk'
		}
}


fetch(url, opt)
.then(resp => resp.text())
.then(text => {
	document.getElementById('dd').innerText = text;
})

</script>
</body>
</html>