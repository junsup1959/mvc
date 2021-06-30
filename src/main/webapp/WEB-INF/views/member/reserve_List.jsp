<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>

<style>

.rwrap{
	display: flex;
	flex-direction:column;
	width: 1400px;
	margin-top: 50px;
	margin-left: auto;
	margin-right: auto;
	align-items: center;
}
.rwrap>h1{
	text-align: center;
	padding-bottom: 50px;
	font-size: 25px;
}
.rList{
	width:90%;
    border-bottom: inset;
}
.rList>span{
	margin:0 auto;
	display: inline-block;
	width: 9%;
}
.rList>span:nth-child(6),span:nth-child(7),span:nth-child(8),span:nth-child(9),span:nth-child(11){
	width: 6%;
}
.rList>span:nth-child(2),span:nth-child(3),span:nth-child(10){
	width: 13%;
}
.rtit>span
{	margin:0 auto;
	background-color: beige;
}
</style>

<div class="rwrap">
<h1>${login.member_name } 님의 결제내역</h1>
		<div class="rList rtit">
			<span>지점 </span>
			<span>시작일? or sdate</span>
			<span>영화코드</span>
			<span>결제일 </span>
			<span>금액 </span>
			<span>어른 </span>
			<span>어린이</span>
			<span>우대</span>
			<span>총인원 </span>
			<span>좌석</span>
			<span>취소</span>
		</div>
		<c:forEach var="reserve" items="${list }">
		<div class="rList">
			<span>${reserve.branchcode }</span>
			<span>${reserve.start_date }</span>
			<span>${reserve.movie_code }</span>
			<span>${reserve.wdate }</span>
			<span>${reserve.pay } 원</span>
			<span>${reserve.adult } 명</span>
			<span>${reserve.youth } 명</span>
			<span>${reserve.ct } 명</span>
			<span>${reserve.reserv_num } 명</span>
			<span>${reserve.seatNum }</span>
			<button onclick="location.href='${cpath}/member/reserve_List/cancle?imp_uid=${reserve.imp_uid}&merchant_uid=${reserve.merchant_uid}'">취소</button>
		</div>
		</c:forEach>
	</div>
<script>

</script>

</body>
</html>