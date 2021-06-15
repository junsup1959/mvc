<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<h1>회원 탈퇴를 위해 비밀번호를 입력해 주세요.</h1>

<form method="post">	
	<p>비밀번호</p>
	<p>
		<input type="hidden" name="member_email" value="${modify.member_email}">
		
		<input type="text" name="member_password" placeholder="비밀번호를 입력해 주세요." required>
	</p>
	
		<p><input type="submit" id="checkPw" value="회원 탈퇴"></p>
		<div id="checkPwMsg"></div>
	
</form>



<c:if test="${not empty msg }">
	<script>
		alert('${msg}')
		location.href="${capth}/team"
	</script>
</c:if>

<script>



document.forms[0].onsubmit = function(event) {	
	event.preventDefault();						
	
	const formData = new FormData(event.target)	
	
	const url = '${cpath}/member/checkPw'
	const opt = {
		method: 'POST',
		body: formData,
	}
	fetch(url, opt)
	.then(resp => resp.text())
	.then(text => {
		if(+text == 1) {
			event.target.submit();
		} 
		else {
			document.getElementById('checkPwMsg').innerText = '잘못된 비밀번호입니다.';
			document.getElementById('checkPwMsg').style.fontWeight = 'bold'
			document.getElementById('checkPwMsg').style.color = 'red'
			document.querySelector('input[name="member_password"]').select()
		}
	})
}




</script>
</body>
</html>