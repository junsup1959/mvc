<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>

<section id="bodyWrap">
	<div class="boardList">
	<c:if test="${empty list}">
		<h2>입력된 게시글이 없습니다.</h2>
	</c:if>

	<c:if test="${not empty list }">
		<div class="tplist">
			<ul>
				<li onclick="location.href='${cpath}/admin/board/?search=${param.search }&cate=1&keyword=${param.keyword }&page=${param.page}'">[전체목록]</li>
				<li onclick="location.href='${cpath}/admin/board/?search=${param.search }&cate=3&keyword=${param.keyword }&page=${param.page}'">[공지]</li>
				<li onclick="location.href='${cpath}/admin/board/?search=${param.search }&cate=2&keyword=${param.keyword }&page=${param.page}'">[진행중인 이벤트]</li>
				<li onclick="location.href='${cpath}/admin/board/?search=${param.search }&cate=4&keyword=${param.keyword }&page=${param.page}'">[지난 이벤트]</li>
				<li onclick="location.href='${cpath}/admin/board/?search=${param.search }&cate=&keyword=${param.keyword }&page=${param.page}'">[이벤트 전체목록]</li>
			</ul>
		</div>
		<div class="content">
			<div class="listTitle">
				<span>글번호</span>
				<span>제목</span>
				<span>지점</span>
				<span>시작날짜</span>
				<span>종료날짜</span>
			</div>
			
			<c:forEach var="board" items="${list}">
				<div class="list" onclick="location.href='${cpath}/admin/board/read/${board.board_number}?search=${param.search }&cate=${param.cate}&keyword=${param.keyword }&page=${param.page}'">
					<span>${board.board_number}</span>
					<span>${board.board_title}</span>
					<span>${board.board_store }</span>
					<span>${board.board_bdate}</span>
					<span>${board.board_edate}</span>	
				</div>
			</c:forEach>
		</div>

		<div class="pages">
			<c:if test="${paging.prev }">
			   	<a href="${cpath }/admin/board/?search=${param.search }&keyword=${param.keyword }&cate=${param.cate}&page=${paging.begin-1}">
			   	[이전]</a>
		   	</c:if>
			<c:forEach var="i" begin="${paging.begin }" end="${paging.end}">
				<a href="${cpath }/admin/board/?search=${param.search }&keyword=${param.keyword }&cate=${param.cate}&page=${i}">[${i}]</a>
			</c:forEach>
			<c:if test="${paging.next }">
			   	<a href="${cpath }/admin/board/?search=${param.search }&keyword=${param.keyword }&cate=${param.cate}&page=${paging.end+1}">
			   	[다음]</a>
		   	</c:if>
		</div>
	</c:if>

		<div class="searchWrap cf">
			<form id="searchB">
			<select name="search">
				<option value="board_title">제목</option>
				<option value="board_content">내용</option>
			</select>
			<input type="text" name="keyword">
			<input type="hidden" name="page" value="${param.page }">
			<input type="hidden" name="cate" value="${param.cate }">
			<div class="btn4">검색</div>
			</form>
		</div>
		
		<div class="btn3" onclick="location.href='${cpath}/admin/board/write'">
			글쓰기
		</div>	
	</div>
</section>

<script>
 const btn = document.querySelector('.btn4')
 const searchForm= document.getElementById('searchB')
 btn.onclick=function(event){
	 searchForm.submit();
 }

</script>


<%@include file="../footer.jsp" %>