<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../header.jsp" %>
<h1>${movie.title }</h1>
<div>
<span><img>이미지 : 패스 -_-;;; </span>
<span>제작일 : ${movie.pubDate }</span>
<span>감독 : ${movie.director }</span>
<span>배우 : ${movie.actor }</span>
<span>네이버 링크 : ${movie.link }</span>
<span>네이버 평점 : ${movie.userRating }</span>
<span>무비코드(확인용) - ${movie.moviecode }</span>
	<div>
		<h1>리뷰 보드 영역</h1>
		<span>우리 사이트 평점</span>
		<div>
			<div>작성자${login.member_nick}</div>
			<div>내용 input typte text</div>
			<div>작성일시(목록 뛰울때만)</div>
			<div>평점-> 클릭하면 input hidden에 값 입력</div>
			<div>좋아요/싫어요??? 다른 db table로 구현</div>	
			<div>
				<form method="post">
					<input type="text" name="writer" value="${login.member_nick }" readonly="readonly">
					<textarea name="content">내용 집어 넣자</textarea>
					<span id="rate"><i class="xi-heart-o"></i><i class="xi-heart-o"></i><i class="xi-heart-o"></i><i class="xi-heart-o"></i>
					<i class="xi-heart-o"></i></span>
					<input type="number"" name="rating" readonly="readonly">
					<input type="hidden" name="movie_name" value="${movie.title }">
					<input type="hidden" name="movie_code" value="${movie.moviecode }">
					<button>작성</button>
				</form>
			</div>
		</div>
	</div>
</div>

<script>
const rate = document.getElementById('rate').children
const rr = document.getElementById('rate')

for(let i=0;i<rate.length;i++){
	rate[i].onmouseover=function(event){
		rate[i].setAttribute('class','xi-heart')
		if(i != 0){
			for(let b=0;b<i;b++){
				rate[b].setAttribute('class','xi-heart')
			}
		}
			for(let c=rate.length-1;c>i;c--){
				rate[c].setAttribute('class','xi-heart-o')
			}
	}
}
rr.addEventListener("click",function(){
	let count=0;
	for(let i=0;rate.length;i++){
		var value =rate[i].getAttribute('class')
		if(value =='xi-heart'){
			count+=1;
		}
	}
	document.querySelector('input[name=rating]').value=count
})

</script>
</body>
</html>