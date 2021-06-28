<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<section id="bodyWrap">
	<div class="loginWrap">
	<h2>ID 찾기</h2>
	<hr color="#fff">
		<div class="text">
			<p>
				<i class="xi-lock xi-2x"></i>
				ID를 찾기위해선 본인확인이 필요합니다</p>		
		</div>

<div  class="checkPw">
<form method="post">	
	<p><span>이름</span> 
		<input type="text" name="member_name" placeholder="이름을 적어주세요." required autofocus></p>
	<p><span>전화번호</span>
		<input type="tel" name="member_phone" placeholder="'-' 없이 숫자만 입력해주세요." required></p>
	<input type="submit" value="아이디 찾기" class="btn1">
	
</form>
</div>
	</div>
</section>

<c:if test="${not empty msg }">
	<script>
		alert("${msg}")
		opener.location.href="${capth}/team/member/login"
	</script>
</c:if>
<%@ include file="../footer.jsp" %>