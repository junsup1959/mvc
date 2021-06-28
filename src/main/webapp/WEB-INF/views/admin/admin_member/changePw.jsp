<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<section id="bodyWrap">
<h2>비밀번호변경</h2>
		<div class="conWrap">
<form method="POST" id="pwForm">
	<p><input type="hidden" name="admin_num" value="${ad_login.admin_num }"></p>
	<p><input type="password" name="current_password" placeholder="기존비밀번호 입력"></p>
	<p><input type="password" name="admin_password" placeholder="새비밀번호 입력"></p>
	<p><input type="password" name="admin_password2" placeholder="새비밀번호 확인"></p>
	<p><input type="submit" value="비밀번호 변경"></p>
</form>
</div>
</section>

<script>
const form = document.getElementById('pwForm')
form.onsubmit = function(e){
	e.preventDefault();
	
	const pw = document.querySelector('input[name="current_password"]').value;
	const pw1 = document.querySelector('input[name="admin_password"]').value;
	const pw2 = document.querySelector('input[name="admin_password2"]').value;
	if(pw1 == pw2){
		if(${ad_login.admin_password}==pw){
		e.target.submit();
		}else{
			alert('기존 비밀번호가 일치하지 않습니다')
		}
	}else{
		alert('새 비밀번호가 서로 일치하지 않습니다')
	}
}
</script>
<%@ include file="../footer.jsp" %>