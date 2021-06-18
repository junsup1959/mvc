<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

영화 목록


순위 이미지 타이틀
<hr>

<div style="display: none">
<a href="${cpath }/member/movie">영화목록</a>
</div>


<!-- 네이버에서 받아온 영화  띄우기 -->
<div id="daily"></div>



<div id="weekly"></div>





<script>

	const test1 = '${movie }'
		
	const test2 = JSON.parse(test1)
	
	for(let i = 0;i< test2.boxOfficeResult.dailyBoxOfficeList.length ; i++ ){
		const movieName = test2.boxOfficeResult.dailyBoxOfficeList[i].movieNm
		const client_id = "p3EkwlpyD99frDpNN5th";
		const client_secret = "_t4XeBaQvU";
		const encText = encodeURI(movieName);
		const url = "https://cors-anywhere.herokuapp.com/https://openapi.naver.com/v1/search/movie.json?query=" + encText; // json 결과
		//원래 요청주소 url = "https://openapi.naver.com/v1/search/movie.json?query=" + encText;
		//url = "https://cors-anywhere.herokuapp.com/https://openapi.naver.com/v1/search/movie.json?query=" + encText; //cross origin문제시 
		const opt ={
				method : 'GET',
				headers : {
					'Content-Type': 'application/json',
					'X-Naver-Client-Id': client_id,
					'X-Naver-Client-Secret': client_secret
				}
		}
	
	
		fetch(url, opt)
		.then(resp => resp.json())
		.then(json => {
			console.log(json)
			const wrap = document.createElement('div')
			const data = json.items[0]
			for(key in data) {
				const p = document.createElement('p')
				switch(key) {
				case 'title': 
					p.innerHTML =  data[key]
					break;
				case 'image':
					p.innerHTML = '<img src="' + data[key] + '" style="width:200px;">'
					break;
				}
				
				wrap.appendChild(p)
				}
				
			document.getElementById('daily').appendChild(wrap)
		
		})

}
	
	
</script>
</body>
</html>