<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>


<h1>MY PAGE 정보 수정하기</h1>

<form method="post">
	<p>기본 회원정보</p>
	<p>이름</p>  
	<p><input type="text" name="member_name"  value="${modify.member_name }"  readonly></p>
	
	<p><button type="button" value="본인확인"></button>휴대폰 api 로 이름받아와서 자동으로 변경</p>

	<p>아이디</p>
	<p><input type="text" name="member_email"  value="${modify.member_email }"  readonly></p>
	
	<p>닉네임</p>
	<p><input type="text" name="member_nick" placeholder="활동명을 적어주세요." value="${modify.member_nick }" required></p>
	<p><input type="button" id="checkNick" value="중복확인"></p>
	<div id="checkNickMsg"></div>
	
	<p>전화번호</p>
	<p>
		<input type="tel" name="member_phone" placeholder="'-' 없이 숫자만 입력해주세요." value="${modify.member_phone }" required>휴대폰 api 로 이름받아와서 자동으로 변경
	</p>

	<div>
		<input type="text" name="member_addr1" id="member_addr1" value = "${modify.member_addr1 }" placeholder="주소를 입력해주세요." required readonly>
		<input type="text" name="member_addr2" id="member_addr2" value = "${modify.member_addr2 }" placeholder="주소를 입력해주세요." required>
		<button type="button" onClick="goPopup()">주소검색</button>
	</div>
	<p>
	</p>
	<c:if test="${modify.member_gender=='M' }">	
		<p>남자<input type="radio" name="member_gender" value="M" required checked></p>
		<p>여자<input type="radio" name="member_gender" value="F" required></p>
	</c:if>
	<c:if test="${modify.member_gender=='F' }">	
		<p>남자<input type="radio" name="member_gender" value="M" required></p>
		<p>여자<input type="radio" name="member_gender" value="F" required checked></p>
	</c:if>
	
		
	<p><input type="submit" value="수정완료"></p>
	<p><button type="button" onclick="location.href ='${cpath}/member/modify'">비밀번호 변경</button></p>
<%-- 	<p><button type="button" onclick="location.href ='${cpath}/member/deleteMember'">회원탈퇴</button></p> --%>
	<p><button type="button" onclick="delChk()">회원탈퇴</button></p>
		
	
</form>


<script>
	
	function delChk(){
		if(confirm('회원탈퇴를 진행하시겠습니까?')){
			return location.href='${cpath}/member/deleteMember?member_email=${modify.member_email}'
		}
	}
	


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