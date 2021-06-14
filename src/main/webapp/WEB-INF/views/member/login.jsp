<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>


<div>
<form method="post">
	<p><input type="text" name="member_email" placeholder="아이디"  value="${cookie.user_check.value}" required autofocus></p>
	<p><input type="text" name="member_password" placeholder="비밀번호" required></p>
	<p><input type="button" id="checkLogin" value="로그인"></p>
	<div id="checkLoginMsg"></div>
	

</form>
</div>	
<div>

	<c:if test="${not empty cookie.user_check}">
		<c:set value="checked" var="checked"/>
	</c:if>


<%-- ${checked} 값 넣어주기--%>
	<p><input type="checkbox"  id="remember_us" name="remember_userId" ${checked} >아이디 저장</p>
	<p><a href="${cpath }/member/join">회원가입</a> |</p>
	<p><a href="${cpath }/member/findId">아이디 찾기</a> |</p>
	<p><a href="${cpath }/member/findPw">비밀번호 찾기</a> </p>
	
</div>
<div>
	<a href="https://kauth.kakao.com/oauth/authorize?client_id=7d7a89444c3dc7117978512358c75028&redirect_uri=http://localhost:8081/team/member/auth/kakao/callback&response_type=code"><img src="${cpath }/resources/kakaoImage/kakao_login_medium_narrow.png"/></a>
	<p>네이버 로그인</p>
	

</div>

<div>
<a href="${cpath }/member/movie">영화목록</a>
</div>

<c:if test="${not empty kakaoError }">
	<script>
		alert("${kakaoError}")
	</script>
</c:if>



<script>


document.getElementById('checkLogin').onsubmit = function(event) {	// form을 submit하면
	event.preventDefault();						// 기본 작동을 막고
	
	const formData = new FormData(event.target)	// submit된 form을 기반으로 formData를 생성
	// 여기서부터 ajax
	const url = '${cpath}/member/checkLogin'
	const opt = {
		method: 'POST',
		body: formData,
	}
	fetch(url, opt)
	.then(resp => resp.text())
	.then(text => {
		console.log(text)
		if(+text == 1) {
			event.target.reset();
		} 
		else {
			// 원래 form 제출 확인
			document.getElementById('msg').innerText = '';
			alert('가입하지 않은 아이디거나, 잘못된 비밀번호입니다.');
		}
	})
}
</script>



</body>
</html>