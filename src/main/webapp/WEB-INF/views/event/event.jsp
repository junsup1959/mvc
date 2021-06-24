<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../header.jsp"%>
<style>
* {
	margin: 0;
	padding: 0;
}

ul, li {
	list-style: none;
}

a {
	text-decoration: none;
	color: inherit;
}

.layer {
	display: none;
	width: 100%;
	height: 100%;
	justify-content: center;
	align-items: center;
	background: rgba(0, 0, 0, 0.5);
	position: fixed;
	left: 0;
	right: 0;
	top: 0;
	bottom: 0;
}

.layer .box {
	overflow: auto;
	width: 70%;
	height: 90%;
	padding: 20px 20px 60px;
	margin: 20px;
	background: #fff;
	position: relative;
}

.layer .close {
    position: absolute;
    right: 0;
    width: 30px;
    display: block;
    top: 20px;
    cursor:pointer;
}

.layer:target {
	display: flex;
	animation: open 0.5s;
}

@
keyframes open {
	from {opacity: 0;
}

to {
	opacity: 1;
}

}

.rgt {
	text-align: center;
	display: block;
	position: absolute;
	right: 15px;
	top: 45%;
	cursor:pointer;
}

.lft {
	text-align: center;
	display: block;
	position: absolute;
	left: 15px;
	top: 45%;
	cursor:pointer;
}

.bcont_wrap {
	width : 100%;
	margin : 0 auto;
	justify-content: center;
}
.bcont_wrap div {
	width : 700px;
	margin : 0 auto;
}
#bimg img {
	width: 100%
}


.b_param{
	position:relative;
	width:100%;
	height:100px;
	margin-bottom: 20px;
	border-bottom: groove;
}
#bdate{
	position: absolute;
	bottom: 10px;
	right: 200px;
}
#bdate::after{
    content: "~";
    font-size: 45px;
    position: absolute;
    bottom: 0px;
    right: -31px;
}

#edate{
	position: absolute;
	bottom: 10px;
	right: 80px;
}
#btitle{
    position: absolute;
    right: 450px;
    top: -7px;
}
.List_wrap{
	width: 1400px;
	height: 1000px;
	margin-left: auto;
	margin-right: auto;
	display: flex;
	flex-wrap: wrap;
}

.ev{
	display: flex;
	flex-flow: column;
	margin-left: 20px;
	margin-right: 20px;
	width: 300px;
	height: 350px;
    border: groove;
}
.ev>img{
	display: block;
	width: 295px;
	height: 250px;
	
}

.ev>.evtitle{
	display: block;
	width: 100%;
	text-align: center;
}
.evtdate{
	text-align: center;
}
.evtdate>span{
    margin-right: 10px;
}
#likey{
    position: absolute;
    left: 46px;
    top: 8px;
}
#likey-count{
    position: absolute;
    left: 91px;
    top: 4px;
    font-size: 15px;
}
</style>
<div class="e_wrap">
		<div class="">
			<h2>이벤트 리스트 cate : ${param.cate }</h2>
			<!-- 자바스크립트 수정필요 차후함. -->
		</div>
	<div class="List_wrap">
			<c:forEach var="board" items="${list }">
			<div class="ev">
				<img alt="파일첨부해줘요잉" src="${cpath }/upload/${board.board_file }">
				<!-- 이미지 첨부는 필수 -->
				<span class="evtitle" ><a href="#popup1" onclick="e_read(${board.board_number})">
				<b style="color:orange">[${board.board_store}점] </b>${board.board_title }</a></span>
			<div class="evtdate">
				<span >${board.board_bdate }</span> <span>${board.board_edate }</span>
			</div>	
			</div>	
			</c:forEach>
		</div>
	</div>
		<div id="popup1" class="layer">
			<div class="box">
				<a class="lft"><i class="xi-angle-left"></i></a>
				<a class="rgt"><i class="xi-angle-right"></i></a>
				<div class="b_param">
					<c:choose>
						<c:when test="${not empty login }">
							<i class="xi-heart-o xi-2x" id="likey" onclick="likey()"></i>
						</c:when>
						<c:otherwise>
							<i class="xi-heart-o xi-2x" id="likey"></i>
						</c:otherwise>
					</c:choose>
							<span id="likey-count">0</span>
					<span class="" id="btitle"></span>
					<span class="values" id="bdate"></span>
					<span class="values" id="edate"></span>
				</div>
				<div class="bcont_wrap">
					<div id="bimg" class=""></div>
					<div id="bcontent" class=""></div>
				</div>
				<a href="#" class="close"><i class="xi-close"></i></a>
			</div>
		</div>
	



