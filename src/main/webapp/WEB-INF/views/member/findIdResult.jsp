<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../header.jsp" %>


	<p>아이디 찾기 결과</p>
	<p>${id }</p>
	<button onclick="location.href ='${cpath}/member/login'">로그인하기</button>
	<button onclick="location.href='${cpath}/member/findPw'">비밀번호 찾기</button>
</body>
</html>