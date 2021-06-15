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
<!-- 		조회하면 보이는 목록 -->
<!-- 		<span>이름</span> -->
<!-- 		<span>ID</span> -->
<!-- 		<span>전화번호</span> -->
<!-- 		<span>주소</span> -->
<!-- 		<span>성별</span> -->

<c:if test="${not empty customerList }">
	<div>
		<span>회원번호</span>
		<span>회원가입 일시</span>
		<span>등급</span>
		<span>올해 사용금액</span>
		<span>전년도 사용금액</span>
	</div>
	<c:forEach var="dto" items="${list}">
		<div>
			<span>${dto.member_number}</span>
			<span>${dto.member_date}</span>
			<span>${dto.member_grade }</span>
			<span>${dto.amount_this }</span>
			<span>${dto.amount_last }</span>
			<span><a href="${cpath}/admin/customer/read/${dto.member_number}?search=${param.search }&keyword=${param.keyword }&page=${param.page}">조회하기</a></span>
		</div>
	</c:forEach>
	<br>
	<c:if test="${paging.prev }">
	   	<a href="${cpath }/admin/customer/?page=${paging.begin-1}">
	   	[이전]</a>
   	</c:if>
	<c:forEach var="i" begin="${paging.begin }" end="${paging.end}">
		<a href="${cpath }/admin/customer/?search=${param.search }&keyword=${param.keyword }&page=${i}">[${i}]</a>
	</c:forEach>
	<c:if test="${paging.next }">
	   	<a href="${cpath }/admin/customer/?page=${paging.end+1}">
	   	[다음]</a>
   	</c:if>

</c:if>
	<br>
	<form>
<!-- 	옵션을 클릭하고 보여주는 페이지에서 asc desc 순서 클릭하면 순서대로 보여주기 -->
	<select name="search">
		<option value="board_title">회원가입 일시</option>
		<option value="board_content">등급</option>			
		<option value="board_content">올해 사용금액 순</option>
		<option value="board_content">전년도 사용금액 순</option>
	</select>
		<input type="text" name="keyword">
		<input type="hidden" name="page" value="${param.page }">
		<button>검색</button>
	</form>
</div>

<%@include file="../footer.jsp" %>