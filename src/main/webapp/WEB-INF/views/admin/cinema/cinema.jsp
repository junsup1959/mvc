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
		<c:choose>
			<c:when test="${theater.usable eq 'y' }">
				<span class="">사용가능</span>
			</c:when>
			<c:otherwise>
				<span class="">사용불가</span>
			</c:otherwise>
		</c:choose>
		<span><button onclick="update('${theater.branchcode}')">수정</button></span>
		<span><button onclick="del('${theater.branchcode}')">삭제</button></span>
	</div>
	</c:forEach>
	<div>
		<span><button onclick="insert()">추가</button></span>
	</div>
	<div id="t_input" class="hidden">
		<form id="t_inputform">
			<p><input type="text" name="branch" placeholder="지점"></p>
			<p><input type="number" name="capacity" placeholder="가용인원"></p>
			<p><input type="submit" value="작성"></p>
		</form>
	</div>
	<div id="t_update" class="hidden">
		<form id="t_updateform">
			<p><input type="text" name="branchcode" id="up_branchcode"></p>
			<p><input type="number" name="capacity" id="up_capacity"></p>	
			<p>
				<select name="usable" id="up_usable">
					<option value="y">사용가능</option>
					<option value="n">불가능</option>
				</select>
			</p>
			<p><input type="submit" value="수정"></p>
		</form>
	</div>
</div>

<script>
const input = document.getElementById('t_input')
const inputform = document.getElementById('t_inputform')
const t_update = document.getElementById('t_update')
const hidden = document.querySelectorAll('.hidden')
for(let i = 0 ; i < hidden.length ;i++){
	hidden[i].style.display = "none"
}


function insert(){
	hidden[0].style.display="block"
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
			if(+text==1){
				alert('추가 성공')
				location.reload();
				}else{
					alert('추가 실패')
					location.reload();
				}
		})
	}
}
function update(data){
	const up_branchcode = document.getElementById('up_branchcode')
	const up_capacity = document.getElementById('up_capacity')
	const up_usable = document.getElementById('up_usable')
	
	const url='${cpath}/admin/cinema/'+data
	const opt={
			method: 'GET'
	}
	fetch(url,opt)
	.then(resp => resp.json())
	.then(json =>{
		console.log(json)
		for(key in json)
			switch(key){
			
			case 'branchcode' : up_branchcode.value=json[key];up_branchcode.readOnly=true; break
			case 'capacity' : up_capacity.value=json[key]; break
			case 'usable' : 
				for (i = 0; i < up_usable.options.length; i++) {
			    if (up_usable.options[i].value == json[key]) {
			    	up_usable.options[i].selected = "selected"
			    	break;
			    }
			}; break
			default : break
			}
	})
	hidden[1].style.display="block"
	t_update.focus()
	t_update.onsubmit = function(event){
		event.preventDefault()
		const formData = new FormData(event.target)
		const ob = {}
		for(key of formData.keys()){
			ob[key] = formData.get(key)
		}
		const url='${cpath}/admin/cinema'
		const opt={
				method: 'PUT',
				body : JSON.stringify(ob),
				headers: { 
					'Content-Type' : 'application/json; charset=utf-8'}
		}
		fetch(url,opt)
		.then(resp => resp.text())
		.then(text =>{
			console.log(text)
			if(+text==1){
			alert('수정 성공')
			location.reload();
			}else{
				alert('수정 실패')
			}
	})
	}	
}

function del(data){
	if(confirm('정말 삭제하시겠습니까?')){
		const url ='${cpath}/admin/cinema/'+data
		const opt={
				method : 'DELETE'
		}
		fetch(url,opt)
		.then(resp => resp.text())
		.then(text =>{
			if(+text==1){
				alert('삭제 성공')
				location.reload()
			}else{
				alert('삭제 실패')
			}
		})
	} 
}

</script>

<%@include file="../footer.jsp" %>