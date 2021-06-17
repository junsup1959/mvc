<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>



	<div>
		<p>
			<span>회원번호</span>
			<span>${dto.member_email }</span>
		</p>
	</div>
	<div>
		<p>
			<span>이름</span>
			<span>${dto.member_name }</span>
		</p>
	</div>
	<div>
		<p>
			<span>회원가입 일시</span>
			<span>${dto.member_date}</span>
		</p>
	</div>
	<div>
		<p>
			<span>ID</span>
			<span>${dto.member_email }</span>
		</p>
	</div>
	<div>
		<p>
			<span>등급</span>
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
		<p>
			<span>주소</span>
			<span>${dto.member_addr1}</span>
			<span>${dto.member_addr2}</span>
		</p>
	</div>
	<div>
		<p>
			<span>성별</span>
			<span>${dto.member_gender == 'M' ? '남자' : '여자'}</span>
		</p>
	</div>
	<div>
		<p>
			<span>전화번호</span>
			<span>${dto.member_phone}</span>
		</p>
	</div>
	<div>
		<p>
			<span>올해 사용금액</span>
			<span>${dto.amount_this}</span>
		</p>
	</div>
	<div>
		<p>
			<span>작년 사용금액</span>
			<span>${dto.amount_last}</span>
		</p>
	</div>
	
	<button onclick="customerList()">회원목록</button>

<script>
	function customerList(){
		history.back(-1)
	}
</script>
<%@ include file="../footer.jsp" %>

