<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>


<div class="joinWrap" style="height : 650px; text-align : center">
    <h1 style="margin-top : 20px; font-size : 34px;color : blue;">회원가입 완료</h1>
    <div style="margin : 30px auto">
        <p>
        	<b style="color : teal; font-size : 20px;">
        	${member.member_name }</b>님의 MVC 가입을 환영합니다.<br>
        지금부터 MVC의 다양한 멤버십 혜택을 이용해 보세요!
        </p>
    </div>
    <div class="btn2" onClick="location.href='${cpath }/member/login'" style="margin: 0 auto;">홈으로 가기</div>
</div>

<%@ include file="../footer.jsp" %>