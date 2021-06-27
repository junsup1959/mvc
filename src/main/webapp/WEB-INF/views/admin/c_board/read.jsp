<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp"%>

<section id="bodyWrap">
	<div class="noticeWrap">

	<ul class="cf read">
		<li>
			<p>글번호</p>
			<span>${dto.co_idx}</span> 
		</li>
		<li>
			<p>제목</p>
			<span>${dto.co_title}</span>
		</li>
		<li>
			<p>지점</p>
			<span>${dto.co_writer}</span>
		</li>
		<li>
			<p>날짜</p>
			<span>${dto.co_date}</span>
		</li>
		<li>
			<span>${dto.co_content }</span>
		</li>
	</ul>
	
	<ul class="prev-next cf">
		<c:if test="${not empty next }">
		<li>
			[다음글]<a href="${cpath}/admin/c_board/read/${next.co_idx}?search=${param.search }&keyword=${param.keyword }&page=${param.page}">${next.co_title}</a>
		</li>
		</c:if>
		<li>
			[현재] <a href="#">${dto.co_title }</a>
		</li>
		<c:if test="${not empty prev }">
		<li>
			[이전글] <a href="${cpath}/admin/c_board/read/${prev.co_idx}?search=${param.search }&keyword=${param.keyword }&page=${param.page}">${prev.co_title}</a>
		</li>
		</c:if>
	</ul>
	<c:if test="${dto.co_num == ad_login.admin_num}">
		<div class="cf btnWrap">
			<div onclick="location.href='${cpath}/admin/c_board/update/${dto.co_idx}?search=${param.search }&keyword=${param.keyword }&page=${param.page}'"  class="btn3">수정</div>
			<div id="del" class="btn3" style="right: 10px">삭제</div>
		</div>
	</c:if>
	<c:if test="${not empty ad_login }">	
		<div>
			<form method="post">
				<input type="hidden" name="" value="${ad_login.admin_name}" required="required">
				<input type="hidden" name="" value="${dto.co_idx }">
				<textarea name="" style="width: 300px;height: 300px;"></textarea>
				<br><input type="submit" value="작성">
			</form>
		</div>
	</c:if>
		<div>
		</div>
	</div>
</section>

<script>
const btn = document.getElementById('del')
btn.onclick=function(event){
	let btntest= confirm('정말 삭제 하시겠습니까?')
	if(btntest==true)
		location.href='${cpath}/admin/c_board/delete/${dto.co_idx}?search=${param.search }&keyword=${param.keyword }&page=${param.page}'
				
}

</script>


<%@include file="../footer.jsp"%>