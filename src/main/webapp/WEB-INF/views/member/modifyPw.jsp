<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<section id="bodyWrap">
	<div class="loginWrap" id="changePw">
		<h2>비밀번호 변경</h2>
		<hr color="#fff">
		<div class="text">
			<p>
				<i class="xi-lock xi-2x"></i>
				비밀번호 변경을 위해 본인인증이 필요합니다</p>		
		</div>
		<div  class="checkPw" id="oldPw">
			<p>현재 비밀번호 확인</p>
			<form>
				<p><input type="hidden" name="member_email" value="${login.member_email }"></p>
				<p><input type="text" name="member_password"></p>
				<p><input type="submit" value="확인" class="btn1"></p>
				<div id="checkPwMsg"></div>
			</form>
		</div>
		<div  class="checkPw" id="newPw">	
			<form>
			<p>변경 비밀번호</pl>
			<p>
				<input type="text" name="member_password" id="pw1" onkeyup="passcheck2(this.value)" placeholder="영문,숫자로 조합해주세요." required>
			</p>
			<output id="pwCheck2"></output>					
			<label>변경 비밀번호 확인</label>
			<p>
				<input type="text" id="pw2" onkeyup="passcheck(this.value)" placeholder="영문,숫자로 조합해주세요." required>
			</p>
				<output id="pwCheck"></output>
				<p><input type="submit" value="확인" class="btn1"></p>
			</form>
		</div>
	</div>
</section>

<script>
const oldPw = document.getElementById('oldPw')
const newPw = document.getElementById('newPw')


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
			checkMsg.innerText = '비밀번호 인증 성공!';
			checkMsg.style.fontWeight = 'bold'
			checkMsg.style.color = 'blue'
			newPw.style.display = 'block'
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
<script>
function passcheck2(pw1){
	const t1= /[0-9]/
	const t2= /[a-zA-Z]/
	const t3= /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/

	if(!t1.test(pw1) || !t2.test(pw1)|| t3.test(pw1) || !(pw1.length >= 8 && pw1.length <= 14) ){
	document.getElementById('pwCheck2').value = "비밀번호는 8~14자리. 영문,숫자 조합"
		document.getElementById('pwCheck2').style.color = "red"
	}else{
		document.getElementById('pwCheck2').value= "사용가능"
		document.getElementById('pwCheck2').style.color= "blue"
	}			
}

function passcheck(pw2){
	const pw1 = document.getElementById('pw1').value
	if(pw1 != pw2){
		document.getElementById('pwCheck').value = "비밀번호 불일치"
		document.getElementById('pwCheck').style.color = "red"
	}else{
		document.getElementById('pwCheck').value= "비밀번호 일치"
		document.getElementById('pwCheck').style.color= "blue"
	}
}

</script>

<script>


const modifyPwForm= document.forms[1]

const modifyPwHandler = function(event) {	
	event.preventDefault();						
	
	const formData2 = new FormData(event.target)	
	
	const url = '${cpath}/member/modifyPw'
	const opt = {
		method: 'POST',
		body: formData2,
	}
	fetch(url, opt)
	.then(resp => resp.text())
	.then(text => {
		console.log(text)
		if(+text == 1) {
			alert('비밀번호를 변경하였습니다.\n로그인을 다시 해주세요.');
			location.href="${cpath}/member/login"
		} 
		else {
			alert('비밀번호를 확인해 주세요.');
		}
	})
}
modifyPwForm.onsubmit = modifyPwHandler

</script>




<%@ include file="../footer.jsp" %>