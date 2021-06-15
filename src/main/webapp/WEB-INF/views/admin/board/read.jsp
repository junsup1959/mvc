<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp"%>

<div>
	<div>
		<span>글번호</span>
		<span>제목</span>
		<span>지점</span>
		<span>공지/이벤트</span>
		<span>시작날짜</span>
		<span>마감날짜</span>
	</div>
	<div>
		<span>${dto.board_number}</span>
		<span>${dto.board_title}</span>
		<span>${dto.board_store}</span>
	
	<c:choose>
		<c:when test="${board_notice eq 'N'}">
			<span>공지</span>
		</c:when>
		<c:otherwise>
			<span>이벤트</span>
		</c:otherwise>
	</c:choose>
		<span>${dto.board_bdate}</span>
		<span>${dto.board_edate}</span>
	</div>
	<div>
		${dto.board_content }
	</div>
	<div>
		<a href="${cpath}/admin/board/update/${board_number}?search=${param.search }&keyword=${param.keyword }&page=${param.page}">수정</a>
		<button id="del">삭제</button>
	</div>
</div>

<script>
const btn = document.getElementById('del')
btn.onclick=function(event){
	let btntest= confirm('정말 삭제 하시겠습니까?')
	if(btntest==true)
		location.href='${cpath}/admin/board/delete/${board_number}?search=${param.search }&keyword=${param.keyword }&page=${param.page}'
				
}

</script>


<%@include file="../footer.jsp"%>