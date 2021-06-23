<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>

<style>
.nwrap{
	display: flex;
	flex-flow: column;
	width: 50%;
	height: 900px;
	margin-left: auto;
    margin-top: 100px;
    margin-right: auto;
}
.nup-wrap{
	height: 20%;
	position: relative;
	width: 100%;
	border: 1px outset;
}
.nup-wrap>.ntitle{
	display:block;
	text-align:center;
    font-size: 33px;
    margin-top: 50px;
}
	

.nup-wrap>.ndate{
	position: absolute;
	bottom: 25%;
    left: 100px;
}

.ncontent{
	border: 1px outset;
	height: 80%;
	
}
.ncontent>div{
	width: 800px;
	height:400px;
	margin-top: 50px ;
	margin-left: auto;
	margin-right: auto;
	overflow: auto;
}
</style>

<div class="nwrap">
	<div class="nup-wrap">
		<span class="ntitle">${dto.board_title }</span>
		<span class="ndate">${dto.board_bdate }</span>	
	</div>
	<div class="ncontent">
		<div>
			${dto.board_content }
		</div>
	</div>
</div>

<%@include file="../footer.jsp"%>