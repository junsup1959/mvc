<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<div>
	<p>STEP1.정보입력</p>
	<p>STEP2.가입완료</p>
</div>
<div>
	<form method="post" id="joinForm">
	<p>회원정보를 입력해주세요.</p>
	<p>이름</p>
	<p><input type="text" name="member_name" placeholder="이름을 적어주세요." required autofocus></p>

	<p>아이디</p>
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
       
	
	<p><input type="button" id="checkId" value="중복확인"></p>
	<div id="checkIdMsg"></div>
	
	<p>비밀번호</p>
	<p><input type="text" name="member_password" id="pw1" onkeyup="passcheck2(this.value)" placeholder="영문,숫자로 조합해주세요." required></p>
	<output id="pwCheck2"></output>
	
	<p>비밀번호 확인</p>
	<p><input type="text" id="pw2" onkeyup="passcheck(this.value)" placeholder="영문,숫자로 조합해주세요." required></p>
	<output id="pwCheck"></output>
	
	<p>닉네임</p>
	<p><input type="text" name="member_nick" placeholder="활동명을 적어주세요." required></p>
	
	<p><input type="button" id="checkNick" value="중복확인"></p>
	<div id="checkNickMsg"></div>
	
	<p>전화번호</p>
	<p>
		<input type="tel" name="member_phone" placeholder="'-' 없이 숫자만 입력해주세요." required>
	</p>
	<div>
		<input type="text" name="member_addr1" id="member_addr1" placeholder="주소를 입력해주세요." required readonly>
		<!-- 둘중 하나라도 null 이면 error 발생 -->		
		<input type="text" name="member_addr2" id="member_addr2" placeholder="주소를 입력해주세요." required>
		<button type="button" onClick="goPopup()">주소검색</button>
	</div>
	<p>
	</p>
	
	<p>남자<input type="radio" name="member_gender" value="M" required></p>
	<p>여자<input type="radio" name="member_gender" value="F" required></p>
	
	
	<p><input type="submit" value="회원가입"></p>
	
	
	</form>
</div>


<script>


/* 	$(function() {
	    $('#select').change(function() {
	        if ($('#select').val() == 'directly') {
	            $('#member_email').attr("disabled", false);
	            $('#member_email').val("");
	            $('#member_email').focus();
	        } else {
	        	$('#member_email').val() = $('#member_email').val() +'@'+ $('#select').val()
	        	
	        	/* const joinForm = document.getElementById('joinForm')
	        	const input = document.createElement('input')			
				'member_email' : input.type = 'hidden';break;
				input.name = 'member_email'
				input.value = member_email
				updateForm.appendChild(input) 
	        }
	    })
	}); */

	function emailCheck(email) {
		if (email != "") {
			const exptext = /[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]/;
			if (!exptext.test(email)) {
// 				if($('#select').val() == 'directly')|| $('#select').val() == '')){
				document.getElementById('emailChk').value = "유효하지 않은 email 형식입니다."
				document.getElementById('emailChk').style.color = "red"
//				}
			}else{
				document.getElementById('emailChk').value= ""
				}			
		}
	}

	function goPopup(){
		var pop = window.open("/team/member/addrPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	}
	
	
	function jusoCallBack(roadFullAddr, addrDetail){
		var addrEl = document.querySelector("#member_addr1")
		addrEl.value = roadFullAddr
		
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
	

	document.getElementById('checkId').onclick = function(event) {
		const member_email = document.querySelector('input[name="member_email"]').value
		const url = '${cpath}/member/' + member_email + '/'			
		const opt ={
				method: 'GET'
		}
		fetch(url, opt)
		.then(resp => resp.text())	
		.then(text => {
			if( +text == 1 ){
				document.getElementById('checkIdMsg').innerText = '이미 사용중인 ID입니다.'
				document.getElementById('checkIdMsg').style.color = 'red'
				document.querySelector('input[name="member_email"]').select()
			}else{
				document.getElementById('checkIdMsg').innerText = '사용 가능한 ID입니다.'
				document.getElementById('checkIdMsg').style.color = 'blue'
				document.querySelector('input[name="member_password"]').focus()
			}
				document.getElementById('checkIdMsg').style.fontWeight = 'bold'
		})
	}
		
	document.getElementById('checkNick').onclick = function(event) {
		const member_nick= document.querySelector('input[name="member_nick"]').value
		const url = '${cpath}/member/nick/' + member_nick 		
		const opt ={
				method: 'GET'
		}
		fetch(url, opt)			
		.then(resp => resp.text())		
		.then(text => {
			if( +text == 1 ){
				document.getElementById('checkNickMsg').innerText = '이미 사용중인 활동명입니다.'
				document.getElementById('checkNickMsg').style.color = 'red'
				document.querySelector('input[name="member_nick"]').select()
			}else{
				document.getElementById('checkNickMsg').innerText = '사용 가능한 활동명입니다.'
				document.getElementById('checkNickMsg').style.color = 'blue'
				document.querySelector('input[name="member_phone"]').focus()
			}
				document.getElementById('msg').style.fontWeight = 'bold'
		})
	}
	
</script>



</body>
</html>