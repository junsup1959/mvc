<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@include file="../header.jsp" %>

<style>
.ticketImg {position : relative;width : 340px; height : 700px; display: inline-block; margin : 10px;}
.back { width : 330px; z-index: 1}
.back {-webkit-filter:invert(100%);}
.tWrap {position : absolute; width : 330px; top : 0; left : -7px; margin : 7px 5px; z-index: 10}
.rList {position : absolute; color : #fff; top : 20px; left : 90px; font-size : 18px; z-index: 20}
.rList > span {display: inline-block; height: 50px;}
button{width : 80px; height : 35px; line-height :35px; margin-left : 20px; margin-bottom: 10px; color : #000; background: #fff; font-weight: bold; border-radius : 5px;}
button:hover{background : yellow; color:coral;}
.con3 {margin-top : 35px; margin-left : -60px; font-size: 16px;}
.con3 > span {height: 30px; line-height: 30px;}
.con4{margin : 40px 0 0 -60px;}
.con4>span{height: 30px; line-height: 30px;}
</style>
<section id="bodyWrap">
<div class="rwrap">

		<h1>${login.member_name }님</h1>

	
	<div class="rListWrap">
		<c:forEach var="reserve" items="${list }">
		<div class="ticketImg">
			
			<img src="<spring:url value='/resources/images/back.png'/>" class="back">
			<img src="<spring:url value='/resources/images/wrap.png'/>" class="tWrap">
			<div class="rList">
			<button onclick="del('${reserve.imp_uid}','${reserve.merchant_uid}')">취소</button>
				<div>
					<span style="color : yellow; font-size: 22px; font-weight: 700;d">${reserve.movie_code }</span>
				</div>
				<div style="margin-left: -60px; font-size: 16px;">
					<span>결제번호 : ${reserve.imp_uid }</span><br>
					<span>예약번호 : ${reserve.merchant_uid }</span><br>
					
				</div>	
				<div style = "margin-top : 10px;">
					<span>${reserve.start_date }</span>
				</div>			
				
				<div class="con3">
					<span>결제일 : ${reserve.wdate }</span><br>
					<span>금 액 :${reserve.pay }</span><br>
					<span>인 원 : ${reserve.reserv_num }명 (
						<span>어른 : ${reserve.adult }</span>
						<span>청소년 : ${reserve.youth }</span>
						<span>우대 : ${reserve.ct }</span> )
					</span><br>
				</div>
				<div style = "margin-top : 100px;">
					<span>${reserve.start_date }</span>
				</div>	
				<div class="con4">
					<span>${reserve.branchcode }</span>
					<span style="margin-left: 50px;">상영관</span><br>
					<span style="margin-left: 90px;">좌석 : ${reserve.seatNum }</span>
				</div>
				
				
							</div>
		
		</div>
				</c:forEach>
	</div>
</div>
</section>
<script>
function getToday(){
	let date = new Date();
	let year = date.getFullYear();
	let month = ("0" + (1 + date.getMonth())).slice(-2);
	let day = ("0" + date.getDate()).slice(-2);
	let hour = date.getHours()
	let minute = date.getMinutes()
	return year + "-" + month + "-" + day + " " + hour + ":" + minute;
}
console.log(getToday())

function del(imp_uid,merchant_uid){
	if(confirm('정말 취소 하시겠습니까?')){
		location.href='${cpath}/member/reserve_List/cancle?imp_uid='+imp_uid+'&merchant_uid='+merchant_uid
	}
}

</script>

</body>
</html>