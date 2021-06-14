<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp"%>

<div>
	<div>
		<span>글번호</span>
		<span>제목</span>
		<span>지점</span>
		<span>공지/이벤트</span>
		<span>날짜</span>
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
		<span>${dto.board_date}</span>
	</div>
	<div>
		${dto.board_content }
	</div>
	<div>
		<a href="${cpath}/admin/board/update/${board_number}">수정</a>
		<a href="${cpath}/admin/board/delete/${board_number}">삭제</a>
	</div>
</div>




<%@include file="../footer.jsp"%>