<div id="bnumber" style="display: none;"></div> <!--  지우면 안됨 다음 글 추출하는 파라미터 담는곳 -->
<div id="cate" style="display: none;">${param.cate }</div>
<script>
	
	const e1 = document.querySelectorAll('.e1')
	const b_param = document.querySelector('.b_param')
	const bcontent= document.getElementById('bcontent')
	const right = document.querySelector('.rgt')
	const left = document.querySelector('.lft')
	const bnum = document.getElementById('bnumber')
	const cate = document.getElementById('cate')
	let flag = false;
	
		function getCount(number){
		let url = '${cpath}/event/read/like/'+number
		let opt = {
				method : "GET"
		}
		fetch(url,opt)
		.then(resp=>resp.text())
		.then(text=>{
			if(!text == 0){
				document.getElementById('likey-count').innerText = text;
			}
		})
	}
	
	function e_read(number){
		getCount(number);
		already(number);
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
		
		event.preventDefault()
		let url = '${cpath}/event/read/next/'+document.getElementById('bnumber').innerText+'/?cate='+cate.innerText
		const opt = {method : 'GET' }
		fetch(url,opt)
		.then(resp => resp.json())
		.then(json => {
			if(json !=null){
				bcontent.innerHTML = ""
					
				const bnumber= document.getElementById('bnumber')
				const btitle= document.getElementById('btitle')
				const bdate= document.getElementById('bdate')
				const edate= document.getElementById('edate')
				
			
				for(key in json){
					switch(key){
						case 'board_number': bnumber.innerText = json[key]; break
						case 'board_title' : btitle.innerText = json[key]; break
						case 'board_bdate' : bdate.innerText = json[key];  break
						case 'board_content' : bcontent.innerHTML = json[key]; break
								
						case 'board_edate' : edate.innerText = json[key]; break
						default : break
					}
				}
			}
				getCount(document.getElementById('bnumber').innerText);
				already(document.getElementById('bnumber').innerText);
		})
	}
		
	left.onclick = function(event){
		event.preventDefault()
		let url = '${cpath}/event/read/prev/'+document.getElementById('bnumber').innerText+'/?cate='+cate.innerText
		const opt = {method : 'GET' }
		fetch(url,opt)
		.then(resp => resp.json())
		.then(json => {
			if(json !=null){
				/* for(let i=0;i<childs.length;i++){
					childs[i].innerHTML=""
				} */
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
						case 'board_content' : bcontent.innerHTML = json[key];break
						case 'board_edate' : edate.innerText = json[key]; break
						default : break
					}
				}
			}
			getCount(document.getElementById('bnumber').innerText);	
			already(document.getElementById('bnumber').innerText);
		})
	}

	const BL=document.getElementById('likey');
	
	
	
	
	

	
	
	function already(number){
		if('${login.member_email}'==''){return flag}
		const url = '${cpath}/event/read/already/?board_number='+number+'&user_email=${login.member_email}'
		const opt = {
				method : "GET"
		}
		fetch(url,opt)
		.then(resp => resp.text())
		.then(text=>{
			if(text == 1){
				flag = true;
				BL.setAttribute('class','xi-heart xi-2x')
				BL.style.cursor = 'default'
				return flag;
			}else{
				flag =false;
				BL.setAttribute('class','xi-heart-o xi-2x')
				BL.style.cursor = 'pointer'
				return flag;
			}
		})
	}

	
	function likey (){
		if('${login.member_email}'==''){alert('로그인을 하셔야합니다,');location.href='${cpath}/member/login'}
		if(flag){return;}
		
		const obj={
				board_number :bnumber.innerText,
				user_email :'${login.member_email}'
		}
		const url='${cpath}/event/like/'
		const opt={
				method : "POST",
				body : JSON.stringify(obj),
				headers: {
					'Content-Type' : 'application/json; charset=utf-8'
				}
		}
		fetch(url,opt).then(resp=>resp.text())
		.then(text=>{
				console.log(text)
				if(text != 'n'){
				BL.setAttribute('class','xi-heart xi-2x')
				BL.style.cursor = 'default'
				document.getElementById('likey-count').innerText = text;
				flag = true;
			}
		})
	}


	
</script>



<%@include file="../footer.jsp"%>