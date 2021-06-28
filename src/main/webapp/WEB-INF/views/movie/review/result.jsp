<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../header.jsp" %>
	<h1>RESULT</h1>
	<h1>제목 클릭하면 리뷰 보드로 이동 !!!!!!</h1>
	<c:forEach var="movie" items="${list }">
	<div>
		<span><a href="${cpath }/movie/review/board?moviecode=${movie.moviecode}&title=${movie.title}">${movie.title}</a></span>
		<span>링크주소 ${movie.link }</span>
		<span>이미지 ${movie.image }</span>
		<span>감독 ${movie.director }</span>
		<span>배우 ${movie.actor }</span>
		<span>제작일 ${movie.pubDate }</span>
		<span>평점 ${movie.userRating }</span>
		<span>영화코드 ${movie.moviecode }</span>
	</div>
	</c:forEach>
	
<script>
function gogo(data1,data2){
	location.href ="'${cpath}'/movie/review/board?moviecode="+data1+"&title="+data2
}
</script>

</body>
</html>