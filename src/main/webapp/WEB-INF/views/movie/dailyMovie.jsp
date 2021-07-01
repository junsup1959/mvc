<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<section id="bodyWrap">
<div style="padding : 50px 20px;">
<h2>일간 순위</h2>


 <div style="display: none">
<a href="${cpath }/member/dailymovie">영화목록</a>
</div>


<!-- 네이버에서 받아온 영화  띄우기 -->
<div id="daily"></div>

</div>
</section>



<script>

// 요소명.setStlye({key : value, key : value ...}) 형식으로 스타일 만드는 함수
/// CSSStyleDeclaration 일치시켜야함. css 스타일 과  CSSStyleDeclaration 다를경우 에러발생 
// ex) cssstlye에서는 flex-wrap 이지만 CSSStyleDeclaration에서는 flexWrap이다. 찾느라 고생함..ㅠ
// 주로 margin-left  => marginLeft 이런식으로 바뀌는듯

	Element.prototype.setStyle = function(styles) {
		for (let k in styles) this.style[k] = styles[k];
		return this;
	};
	
	const test1 = '${dailyMovie }'
		
	const test2 = JSON.parse(test1)
	
	for(let i = 0;i< test2.boxOfficeResult.dailyBoxOfficeList.length ; i++ ){
		const movieName = test2.boxOfficeResult.dailyBoxOfficeList[i].movieNm
		const client_id = "p3EkwlpyD99frDpNN5th";
		const client_secret = "_t4XeBaQvU";
		const encText = encodeURI(movieName);
		const url = "https://cors-anywhere.herokuapp.com/https://openapi.naver.com/v1/search/movie.json?query=" + encText; // json 결과
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
			const wrap = document.createElement('div')
			const data = json.items[0]
			for(key in data) {
			console.log(key)
				
				switch(key) {
				case 'title': 
					const span = document.createElement('span')
					span.setStyle({
						display:'inline-block',
						position: 'absolute',
						bottom: '50px',
					    left: '20px'
					})
					span.innerHTML =  data[key]
					wrap.appendChild(span)
					break;
				case 'image':
					const span1 = document.createElement('span')
					span1.style.display = 'inline-block'
					span1.innerHTML = '<img src="' + data[key] + '" style="width:200px;">'
					wrap.appendChild(span1)
					break;
			}
							
		}
			
			document.getElementById('daily').appendChild(wrap)
			wrap.setStyle({
				position: 'relative',
		      	marginLeft: '10px',
		      	width: '200px',
		      	height: '300px',
		      	marginTop: '50px'
		      	overflow : 'hidden'
			})
		})
		
	}
	
	document.getElementById('daily').setStyle({
		display : 'flex',
		flexWrap: "wrap",
		justifyContent: "space-evenly",
		width : '1200px',
		hieght : '1000px',
		marginLeft: 'auto',
		marginRight: 'auto'
	})
		 

</script>
</body>
</html>