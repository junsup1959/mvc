<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../header.jsp" %>
<section id="bodyWrap">
	<div class="loginWrap">
	<h2>ID 찾기 결과</h2>
	<hr color="#fff">
	<div class="text">
			<p>
				<i class="xi-lock xi-2x"></i>
				고객님의 ID는 아래와 같습니다</p>		
		</div>
		<div  class="checkPw" style="padding : 20px 0 0 70px;">	
			<h3 style="font-size: 30px;">${id }</h3>
			<button onclick="location.href ='${cpath}/member/login'" class="btn3">로그인하기</button>
			<button onclick="location.href='${cpath}/member/findPw'" class="btn3">비밀번호찾기</button>
		</div>
	</div>
</section>
<%@ include file="../footer.jsp" %>