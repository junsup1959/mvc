<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>

<div class="event_ctnt">
	<div class="inner_wrap">
		<h2 class="tit">전체 이벤트</h2>
		<!-- <div class="right"><a href="${cpath }/event/eventm">더보기</a></div> -->
	</div>
	<div class="event_top">
		<ul>
			<li></li>
			<li></li>
			<li></li>
		</ul>
	</div>
	<div class="event_dw">
		<div class="wrap">
		
		<!-- c foreach로  디비에서 불러오기  및 페이징 처리   -->		
			<div>
				<img alt="" src="" >
				<p class="title">$(m.title)</p>
				<p class="date">$(m.begin) ~ $(m.end)</p>
			</div>	
		</div>
	
	</div>
	
</div>

</body>
</html>