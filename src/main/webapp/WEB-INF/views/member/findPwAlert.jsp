<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>

	
	<c:if test="${empty findPwResult}">
	<h3>비밀번호 변경하기</h3>
	<hr>
	<form method="post">
<%-- 		<input type="hidden" name="member_email" value="${param.member_email}"> --%>
		<p>비밀번호</p>
		<p>
			<input type="text" name="member_password" id="pw1" onkeyup="passcheck2(this.value)" placeholder="영문,숫자로 조합해주세요." required>
		</p>
		<output id="pwCheck2"></output>
		
		<p>비밀번호 확인</p>
		<p>
			<input type="text" id="pw2" onkeyup="passcheck(this.value)" placeholder="영문,숫자로 조합해주세요." required>
		</p>
		<output id="pwCheck"></output>
		
		<p>
			<input type = "submit" value="비밀번호 변경">
			<input type = "button" onclick="popClose()" value="취소">
		</p>
		
	</form>
	</c:if>
	
	<c:if test="${not empty findPwResult }">
		비밀번호 완료
		<input type="button" onclick="goLogin()" value="로그인 하기">
	</c:if>
	
	<c:if test="${not empty msg }">
		<strong>${msg }</strong>
		<strong>관리자에게 문의하세요.</strong>
		<input type="button" onclick="goHome()" value="홈페이지로 가기">
		
	</c:if>
	
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
	
	function goLogin(){
		self.close()
		opener.location.href="${capth}/team/member/login"
		
	}
	
	
	function goHome(){
		self.close()
		opener.location.href="${capth}/team/home"
		
	}
	
	function popClose(){
		window.close()
	}

</script>
</body>
</html>