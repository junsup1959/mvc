<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>

<div><span>${login.member_name }</span></div>

<div>
	<div>
		<span>imp_uid(필수 없으면 안됨)</span>
		<span>branchcode</span>
		<span>start_date</span>
		<span>movie_code</span>
		<span>wdate</span>
		<span>member_email</span>
		<span>member_name</span>
		<span>merchant_uid(이것도 필수다)</span>
		<span>pay</span>
		<span>member_age</span>
		<span>reserv_num</span>
		<span>adult</span>
		<span>youth</span>
		<span>ct</span>
		<span>deleted</span>
	</div>
	<c:forEach var="reserve" items="${list }">
	<div>
		<span>${reserve.imp_uid }</span>
		<span>${reserve.branchcode }</span>
		<span>${reserve.start_date }</span>
		<span>${reserve.movie_code }</span>
		<span>${reserve.wdate }</span>
		<span>${reserve.member_email }</span>
		<span>${reserve.member_name }</span>
		<span>${reserve.merchant_uid }</span>
		<span>${reserve.pay }</span>
		<span>${reserve.member_age }</span>
		<span>${reserve.reserv_num }</span>
		<span>${reserve.adult }</span>
		<span>${reserve.youth }</span>
		<span>${reserve.ct }</span>
		<span>${reserve.deleted }</span>
		<button onclick="location.href='${cpath}/member/reserve_List/cancle?imp_uid=${reserve.imp_uid}&merchant_uid=${reserve.merchant_uid}'">취소</button>
	</div>
	</c:forEach>
</div>

<script>

</script>

</body>
</html>