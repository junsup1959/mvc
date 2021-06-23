<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<section id = "bodyWrap">
	<div class="joinWrap">
			<h2>MVC</h2>
			<h3>회원가입 : 회원정보를 입력 후 회원가입버튼을 누르세요</h3>
			<hr color="#fff">
			<div class="formWrap" style="border:none">
				<form method="post" id="joinForm" name="send">
				<div>
					<label>이름</label>
					<p><input type="text" name="member_name" placeholder="이름을 적어주세요." required autofocus></p>
				</div>
				
				<div>
					<label>아이디</label>
					<p><input type="text" name="member_email" id="member_email" onkeyup="emailCheck(this.value)" placeholder="이메일을 적어주세요." required></p>
					<output id="emailChk"></output>	
					
				<!-- 	<select id="select"> -->
				<!--        	<option value="" disabled selected>E-Mail 선택</option> -->
				<!--    	    <option value="naver.com" id="naver.com">naver.com</option> -->
				<!--         <option value="hanmail.net" id="hanmail.net">hanmail.net</option> -->
				<!--         <option value="gmail.com" id="gmail.com">gmail.com</option> -->
				<!--         <option value="nate.com" id="daum.net">daum.net</option> -->
				<!--         <option value="directly" id="textEmail">직접 입력하기</option> -->
				<!--        </select> -->
				       
					
					<p> 
						<input type="button" id="checkId" value="중복확인"  class="btn1" style="margin-left : 190px;">
						&nbsp;&nbsp;<span id="checkIdMsg"></span>
					 </p>
					
				</div>
				<div>
					<label>비밀번호</label>
					<p><input type="text" name="member_password" id="pw1" onkeyup="passcheck2(this.value)" placeholder="영문,숫자로 조합해주세요." required></p>
					<output id="pwCheck2"></output>					
					<label>비밀번호 확인</label>
					<p><input type="text" id="pw2" placeholder="영문,숫자로 조합해주세요." required></p>
					<output id="pwCheck"></output>
				</div>
				
				<div>
					<label>닉네임</label>
					<p><input type="text" name="member_nick" placeholder="활동명을 적어주세요." required></p>
					<p>
						<input type="button" id="checkNick" value="중복확인"  class="btn1" style="margin-left : 190px;">
						&nbsp;&nbsp; <span id="checkNickMsg"></span>
					</p>
					
				</div>
				<div>
					<label>전화번호</label>
					<p><input type="tel" name="member_phone" placeholder="'-' 없이 숫자만 입력해주세요." required></p>
				</div>
				
				<div>
					<label>주소입력</label>
					<p style="padding-left : 20px;">
						<input type="text" name="member_addr1" id="member_addr1" placeholder="주소를 입력해주세요." required readonly>
						<input type="button" onClick="goPopup()" class="btn1" value="주소검색">
					</p>
						<!-- 둘중 하나라도 null 이면 error 발생 -->		
					<p style="padding-left : 20px;">
						<input type="text" name="member_addr2" id="member_addr2" placeholder="주소를 입력해주세요." required>
					</p>
				</div>
				
				<div class="radio">
					<label>성별</label>
					<p><input type="radio" name="member_gender" value="M" required>남자</p>
					<p><input type="radio" name="member_gender" value="F" required>여자</p>
				</div>
				
				<div style="padding : 0">
					<input type="submit" value="회원가입"  class="btn1" style="width : 400px; margin-top : 50px; margin-left: 150px">
				</div>
				
				
				</form>
			</div>
	</div>
</section>
<script>
</script>

<script>
var check1 = false
var check2 = false
var check3 = false
	function emailCheck(email) {
		if (email != "") {
			const exptext = /[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]/;
			if (!exptext.test(email)) {
				document.getElementById('emailChk').value = "유효하지 않은 email 형식입니다."
				document.getElementById('emailChk').style.color = "red"
				}else{
					document.getElementById('emailChk').value =""
				}
			}
		}
	function goPopup(){
		var pop = window.open("/team/member/addrPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	}
	
	
	function jusoCallBack(roadAddrPart1, addrDetail){
		var addrEl = document.querySelector("#member_addr1")
		addrEl.value = roadAddrPart1
		
		var addrEl2 = document.querySelector("#member_addr2")
		addrEl2.value = addrDetail 
	}
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
	
	
// 	function passcheck(pw2){
// 		const pw1 = document.getElementById('pw1').value
// 		if(pw1 != pw2){
// 			document.getElementById('pwCheck').value = "비밀번호 불일치"
// 			document.getElementById('pwCheck').style.color = "red"
// 				check1 = false
// 		}else{
// 			document.getElementById('pwCheck').value= "비밀번호 일치"
// 			document.getElementById('pwCheck').style.color= "blue"
// 				check1 = true
// 		}
// 	}
	
	document.getElementById('checkId').onclick = function(event) {
		const member_email = document.querySelector('input[name="member_email"]').value
		const url = '${cpath}/member/' + member_email + '/'			
		const opt ={
				method: 'GET'
		}
		if(!member_email){
			document.getElementById('checkIdMsg').innerText = ''
			event.preventDefault()
		}else{
		fetch(url, opt)
		.then(resp => resp.text())	
		.then(text => {
			if( +text == 1 ){
				document.getElementById('checkIdMsg').innerText = '이미 사용중인 ID입니다.'
				document.getElementById('checkIdMsg').style.color = 'red'
				document.querySelector('input[name="member_email"]').select()
				check2 = false
			}else{
				document.getElementById('checkIdMsg').innerText = '사용 가능한 ID입니다.'
				document.getElementById('checkIdMsg').style.color = 'blue'
				document.querySelector('input[name="member_password"]').focus()
				check2 = true
			}
				document.getElementById('checkIdMsg').style.fontWeight = 'bold'
		})
		}
	}
		
	document.getElementById('checkNick').onclick = function(event) {
		const member_nick= document.querySelector('input[name="member_nick"]').value
		const url = '${cpath}/member/nick/' + member_nick 		
		const opt ={
				method: 'GET'
		}
		if(!member_nick){
			document.getElementById('checkNickMsg').innerText = ''
			event.preventDefault()
		}else{
			
		fetch(url, opt)			
		.then(resp => resp.text())		
		.then(text => {
			if( +text == 1 ){
				document.getElementById('checkNickMsg').innerText = '이미 사용중인 활동명입니다.'
				document.getElementById('checkNickMsg').style.color = 'red'
				document.querySelector('input[name="member_nick"]').select()
				check3 = false
			}else{
				document.getElementById('checkNickMsg').innerText = '사용 가능한 활동명입니다.'
				document.getElementById('checkNickMsg').style.color = 'blue'
				document.querySelector('input[name="member_phone"]').focus()
				check3 =true
			}
				document.getElementById('checkNickMsg').style.fontWeight = 'bold'
		})
		}
	}
	
</script>
<script>
	
	const send = document.forms[0]
	submitHandler = function(event){
		
		if(!check2){
			event.preventDefault()
			alert('아이디를 확인해주세요')
			return false
		}
		if(!check3){
			event.preventDefault()
			alert('닉네임을 확인해주세요')
			return false
		}
		const pw1 = document.getElementById('pw1').value
		const pw2 = document.getElementById('pw2').value
		if(pw1 != pw2){
			alert("비밀번호가 일치하지 않습니다.")
			event.preventDefault()
		}
// 		location.href = "${cpath}/member/join_complete"	
	}
	send.onsubmit = submitHandler
 
</script>

<%@ include file="../footer.jsp" %>