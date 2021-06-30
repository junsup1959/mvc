<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>

<style>

</style>

<div class="rwrap">
	<div class="header">
		<h1>${login.member_name }</h1>
	</div>
	
	<div class="rList">
		<div>
			<span>imp_uid    </span>
			<span>merchant_uid     </span>
			<span>지점         </span>
			<span>시작일?or   sdate    </span>
			<span>영화코드      </span>
			<span>결제일       </span>
			<span>금액         </span>
			<span>예약인원        </span>
			<span>어른          </span>
			<span>어린이        </span>
			<span>우대          </span>
			<span>좌석</span>
		</div>
		<c:forEach var="reserve" items="${list }">
		<div class="rList">
			<span>${reserve.imp_uid }</span>
			<span>${reserve.merchant_uid }</span>
			<span>${reserve.branchcode }</span>
			<span>${reserve.start_date }</span>
			<span>${reserve.movie_code }</span>
			<span>${reserve.wdate }</span>
			<span>${reserve.pay } 원</span>
			<span>${reserve.reserv_num } 명</span>
			<span>${reserve.adult } 명</span>
			<span>${reserve.youth } 명</span>
			<span>${reserve.ct } 명</span>
			<span>${reserve.seatNum }</span>
			<button onclick="location.href='${cpath}/member/reserve_List/cancle?imp_uid=${reserve.imp_uid}&merchant_uid=${reserve.merchant_uid}'">취소</button>
		</div>
		</c:forEach>
	</div>
</div>
<script>

</script>

</body>
</html>