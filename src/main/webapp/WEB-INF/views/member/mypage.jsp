<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<section id="bodyWrap">
	<div class="loginWrap">
		<h2>MY PAGE - 본인인증하기</h2>
		<hr color="#fff">
		<div class="text">
			<p>
				<i class="xi-lock xi-2x"></i>
				개인정보 수정을 위해 본인인증이 필요합니다</p>		
		</div>
		<div  class="checkPw">
		<p>비밀번호 확인</p>
			<form method="post">
				<p><input type="hidden" name="member_email" value="${login.member_email }"></p>
				<p><input type="text" name="member_password"></p>
				<p><input type="submit" value="확인"  class="btn1"></p>
				<div id="checkPwMsg"></div>
	
			</form>
		</div>
	</div>
</section>


<script>
	const loginForm= document.forms[0]
	const checkMsg = document.getElementById('checkPwMsg')
	
	const loginHandler = function(event) {	
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
				checkMsg.innerText = '잘못된 비밀번호입니다.';
				checkMsg.style.fontWeight = 'bold'
				checkMsg.style.color = 'red'
				document.querySelector('input[name="member_password"]').select()
			}
		})
	}
	loginForm.onsubmit = loginHandler
	
</script>

<%@ include file="../footer.jsp" %>