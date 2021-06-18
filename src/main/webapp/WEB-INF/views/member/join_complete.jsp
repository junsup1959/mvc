<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<div>
	<p>STEP1.정보입력</p>
	<p>STEP2.가입완료</p>
</div>
<div>
	<p>${member.member_name }님의 MVC 가입을 환영합니다.</p>
	<p>지금부터 MVC의 다양한 멤버십 혜택을 이용해 보세요!</p>
</div>
<div>
	<button type="button" onClick="location.href='${cpath }/member/login'">홈으로 가기</button>
</div>
</body>
</html>z