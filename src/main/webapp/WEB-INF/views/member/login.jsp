<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<script>
// cookie저장
function setCookie(cookieName, value, exdays){
    var date = new Date();
    date.setDate(date.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + date.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
	// alert(document.cookie)
}
// cookie 삭제
function deleteCookie(cookieName){
    var date = new Date();
    date.setDate(date.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + date.toGMTString();
}
//저장된 cookie 가져오기
function getCookie(cookieName) {
    cookieName = cookieName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = '';
    if(start != -1){
        start += cookieName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cookieValue = cookieData.substring(start, end);
    }
    return unescape(cookieValue);	//저장된 cookie 값 반환
}
</script>
<section id="bodyWrap">
<div class="loginWrap">
	<h1>MVC</h1>
	<h3>로그인 : ID와 비밀번호를 입력하고 로그인 버튼을 누르세요</h3>
	<hr color="#fff">
	<div class="loginForm">
		<form method="post" id="loginForm">
			<p><input type="text" name="member_email" id="userid" placeholder="아이디" required autofocus></p>
			<p><input type="text" name="member_password" placeholder="비밀번호" required></p>
			<p><input type="submit" id="checkLogin" value="로그인" class="btn1"></p>
			<div id="checkLoginMsg"></div>
		</form>
	</div>		

	<div class="loginMenu">
	<p>
		<input type="checkbox"  name="remember" value="rememberOk" id="chk">
		<span>아이디 저장</span>
	</p>
	<br>
	<p><a href="${cpath }/member/join">회원가입</a> |</p>
	<p><a href="${cpath }/member/findId">아이디 찾기</a> |</p>
	<p><a href="${cpath }/member/findPw">비밀번호 찾기</a> </p>
	</div>
	
	<div class="loginApi">
		<a href="https://kauth.kakao.com/oauth/authorize?client_id=7d7a89444c3dc7117978512358c75028&redirect_uri=http://localhost:8081/team/member/auth/kakao/callback&response_type=code">
			<img src="${cpath }/resources/kakaoImage/kakao_login_medium_narrow.png"/>
		</a>
	</div>

<c:if test="${not empty kakaoError }">
	<script>
		alert("${kakaoError}")
	</script>
</c:if>
</div>
</section>



<script>
function getcheck(){									// 저장된 cookie id가 있을 경우 input id란에 입력하기
	var input = document.getElementById('userid')
	input.setAttribute("value", getCookie("userInId"))
	if(getCookie("userInId")  != ""){
		var check = document.getElementById('chk')
		check.checked =true
	}
}
getcheck()
</script>


<script>
document.forms[0].onsubmit = function(event) {	
	event.preventDefault();						
	// onsubmit할 때 체크박스 체크 여부로 cookie 저장 
	var chk = document.getElementById('chk')
	if(chk.checked){
		var userid = document.getElementById('userid').value
		setCookie("userInId", userid, 7)		// 체크박스가 checked= true cookie 생성
	}else{
		deleteCookie("userInId")					// 체크박스가 checked= false cookie 삭제
	}
	
	// login 
	const formData = new FormData(event.target)	
	
	const url = '${cpath}/member/checkLogin'
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
			document.getElementById('checkLoginMsg').innerText = '가입하지 않은 아이디거나, 잘못된 비밀번호입니다.';
			document.getElementById('checkLoginMsg').style.fontWeight = 'bold'
			document.getElementById('checkLoginMsg').style.color = 'red'
			document.querySelector('input[name="member_email"]').select()
		}
	})
}
</script>

<%@ include file="../footer.jsp" %>