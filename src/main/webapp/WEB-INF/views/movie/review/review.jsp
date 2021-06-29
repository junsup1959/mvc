<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../header.jsp" %>
<h1>${movie.title }</h1>
<div>
	<div>
		<span><img>이미지 : 패스 -_-;;; </span><br>
		<span>제작일 : ${movie.pubDate }</span><br>
		<span>감독 : ${movie.director }</span><br>
		<span>배우 : ${movie.actor }</span><br>
		<span>네이버 링크 : ${movie.link }</span><br>
		<span>네이버 평점 : ${movie.userRating }</span><br>
		<span>무비코드(확인용) - ${movie.moviecode }</span><br>
		<span id="rate">우리 사이트 평점 토탈(새로 보드 만들어야함)<i class="xi-heart-o"></i><i class="xi-heart-o"></i><i class="xi-heart-o"></i><i class="xi-heart-o"></i>
			<i class="xi-heart-o"></i></span><br>
		함수확인용<input type="number" name="rating" readonly="readonly"><br>
	</div>
	<div>
		<div>
			<span>글번호?</span><!-- 필요할까? 말까? 고민 -->
			<span>닉네임</span>
			<span>내용</span>
			<span>작성일</span>
		</div>
		<c:forEach var="review" items="${list }">
			<div class="review">
				<span>${review.idx }</span><!-- 외래키 잡고 댓글 -->
				<span>${review.writer }</span>
				<span>${review.content }</span>
				<span>${review.wdate }</span>
				<button onclick="modify(${review.idx})">수정</button>
			</div>
		</c:forEach>
	</div>
	<c:if test="${not empty login }">
		<div>	
			<form method="post">
			<input type="text" name="writer" value="${login.member_nick }" readonly="readonly">
			<textarea name="content" required="required">내용 집어 넣자</textarea>
			<input type="hidden" name="movie_title" value="${movie.title }">
			<input type="hidden" name="movie_code" value="${movie.moviecode }">
			<button>작성</button>
			</form>
		</div>
	</c:if>
</div>
<script>
//////////////////////////좋아요 카운팅 자바스크립트/////////////////////////////
const rate = document.getElementById('rate').children
const rSelect = document.getElementById('rate')
let flag=false;

for(let i=0;i<rate.length;i++){
	rate[i].onmouseover=function(event){
		if(flag){return}
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
rSelect.addEventListener("click",function(){
	if(!flag){
		let count=0;
		for(let i=0;i<rate.length;i++){
			if(rate[i].getAttribute('class')=='xi-heart'){
				count+=1;
			}
		}
		document.querySelector('input[name=rating]').value=count;
		flag=true;
	}else{
		flag=false;
	}
})
//////////////////////////좋아요 카운팅 자바스크립트/////////////////////////////
<<<<<<< HEAD

//////////// 수정 자바 스크립트/////////////////////////////////////////////////////

leg Rflag=false;
const rvnode = document.querySelectorAll('.review')

function modify(data){
	if(Rflag){gomodify() return}
	for(let i =0;i<rvnode.length;i++){
		if(rvnode[i].children[0].innerText==data){
		let val = rvnode[i].children[2].innerText;
			rvnode[i].children[2].innerHTML="<textarea>"+val+"</textarea>";
		}	
	}
	
}

=======
>>>>>>> branch 'master' of https://github.com/Minb8730/MVCProject.git
</script>
</body>
</html>