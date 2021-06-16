<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>
<div>
	<div>
		<div>
			<h2>이벤트 리스트</h2><!-- 자바스크립트 수정필요 차후함. -->
		</div>
		<div id="e_list">
			<c:forEach var="board" items="${list }">
			<div>
				<img src="${board_file }"><!-- 이미지 첨부는 필수 -->
				<span><a onclick="rrr(${board.board_number})">${board.board_title }</a></span> <!-- 읽기 이동 -->
				<span>${board.board_bdate }</span>
				<span>${board.board_edate }</span>
			</div>
			</c:forEach>
		</div>
		<div id="e_read" style="display: none;">
		
		</div>
		<div>
			<a href="${cpath }/event/?search=${param.search }&keyword=${param.keyword }&page=${param.page+1}" data-transition="slide">다음</a>
			<!-- 목록 추가 버튼 -->
		</div>
	</div>
</div>
<script>
	const list= document.getElementById('e_list')
	
	const read = document.getElementById('e_read')
	function rrr(number){
		list.style.display='none'
		if(list.style.display=='none'){console.log('list 성공')}
		read.style.display ='block'
		if(read.style.display ='block'){console.log('read 성공')}
		let url = '${cpath}/event/read/'+number
		const opt = {method : 'GET' }
		fetch(url,opt)
		.then(resp => resp.json())
		.then(json => {
			console.log(json)
			
			
			for(key in json){
				const div = document.createElement('div')
				const span = document.createElement('span')
				switch(key){
				case 'board_number': span.innerText = json[key]; break
				case 'board_title' : span.innerText = json[key]; break
				case 'board_bdate' : span.innerText = json[key]; break
				case 'board_content' : div.innerHTML = json[key]; break
				case 'board_edate' : span.innerText = json[key]; break
				default : break
				}
				read.appendChild(div)
				div.appendChild(span)
			}
		})
	}
</script>

<%@include file="../footer.jsp" %>