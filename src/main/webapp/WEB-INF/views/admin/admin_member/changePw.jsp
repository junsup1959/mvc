<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<style>

.pwForm {width : 100%; padding : 0 10px;}
.pwForm > p {width : 300px;}
.pwForm > p:first-child {width : 0; height : 0;}
.pwForm > p:first-child input {width : 0; height : 0;}
..pwForm > p:nth-child(3) {height : 80px;}
.pwForm > p > input { width : 100%}
</style>
<section id="bodyWrap">
<h2 style="margin-left : 550px ; margin-bottom : 10px;">비밀번호변경</h2>
	<div class="conWrap" style="width : 350px;height : 300px; padding : 0 20px;">
		<form method="POST" id="pwForm" class="pwForm">
		<p><input type="hidden" name="admin_num" value="${ad_login.admin_num }"></p>
		<p><input type="password" name="current_password" placeholder="기존비밀번호 입력"></p>
		<p><input type="password" name="admin_password" placeholder="새비밀번호 입력" onkeyup="pwCheck(this.value)">
		<output id="Check" style="font-size : 16px;"></output></p>
		<p><input type="password" name="admin_password2" placeholder="새비밀번호 확인"></p>
		<p><input type="submit" value="비밀번호 변경" class="btn1" style="border:none;"></p>
		</form>
	</div>
</section>

<script>
var t1= /[0-9]/
var t2= /[a-zA-Z]/
function pwCheck(pw){ // 비밀번호 조건 체크
	
		if(!t1.test(pw) || !t2.test(pw) || !(pw.length >= 6 &&pw.length <= 12)){
		document.getElementById('Check').value = "비밀번호는 6~12자리. 영문,숫자 조합"
			document.getElementById('Check').style.color = "red"
	}else{
		document.getElementById('Check').value= "사용가능"
			document.getElementById('Check').style.color= "blue"
	}
}
</script>
<script>
const form = document.getElementById('pwForm')
form.onsubmit = function(e){
	e.preventDefault();
	
	const currentPw = document.querySelector('input[name="current_password"]').value;
	const pw = document.querySelector('input[name="admin_password"]').value;
	const pw2 = document.querySelector('input[name="admin_password2"]').value;
	if(pw != pw2) { 
		alert('새 비밀번호가 서로 일치하지 않습니다')
		return false
	}else if(!t1.test(pw) || !t2.test(pw) || !(pw.length >= 6 &&pw.length <= 12)){
		alert('비밀번호 조건에 적합하지 않습니다(숫자,영어 조합 6~12자리)')
		return false
	}
	if(pw == pw2){
		 if(${ad_login.admin_password} == currentPw){
		e.target.submit();
		}else{
			alert('기존 비밀번호가 일치하지 않습니다')
		}
	}
}
</script>
<%@ include file="../footer.jsp" %>