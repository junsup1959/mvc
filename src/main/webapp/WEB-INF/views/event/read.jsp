<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>



<div>
	<div>
		<span>${dto.board_title }</span>
		<span>${dto.board_edate }</span>	
	</div>
	<div>
		${dto.board_content }
	</div>
</div>

</body>
</html>