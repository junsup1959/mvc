<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<section id="bodyWrap">
<div class="loginWrap">
	<h1>MVC</h1>
	<h3>로그인 : ID와 비밀번호를 입력하고 로그인 버튼을 누르세요</h3>
	<hr color="#fff">
	<div class="loginForm">
		<form method="post" id="loginForm">
			<p><input type="text" name="member_email" placeholder="아이디" required autofocus></p>
			<p><input type="text" name="member_password" placeholder="비밀번호" required></p>
			<p><input type="submit" id="checkLogin" value="로그인" class="btn1"></p>
			<div id="checkLoginMsg"></div>
		</form>
	</div>		

	<div class="loginMenu">
<%-- 	<c:if test="${not empty cookie.user_check}"> --%>
<%-- 		<c:set value="checked" var="checked"/> --%>
<%-- 	</c:if> --%>
<%-- ${checked} 값 넣어주기--%>
	<p>
		<input type="checkbox"  name="remember" value="rememberOk" >
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
	<p>네이버 로그인</p>
</div>

<c:if test="${not empty kakaoError }">
	<script>
		alert("${kakaoError}")
	</script>
</c:if>
</div>
</section>



<script>
    window.onload = function() {
 
        if (getCookie("remember_id")) { // getCookie함수로 id라는 이름의 쿠키를 불러와서 있을경우
            document.loginForm.member_email.value = getCookie("remember_id"); //input 이름이 id인곳에 getCookie("id")값을 넣어줌
            document.loginForm.remember.checked = true; // 체크는 체크됨으로
        }
 
    }
 
    function setCookie(name, value, expiredays) //쿠키 저장함수
    {
        var todayDate = new Date();
        todayDate.setDate(todayDate.getDate() + expiredays);
        document.cookie = name + "=" + escape(value) + "; path=/; expires="
                + todayDate.toGMTString() + ";"
    }
 
    function getCookie(Name) { // 쿠키 불러오는 함수
        var search = Name + "=";
        if (document.cookie.length > 0) { // if there are any cookies
            offset = document.cookie.indexOf(search);
            if (offset != -1) { // if cookie exists
                offset += search.length; // set index of beginning of value
                end = document.cookie.indexOf(";", offset); // set index of end of cookie value
                if (end == -1)
                    end = document.cookie.length;
                return unescape(document.cookie.substring(offset, end));
            }
        }
    }
 
    function sendit() {
 
        if (document.loginForm.remember.checked == true) { // 아이디 저장을 체크 하였을때
            setCookie("remember_id", document.loginForm.member_email.value, 7); //쿠키이름을 id로 아이디입력필드값을 7일동안 저장
        } else { // 아이디 저장을 체크 하지 않았을때
            setCookie("remember_id", document.loginForm.member_email.value, 0); //날짜를 0으로 저장하여 쿠키삭제
        }
 
        document.loginForm.submit(); //유효성 검사가 통과되면 서버로 전송.
 
    }
</script>
 



<script>


document.forms[0].onsubmit = function(event) {	
	event.preventDefault();						
	
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