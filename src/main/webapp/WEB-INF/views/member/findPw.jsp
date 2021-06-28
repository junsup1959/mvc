<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>


<section id="bodyWrap">
	<div class="loginWrap">
		<h2>비밀번호 찾기</h2>
		<hr color="#fff">
		<div class="text">
			<p>
				<i class="xi-lock xi-2x"></i>
				비밀번호 찾기 위해 본인확인이 필요합니다</p>		
		</div>

<div  class="checkPw">
	<form method="post">	
		<p>이름</p>
		<p>
			<input type="text" name="member_name" placeholder="이름을 적어주세요." required autofocus>
		</p>
		<p>전화번호</p>
		<p>
			<input type="tel" name="member_phone" placeholder="'-' 없이 숫자만 입력해주세요." required>
		</p>
		<p>아이디</p>
		<p><input type="text" name="member_email"  placeholder="이메일을 적어주세요." required></p>
		<input type="submit" value="비밀번호 찾기" class="btn1">
	</form>
	
	

	</div>

			
		
<c:if test="${not empty msg }">
	<script>
		alert("${msg}")
	</script>
</c:if>
<c:if test="${not empty findPw}">
	<script>
		location.href="/team/member/findPwAlert?member_email=" + "${findPw.member_email}"
	 	//window.open("/team/member/findPwAlert?member_email=" + "${findPw.member_email}","pop","width=570,height=420, scrollbars=yes, resizable=yes")
	</script>
</c:if>

	</div>
</section>		

<%@ include file="../footer.jsp" %>