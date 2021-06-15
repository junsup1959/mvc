<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>

<div>

<c:if test="${empty customerList}">
	<h2>입력된 게시글이 없습니다.</h2>
</c:if>


<!-- 셀렉트박스 or 목록하나 생성 -->
<!-- 회원번호 , 이름 , 이메일, 전화번호, 주소, 등급, 가입일, 올해사용금액, 전년도사용금액 -->
<!-- 고객관리    - 셀렉트 박스에 등급, 가입, 사용금액 순 -->
<!-- ----------- -->
<!-- 탈퇴회원     - del  -->
<!-- ------------ -->

<c:if test="${not empty customerList }">
	<div>
		<span>회원번호</span>
		<span>회원가입 일시</span>
		<span>이름</span>
		<span>ID</span>
		<span>연락처</span>
		<span>주소</span>
		<span>성별</span>
	</div>
	<c:forEach var="board" items="${list}">
	<div>
		<span>${board.board_number}</span>
		<span><a href="${cpath}/admin/board/read/${board.board_number}?search=${param.search }&keyword=${param.keyword }&page=${param.page}">${board.board_title}<a></span>
		<span>${board.board_date}</span>
		<span>${board.board_store }</span>
	</div>
	</c:forEach>
	<br>
	<c:if test="${paging.prev }">
	   	<a href="${cpath }/admin/board/?page=${paging.begin-1}">
	   	[이전]</a>
   	</c:if>
	<c:forEach var="i" begin="${paging.begin }" end="${paging.end}">
		<a href="${cpath }/admin/board/?search=${param.search }&keyword=${param.keyword }&page=${i}">[${i}]</a>
	</c:forEach>
	<c:if test="${paging.next }">
	   	<a href="${cpath }/admin/board/?page=${paging.end+1}">
	   	[다음]</a>
   	</c:if>

</c:if>
	<br>
	<form>
	<select name="search">
		<option value="board_title">제목</option>
		<option value="board_content">내용</option>
	</select>
	<input type="text" name="keyword">
	<input type="hidden" name="page" value="${param.page }">
	<button>검색</button>
	</form>
	<a href="${cpath}/admin/board/write"><input type="button" value="글쓰기"></a>
</div>

<%@include file="../footer.jsp" %>