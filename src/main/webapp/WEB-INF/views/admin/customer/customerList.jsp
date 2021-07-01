<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<section id = "bodyWrap">
<!-- 탈퇴회원     - del  -->
	<div class="boardList">
		<ul class="orderBy">
			<li><a href="${cpath }/admin/customer/customerList/?search=&keyword=&page=1&number=1&sorted=desc">[회원 가입순]</a></li>
			<li><a href="${cpath }/admin/customer/customerList/?search=&keyword=&page=1&number=2&sorted=desc">[등급순]</a></li>
			<li><a href="${cpath }/admin/customer/customerList/?search=&keyword=&page=1&number=3&sorted=desc">[올해 사용 금액순]</a></li>
			<li><a href="${cpath }/admin/customer/customerList/?search=&keyword=&page=1&number=4&sorted=desc">[작년 사용 금액순]</a></li>
			<li><a href="${cpath }/admin/customer/customerList/?search=&keyword=&page=1&number=5&sorted=desc">[탈퇴 회원 목록]</a></li>
	
	<!-- 옵션을 클릭하고 보여주는 페이지에서 asc desc 순서 클릭하면 순서대로 보여주기  -->
			<li>
				<a href="${cpath }/admin/customer/customerList/?search=${param.search }&keyword=${param.keyword }&page=1&number=${param.number}&sorted=asc"  style="width : 90px; font-size : 12px;">▲오름차순</a>
				<a href="${cpath }/admin/customer/customerList/?search=${param.search }&keyword=${param.keyword }&page=1&number=${param.number}&sorted=desc"  style="width : 90px; font-size : 12px;">▼내림차순</a>
			</li>
		</ul>
	
	
	<div class="content">
	<c:if test="${empty customerList}">
			<h2>회원 목록이 없습니다.</h2>
	</c:if>
	
	
	<c:if test="${not empty customerList }">
		<div class="listTitle2">
			<span>회원번호</span>
			<span>이름</span>
			<span>가입일</span>
			<span>등급</span>
			<span>올해사용금액</span>
			<span>전년도사용금액</span>
			<span>조회</span>
		</div>
		<c:forEach var="dto" items="${customerList}">
			<div  class="list2">
				<span>${dto.member_number}</span>
				<span>${dto.member_name}</span>
				<span>${dto.member_date}</span>
				<span>		
					<c:choose>
						<c:when test="${dto.member_grade  == 'P' }">
									플레티넘
						</c:when>
						<c:when test="${dto.member_grade  == 'G' }">
									골드
						</c:when>	
						<c:when test="${dto.member_grade  == 'V'}">
									VIP
						</c:when>	
						<c:when test="${dto.member_grade  == 'N' }">
									일반
						</c:when>		
					</c:choose>
				</span>
				<span><fmt:formatNumber value="${dto.amount_this }"/></span>
				<span>${dto.amount_last }</span>
				<span>
					<a href="${cpath}/admin/customer/customerRead/${dto.member_number}?search=${param.search }&keyword=${param.keyword }&page=${param.page}&sorted=${param.sorted}" class="btn5">조회하기</a>
				</span>
			</div>
		</c:forEach>

		
		<div class="pages">
			<c:if test="${paging.prev }">
			   	<a href="${cpath }/admin/customer/customerList?search=${param.search }&keyword=${param.keyword }&page=${paging.begin-1}&number=${param.number}&sorted=${param.sorted}">
			   	[이전]</a>
		   	</c:if>
			<c:forEach var="i" begin="${paging.begin }" end="${paging.end}">
				<c:if test="${paging.end ne 1}">
					<a href="${cpath }/admin/customer/customerList?search=${param.search }&keyword=${param.keyword }&page=${i}&number=${param.number}&sorted=${param.sorted}">[${i}]</a>
				</c:if>
			</c:forEach>
			<c:if test="${paging.next }">
				<p>
			   		<a href="${cpath }/admin/customer/customerList?search=${param.search }&keyword=${param.keyword }&page=${paging.end+1}&number=${param.number}&sorted=${param.sorted}">
			   		[다음]</a>
			   	</p>
		   	</c:if>
  	 	</div>
		</c:if>
	</div>

	
	</div>



		<div class="searchWrap cf">
			<form>	
			<select name="search">
				<option value="member_number">회원번호</option>			
				<option value="member_name">회원 이름</option>
				<option value="member_email">회원 아이디</option>
			</select>
				<input type="text" name="keyword">
				<input type="hidden" name="page" value="${param.page }">
				<input type="hidden" name="number" value="${param.number}">
				<input type="hidden" name="sorted" value="${param.sorted}">
				<div class="btn4">검색</div>
			</form>
		</div>
	
		<div>
			<div class="btn3" onclick="location.href='${cpath}/admin/customer/mail'" >회원 메일 발송</div>
		</div>
	</div>
</section>


<%@include file="../footer.jsp" %>