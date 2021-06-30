<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../header.jsp" %>
<style>
.wrap{
	width : 900px;
	height: 900px;
	margin : 0 auto;
	padding-top : 100px;
}
.warp .top{
	position: relative;
	width: 100%;
	height: 200px;
	margin : 0 auto;
	background-color: black;
}

#search {width : 500px; height: 50px; margin-left : 100px; line-height: 50px; padding: 5px 10px; border : 1px solid #666; border-radius: 5px;}
button.btn1 {width : 120px;}
#recommend{
	position: absolute;
	display: flex;
	flex-flow: column;
	display: none;
	width:400px;
	height:400px;
	right :350px;
	top : 250px;
	background-color: #ccc;
	font-size: 20px;
	overflow-y: scroll;
}
#recommend>a{
	display : block;
	height : 40px;
	line-height : 40px;
	text-decoration: underline;
}
</style>

<section id="bodyWrap">
<div>
<h2>영화검색/리뷰작성</h2>
<div class="wrap">
	
		<div class="top">
			<input type="text" name="search" id="search" placeholder="검색할 영화를 입력하세요">
			<button class="btn1">검색</button> 
			<div id="recommend">
				검색은?
				<a></a>
				<a></a>
				<a></a>
				<a></a>
				<a></a>
				<a></a>
				<a></a>
				<a></a>
				<a></a>
<!-- 				<button class="btn1">닫기</button> -->
			</div>
		</div>
		<div class="bottom">
			<div class="bottom selector">
				<span>일간 박스오피스</span>
				<span>주간 박스오피</span>
				<span>뭘 넣을까나</span>
			</div>
			<div class="bottom title">
			목록 상단
				<span>제목</span>
		         <span>제작일</span>
		         <span>감독</span>
		         <span>배우</span>
		         <span>평점</span>
			</div>
			<div class="bottom list">
			목록 하단 띄울꺼	
				<span>title</span>
		         <span>pubDate</span>
		         <span>director</span>
		         <span>actor</span>
		         <span>userRating</span>
			</div>
		</div>
</div>
</div>
</section>
<script>
	const recommend = document.getElementById('recommend');
	
	search.addEventListener("keyup",function(event){
		for(let i=0;i<recommend.children.length;i++){
			let a = recommend.children[i]
			a.innerText = '';
		}
		recommend.style.display='flex';
		const url = '${cpath}/movie/review/autoSearch/?query='+event.target.value;
		const opt ={method : 'GET'}
		fetch(url,opt).then(resp => resp.json())
		.then(json=>{
			console.log(json);
			if(json==null||json==''){recommend.style.display='none'; return;}
			const list = JSON.parse(json)
			for(let i=0;i<list.items.length;i++){
				let val = list.items[i].title
				let a = recommend.children[i]
				
				a.innerHTML = val;
				val = val.replace('<b>','');
				val = val.replace('</b>',' ');
				a.setAttribute('href','${cpath}/movie/review/result?query='+val)
			}
		})
	})
	document.querySelector('.btn1').onclick=function(event){
		const search = document.querySelector('input[name=search]').value
		if(search == '' || search == null){return}
		location.href='${cpath}/movie/review/result/?query='+encodeURI(search)
	}
	
</script>
</body>
</html>