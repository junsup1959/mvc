<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>



	<section id="bodyWrap">
	<h2>고객정보</h2>
	<div class="conWrap">
	<div>
		<span>회원번호</span>
		<p>${dto.member_email }</p>
	</div>
	<div>
		<span>이름</span>
		<p>${dto.member_name }</p>
	</div>
	<div>
		<span>회원가입 일시</span>
		<p>${dto.member_date}</p>
	</div>
	<div>
		<span>ID</span>
		<p>${dto.member_email }</p>
	</div>
	<div>		
		<span>등급</span>
		<p>
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
		</p>
	</div>
	<div>
		<span>주소</span>
		<p>${dto.member_addr1}${dto.member_addr2}</p>
	</div>
	<div>
		<span>성별</span>
		<p>${dto.member_gender == 'M' ? '남자' : '여자'}</p>
	</div>
	<div>
		<span>전화번호</span>
		<p>${dto.member_phone}</p>
	</div>
	<div>
		<span>올해 사용금액</span>
		<p>${dto.amount_this}</p>
	</div>
	<div>
		<span>작년 사용금액</span>
		<p>${dto.amount_last}</p>
	</div>

	</div>
		<div class="btn" onclick="customerList()">회원목록</div>
</section>
<script>
	function customerList(){
		history.back(-1)
	}
</script>
<%@ include file="../footer.jsp" %>

