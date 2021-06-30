<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

영화 목록


순위 이미지 타이틀
<hr>

<div style="display: none">
<a href="${cpath }/member/dailymovie">영화목록</a>
</div>


<!-- 네이버에서 받아온 영화  띄우기 -->


저번주 일주일간 영화 랭킹
<div id="weekly"></div>





<script>

	const test1 = '${weeklyMovie }'
		
	const test2 = JSON.parse(test1)
	
	for(let i = 0;i< test2.boxOfficeResult.weeklyBoxOfficeList.length ; i++ ){
		const movieName = test2.boxOfficeResult.weeklyBoxOfficeList[i].movieNm
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
				p.className='linkWrap'
				switch(key) {
				case 'title': 
					p.innerHTML =  data[key]
					break;
				case 'image':
					p.innerHTML = '<img src="' + data[key] + '" style="width:200px;" class="linkImg">'
				case 'link':
					p.innerHTML += '<a href="' + data[key] + 
						'" style="width:150px; height:35px; color : #fff; border : 2px solid #fff; border-radius : 5px;" class="link">영화상세정보</a>'
						
				}
				if(p.innerText !=''){
				wrap.appendChild(p)
				}
				}
				
			document.getElementById('weekly').appendChild(wrap)
		
		})

}
	
	
</script>
</body>
</html>