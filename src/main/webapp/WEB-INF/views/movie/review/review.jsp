<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../header.jsp" %>
<h1>${movie.title }</h1>
<div>
<span><img>이미지 : 패스 -_-;;; </span>
<span>제작일 : ${movie.pubDate }</span>
<span>감독 : ${movie.director }</span>
<span>배우 : ${movie.actor }</span>
<span>네이버 링크 : ${movie.link }</span>
<span>네이버 평점 : ${movie.userRating }</span>
	<div>
		<h1>리뷰 보드 영역</h1>
		<span>우리 사이트 평점</span>
		<div>
			<span>작성자</span>
			<span>내용</span>
			<span>작성일시</span>
			<span>평점</span>
			<span>좋아요/싫어요???</span>	
		</div>
	</div>
</div>
</body>
</html>