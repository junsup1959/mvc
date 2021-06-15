<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<!-- dept 1.본사 2.매니저(지점장?) 3.사원 4.말단 => -->
<section id="bodyWrap">
		<h2>마이페이지</h2>
		<div class="conWrap">
			<div><span>사원번호</span> <p>${ad_login.admin_num }</p></div>
			<div><span>이름</span> <p>${ad_login.admin_name }</p></div>
			<div><span>지점</span> <p>${ad_login.admin_store }</p></div>
			<div><span>직급</span> <p>
				<c:choose>
					<c:when test="${ad_login.admin_dept  == 1 }">
								총괄관리자
					</c:when>
					<c:when test="${ad_login.admin_dept  == 2}">
								지점장
					</c:when>	
					<c:when test="${ad_login.admin_dept == 3 }">
								매니저
					</c:when>	
					<c:when test="${ad_login.admin_dept == 4 }">
								사원
					</c:when>		
				</c:choose>
			</p></div>
			<div><span>입사일</span> <p>${ad_login.admin_jday }</p></div>
			<div><span>연락처</span> <p>${ad_login.admin_phone }</p></div>
			<div><span>주소</span> <p>${ad_login.admin_addr }</p></div>		
		</div>
			<div class="btn" onclick="changePw(${ad_login.admin_password})">비밀번호 수정</div>
</section>
<script>
	function changePw(password){
		const pw1 = prompt("변경할 비밀번호를 입력해주세요");
		const pw2 = prompt("다시한번 변경할 비밀번호를 입력해주세요");
		if(pw1 == pw2){
			
//			const url = '${cpath}/admin/admin_member/?changPw=' + pw1
//			const opt = { method:'POST' }
			
		}else{
			alert('입력값이 다릅니다')
		}
	}
</script>



<%@ include file="../footer.jsp" %>