<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<section id="bodyWrap">
	<div class="loginWrap"  id="heightPx">
			<h2>회원탈퇴</h2>
		<hr color="#fff">
		<div class="text">
			<p>
				<i class="xi-lock xi-2x"></i>
				회원 탈퇴를 위해 비밀번호를 입력해 주세요.</p>		
		</div>
		<div  class="checkPw">
		<form method="post">	
			<p>비밀번호</p>
			<input type="hidden" name="member_email" value="${modify.member_email}">	
			<p><input type="text" name="member_password" placeholder="비밀번호를 입력해 주세요." required></p>	
			<p><input type="submit" id="checkPw" value="회원 탈퇴" class="btn1"></p>
			<div id="checkPwMsg"></div>
			</form>
		</div>
		
		<c:if test="${not empty msg }">
		<script>
			alert('${msg}')
			location.href="${capth}/team"
		</script>
		</c:if>
	</div>
</section>


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
<%@ include file="../footer.jsp" %>