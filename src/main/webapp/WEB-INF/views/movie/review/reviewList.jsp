<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../header.jsp" %>
<style>
.wrap{
	width: 100%;
	height: 900px;
	background-color: yellow;
}
.warp>.top{
	margin-left: auto;
	margin-right: auto;
	margin-top: 100px;

	width: 100%;
	height: 200px;
	position: relative;
	background-color: black;
}
#recommend{
	display: flex;
	flex-flow: column;
	display: none;
	width:300px;
	height:300px;
	position: absolute;
	right:600px;
	top: 30px;
	background-color: red;
}
#recommend>a{
	text-decoration: underline;
}
</style>

<div class="wrap">
	
		<div class="top">
			<input type="text" name="search" id="search">
			<button class="btn">검색</button> 
			<div id="recommend">
				검색은?
				<a></a>
				<a></a>
				<a></a>
				<a></a>
				<a></a>
				<a></a>
				<a></a>
				<button class='btn2'>닫기</button>
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
	document.querySelector('.btn').onclick=function(event){
		const search = document.querySelector('input[name=search]').value
		if(search == '' || search == null){return}
		location.href='${cpath}/movie/review/result/?query='+encodeURI(search)
	}
	
</script>
</body>
</html>