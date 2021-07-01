<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>


<style>
#weekly{width : 1500px; margin : 0 auto; padding : 20px;}
#weekly .linkWrap {position:relative; display : inline-block; width: 220px; height: 350px; margin-left: 50px; margin-bottom: 50px; text-align : center; overflow: hidden; }
#weekly .linkWrap p {display: block; width : 100%;}
#weekly .linkWrap p:first-child{position: absolute; display : block; width : 100%; height : 30px; line-height : 30px; background : #fff; bottom: 0; left : 0; }
#weekly .linkWrap p .linkImg {display: block; width : 100%;}
#weekly .linkWrap p .link{position : absolute; display : none; width : 100%; height : 100%; line-height: 50px; color : #fff; z-index: 10; }
#weekly .linkWrap:hover p .link {display: block; background: rgba(0,0,0,0.6)}
</style>
<section id="bodyWrap">
<div style="padding : 50px 20px;">
<%-- 
<div style="display: none">
<a href="${cpath }/member/dailymovie">영화목록</a>
</div> --%>


<!-- 네이버에서 받아온 영화  띄우기 -->

<h2>주간 박스 오피스</h2>

<div id="weekly"></div>

</div>
</section>

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
				wrap.className='linkWrap'
				switch(key) {
				case 'title': 
					p.innerHTML =  data[key]; wrap.appendChild(p); break;
				case 'image':
					p.innerHTML = '<img src="' + data[key] + '" class="linkImg">'; wrap.appendChild(p); break;
				case 'link':
					p.innerHTML = '<a href="' + data[key] + 
						'" class="link">영화상세정보</a>';
					 wrap.appendChild(p); break;
				}
				if(p.innerText != ''){
					wrap.appendChild(p); 
				}
				}
				
			document.getElementById('weekly').appendChild(wrap)
		
		})

}
	
	
</script>
</body>
</html>