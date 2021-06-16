<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>

<style>
.t_cont{
	display: flex;
	flex-direction: column;
	justify-content:center;
	align-items:center;
	width: 100%;
	height: 500px;
}
.theaterList{
	display: flex;
	flex-wrap: wrap;
	width: 30%;
	margin-bottom: 10px;
}
.theaterList>span{
	display: inline-block;
	width:100px;
	text-align:center;
	flex-grow: 1;
}
</style>
<div class="c_cont">

	<div id="theaterList">
		<span class="">지점</span>
		<span class="">상영관 코드</span>
		<span class="">수용인원</span>
		<span class="">가용여부</span>
	</div>
	<c:forEach var="theater" items="${list }">
	<div id="theaterList">
		<span class="">${theater.branch }</span>
		<span class="">${theater.branchcode }</span>
		<span class="">${theater.capacity }</span>
		<span class="">${theater.usable }</span>
	</div>
	</c:forEach>
	<div>
		<span><a onclick="insert()">추가</a></span>
		<span><a onclick="update()">수정</a></span>
		<span><a href="">삭제</a></span>
	</div>
	<div id="t_input" class="ciema ipt" style="display: none;">
		<form id="t_inputform">
			<p><input type="text" name="branch" placeholder="지점"></p>
			<p><input type="number" name="capacity" placeholder="가용인원"></p>
			<p><input type="submit" value="작성"></p>
		</form>
	</div>
	<div id="t_delete" class="cinema del" style="display: none;">
		<button onclick="">삭제</button>
	</div>
</div>

<script>
const input = document.getElementById('t_input')
const tdelete = document.getElementById('t_delete')
const inputform = document.getElementById('t_inputform')
function insert(){
	input.style.display="block"
	inputform.focus()
	inputform.onsubmit = function(event){
		event.preventDefault()
		const formData = new FormData(event.target)
		const url='${cpath}/admin/cinema'
		const opt={
				method: 'POST',
				body: formData
		}
		fetch(url,opt)
		.then(resp => resp.text())
		.then(text =>{
			console.log(text)
			location.reload();
		})
	}
}
function update(){
	input.style.display="block"
	inputform.focus()
	
}
</script>

<%@include file="../footer.jsp" %>