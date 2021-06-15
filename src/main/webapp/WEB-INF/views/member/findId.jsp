<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<h1>ID 찾기</h1>


<form method="post">	
	<p>이름</p>
		<p><input type="text" name="member_name" placeholder="이름을 적어주세요." required autofocus></p>
	<p>전화번호</p>
	<p>
		<input type="tel" name="member_phone" placeholder="'-' 없이 숫자만 입력해주세요." required>
	</p>
	<input type="submit" value="아이디 찾기">
	
</form>



<c:if test="${not empty msg }">
	<script>
		alert("${msg}")
		opener.location.href="${capth}/team/member/login"
	</script>
</c:if>

</body>
</html>