<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

	<div>
		<h1>MY PAGE</h1>
		<p>본인인증하기</p>
		<p>개인정보 수정을 위해 본인인증이 필요합니다.</p>
		<p>비밀번호 확인</p>
		<p>
			<form method="post">
				<input type="hidden" value="${login.member_email }">
				<input type="text" name="member_password">
				<input type="submit" value="확인">
			</form>
		</p>
	</div>





</body>
</html>