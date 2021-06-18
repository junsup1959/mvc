<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp"%>

<section id="bodyWrap">
	<div class="noticeWrap">

	<ul class="cf read">
		<li>
			<p>글번호</p>
			<span>${dto.board_number}</span> 
		</li>
		<li>
			<p>제목</p>
			<span>${dto.board_title}</span>
		</li>
		<li>
			<p>지점</p>
			<span>${dto.board_store}</span>
		</li>
		<li>
			<p>구분</p>
			<c:choose>
				<c:when test="${board_notice eq 'N'}">
						<span>공지</span>
				</c:when>
				<c:otherwise>
					<span>이벤트</span>
				</c:otherwise>
			</c:choose>
		</li>
		<li>
			<p>시작날짜</p>
			<span>${dto.board_bdate}</span>
		</li>
		<li>
			<p>마감날짜</p>
			<span>${dto.board_edate}</span>
		</li>
		<li>
			<span>${dto.board_content }</span>
		</li>
	</ul>
	
	<ul class="prev-next cf">
		<c:if test="${not empty next }">
		<li>
			[다음글]<a href="${cpath}/admin/board/read/${next.board_number}?search=${param.search }&keyword=${param.keyword }&page=${param.page}">${next.board_title}</a>
		</li>
		</c:if>
		<li>
			[현재] <a href="${cpath}/admin/board/read/${dto.board_number }?search=${param.search }&keyword=${param.keyword }&page=${param.page}">${dto.board_title }</a>
		</li>
		<c:if test="${not empty prev }">
		<li>
			[이전글] <a href="${cpath}/admin/board/read/${prev.board_number}?search=${param.search }&keyword=${param.keyword }&page=${param.page}">${prev.board_title}</a>
		</li>
		</c:if>
	</ul>
	<div class="cf btnWrap">
		<div onclick="location.href='${cpath}/admin/board/update/${dto.board_number}?search=${param.search }&keyword=${param.keyword }&page=${param.page}'"  class="btn3">수정</div>
		<div id="del" class="btn3" style="right: 10px">삭제</div>
	</div>
	</div>
</section>

<script>
const btn = document.getElementById('del')
btn.onclick=function(event){
	let btntest= confirm('정말 삭제 하시겠습니까?')
	if(btntest==true)
		location.href='${cpath}/admin/board/delete/${dto.board_number}?search=${param.search }&keyword=${param.keyword }&page=${param.page}'
				
}

</script>


<%@include file="../footer.jsp"%>