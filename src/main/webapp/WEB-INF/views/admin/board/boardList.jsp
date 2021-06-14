<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>

<div>

	<div>
		<span>글번호</span>
		<span>제목</span>
		<span>날짜</span>
		<span>부서</span>
	</div>
	<c:forEach var="board" items="${list}">
	<div>
		<span>${board.board_number}</span>
		<span><a href="${cpath}/admin/board/read/${board.board_number}">${board.board_title}<a></span>
		<span>${board.board_date}</span>
		<span>${board.board_store }</span>
	</div>
	</c:forEach>
	<br>
	<a href="${cpath}/admin/board/write"><input type="button" value="글쓰기"></a>
	<br>
</div>

<%@include file="../footer.jsp" %>