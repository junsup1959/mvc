<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>
  <style>
    *{margin:0;padding:0;}
    ul,li{list-style:none;}
    a{text-decoration:none;color:inherit;}
    .layer{
    display:none;
    width: 100%;
    height:100%;
    justify-content:center;
    align-items:center;
    background:rgba(0,0,0, 0.5);
    position:fixed;
    left:0;right:0;top:0;bottom:0;
    }
    .layer .box{
    overflow:auto;
    width:80%;
    height:80%;
    padding:20px 20px 60px;
    margin:20px;
    background:#fff;
    position:relative;
    }
    .layer .close{
    position:absolute;
    right:20px;bottom:20px;
    display:block;
    background:#09F;
    color:#fff;
    text-align:center;
    padding:5px 20px;
    font-size:13px;}
    
    .layer:target{
    display:flex;
    animation:open 0.5s;
    }

    @keyframes open {
      from {opacity:0;} to {opacity:1;}
    }


.rgt {
	text-align:center;
    content: '*';
    width: 30px; /* 사이즈 */
    height: 30px; /* 사이즈 */
    border-top: 5px solid #121212; /* 선 두께 */
    border-right: 5px solid #121212; /* 선 두께 */
    display: block;
    position: absolute;
  	right: 15px;
    top: 45%;
}

.lft {
	text-align:center;
    content: '*';
    width: 30px; /* 사이즈 */
    height: 30px; /* 사이즈 */
    border-top: 5px solid #121212; /* 선 두께 */
    border-right: 5px solid #121212; /* 선 두께 */
    display: block;
    position: absolute;
  	left: 15px;
    top: 45%;
}

  </style>
<div class="e_wrap">
	<div class="">
		<div class="">
			<h2>이벤트 리스트</h2><!-- 자바스크립트 수정필요 차후함. -->
		</div>
		<div class="e1">
			<c:forEach var="board" items="${list }">
			<div class="">
				<img src="${board_file }"><!-- 이미지 첨부는 필수 -->
				<span><a href="#popup1" onclick="e_read(${board.board_number})">${board.board_title }</a></span> <!-- 읽기 이동 -->
				<span>${board.board_bdate }</span>
				<span>${board.board_edate }</span>
			</div>
			</c:forEach>
		</div>
	  <div id="popup1" class="layer">
	    <div class="box">
	    
	    		<button class="lft">이전</button>
	    		<button class="rgt">다음</button>
	  		 	<div class="">
					<span class="">글번호</span>
					<span class="">제목</span>
					<span class="">시작일</span>
					<span class="">마감일</span>
				</div>
				<div class="b_param">
					<span class="" id="bnumber"></span>
					<span class="" id="btitle"></span>
					<span class="" id="bdate"></span>
					<span class="" id="edate"></span>
				</div>
				<div id="bcontent" class="">
				</div>
	      <a href="#" class="close">닫기</a>
	    </div>
	  </div>
	</div>
	<div>
		<button>
			<a class="e1" href="${cpath }/event/?search=${param.search }&keyword=${param.keyword }&page=${param.page+1}" data-transition="slide">
			다음
			</a>
		</button>
	</div>
</div>




<script>
	const e1 = document.querySelectorAll('.e1')
	const b_param = document.querySelector('.b_param')
	const bcontent= document.getElementById('bcontent')
	const childs= b_param.childNodes
	const right = document.querySelector('.rgt')
	const left = document.querySelector('.lft')
	const bnum = document.getElementById('bnumber')
	
	
	function e_read(number){
		let url = '${cpath}/event/read/'+number
		const opt = {method : 'GET' }
		fetch(url,opt)
		.then(resp => resp.json())
		.then(json => {
			console.log(json)
			const bnumber= document.getElementById('bnumber')
			const btitle= document.getElementById('btitle')
			const bdate= document.getElementById('bdate')
			const edate= document.getElementById('edate')
			
			
			for(key in json){
				
				switch(key){
				case 'board_number': bnumber.innerText = json[key]; break
				case 'board_title' : btitle.innerText = json[key]; break
				case 'board_bdate' : bdate.innerText = json[key]; break
				case 'board_content' : bcontent.innerHTML = json[key]; break
				case 'board_edate' : edate.innerText = json[key]; break
				default : break
				}
			}
		})
	}
	right.onclick = function(event){
		let url = '${cpath}/event/read/next/'+bnum.innerText
		const opt = {method : 'GET' }
		fetch(url,opt)
		.then(resp => resp.json())
		.then(json => {
			console.log(json)
			for(let i=0;i<childs.length;i++){
				childs[i].innerHTML=""
				}
			bcontent.innerHTML = ""
				
		const bnumber= document.getElementById('bnumber')
		const btitle= document.getElementById('btitle')
		const bdate= document.getElementById('bdate')
		const edate= document.getElementById('edate')
		
		
		for(key in json){
			
			switch(key){
			case 'board_number': bnumber.innerText = json[key]; break
			case 'board_title' : btitle.innerText = json[key]; break
			case 'board_bdate' : bdate.innerText = json[key]; break
			case 'board_content' : bcontent.innerHTML = json[key]; break
			case 'board_edate' : edate.innerText = json[key]; break
			default : break
			}
		}
	})
}
		
	left.onclick = function(event){
		let url = '${cpath}/event/read/prev/'+bnum.innerText
		const opt = {method : 'GET' }
		fetch(url,opt)
		.then(resp => resp.json())
		.then(json => {
			console.log(json)
			for(let i=0;i<childs.length;i++){
				childs[i].innerHTML=""
				}
			bcontent.innerHTML = ""
				
		const bnumber= document.getElementById('bnumber')
		const btitle= document.getElementById('btitle')
		const bdate= document.getElementById('bdate')
		const edate= document.getElementById('edate')
		
		
		for(key in json){
			
			switch(key){
			case 'board_number': bnumber.innerText = json[key]; break
			case 'board_title' : btitle.innerText = json[key]; break
			case 'board_bdate' : bdate.innerText = json[key]; break
			case 'board_content' : bcontent.innerHTML = json[key]; break
			case 'board_edate' : edate.innerText = json[key]; break
			default : break
			}
		}
	})
}
	
	
</script>



<%@include file="../footer.jsp" %>