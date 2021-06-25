<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>
<section id="bodyWrapBg">
	<div class="nwrap">
		<div class="nup-wrap">
			<span class="ntitle">${dto.board_title }</span>
			<c:choose>
			<c:when test="${not empty login }">
				<c:choose>
					<c:when test="${check eq 1}">
						<i id="likey" class="xi-heart-o xi-2x" onclick="likey()" style="cursor: pointer;"></i>
					</c:when>
					<c:otherwise>
						<i id="likey" class="xi-heart xi-2x"></i>
					</c:otherwise>
				</c:choose>
			</c:when>
			 <c:otherwise>
				<i id="likey" class="xi-heart-o xi-2x"></i>
		   </c:otherwise>
			</c:choose>
			<span id="likey-count">${blcount }</span>
			<span class="ndate">${dto.board_bdate }</span>	
		</div>
		<div class="ncontent">

				${dto.board_content }

		</div>
		<div class="cleatfix btCont">
			<ul>
				<c:if test="${not empty next}">
					<li onclick="location.href='${cpath}/notice/${next.board_number}?search=${param.search }&keyword=${param.keyword }&cate=3&page=${param.page}'" style="cursor: pointer;">[다음글] :
					 ${next.board_title }</li>
				</c:if>
					<li style="color :coral">[현재글] : ${dto.board_title }</li>
				<c:if test="${not empty prev}">
					<li onclick="location.href='${cpath}/notice/${prev.board_number}?search=${param.search }&keyword=${param.keyword }&cate=3&page=${param.page}'" style="cursor: pointer;">[이전글] :
					 ${prev.board_title }</li>
				</c:if>
			</ul>
			<div class="btn3" onclick="location.href='${cpath }/notice/?search=&keyword=&cate=3&page=1'">공지사항목록</div>
		</div>
	</div>
</section>

<script>
const BL=document.getElementById('likey');
let flag = false;
function likey (){
	if(flag){return;}
	const obj={
			board_number :'${dto.board_number}',
			user_email :'${login.member_email}'
	}
	const url='${cpath}/event/like/'
	const opt={
			method : "POST",
			body : JSON.stringify(obj),
			headers: {
				'Content-Type' : 'application/json; charset=utf-8'
			}
	}
	fetch(url,opt).then(resp=>resp.text())
	.then(text=>{
			if(text != 'n'){
			BL.setAttribute('class','xi-heart xi-2x')
			BL.style.cursor = 'default'
			document.getElementById('likey-count').innerText = text;
			flag = true;
		}
	})
}


</script>

<%@include file="../footer.jsp"%>