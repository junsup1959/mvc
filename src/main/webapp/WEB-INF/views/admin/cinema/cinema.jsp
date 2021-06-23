<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>

<style>
.c_cont{
	display: flex;
	flex-wrap:wrap;
	width: 60%;
	margin-right: auto;
	height: 500px;
	margin-left: auto;
	flex-flow: column;
	position: relative;
}
.listT{
margin-top: 50px;
margin-left : auto;
margin-right : auto;
border-top: outset;
}

.listT>span{
	font-weight: bold;
}
.theaterList{
	width: 750px;
    height: 40px;
    border-bottom: outset;
    border-left: outset;
   	border-right: outset;
   	margin-left : auto;
	margin-right : auto;
}

.theaterList>span{
	display: inline-block;
	width:calc(700px/6);
	text-align:center;
	margin : 0 0 0 0;
	padding : 0 0 0 0;
	font-size: 14px;
  	margin-left : auto;
	margin-right : auto;

}
.TheaterInsert{
	display: block;
	margin-top: 15px;
	margin-left: 50%;
}
.Theater_del{
	cursor: pointer;
    background-color: gray;
	color: white;
	
}
	
.Theater_update{
	cursor: pointer;
    background-color: gray;
   	color: white;
   	
}
</style>
<div class="c_cont">

	<div class="theaterList listT">
		<span class="branch">지점</span>
		<span class="branchcode">상영관 코드</span>
		<span class="capacity">수용인원</span>
		<span class="usable">가용여부</span>
		<span>수정</span>
		<span>삭제</span>
	</div>
	
	<c:forEach var="theater" items="${list }">
	<div class="theaterList">
		<span class="branch">${theater.branch }</span>
		<span class="branchcode">${theater.branchcode }</span>
		<span class="capacity">${theater.capacity }</span>
		<c:choose>
			<c:when test="${theater.usable eq 'y' }">
				<span class="usable">사용가능</span>
			</c:when>
			<c:otherwise>
				<span class="usable">사용불가</span>
			</c:otherwise>
		</c:choose>
		<span class="Theater_update" onclick="update('${theater.branchcode}')">수정</span>
		<span class="Theater_del" onclick="del('${theater.branchcode}')">삭제</span>
	</div>
	</c:forEach>
	<div class="TheaterInsert">
		<span><i onclick="insert()" class="xi-plus" style='cursor:pointer;'></i></span>
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
<div style="margin-left: 39%; margin-bottom: 100px">
	<form id="T_search">
		<select name="search"  style="width: 80px; margin-right: 20px">
			<option value="branch">지점</option>
			<option value="branchcode">코드</option>
		</select>
		<p><input type="text" name="" ></p>
		<p><span onclick="Tsubmit()" style="padding-right:5px; padding-left:5px; font-size:20px; text-align:center; cursor: pointer; background-color: gray; color: white;">검색</span></p>
	</form>
</div>

<script>
const input = document.getElementById('t_input')
const inputform = document.getElementById('t_inputform')
const t_update = document.getElementById('t_update')
const hidden = document.querySelectorAll('.hidden')
for(let i = 0 ; i < hidden.length ;i++){
	hidden[i].style.display = "none"
}
let iflag=false;
let uflag=false;

function insertchk(){
	if(iflag){
		hidden[0].style.display="none"
		iflag=false;
		return false;
	}else{
		hidden[0].style.display="block"
		iflag=true;
		return true;
	}
}
function updatechk(data){
	if(uflag & document.getElementById('up_branchcode').value == data){
		hidden[1].style.display="none"
		uflag = false;
		return false;
	}else{
		hidden[1].style.display="block"
		uflag = true;
		return true;
	}
}

function insert(){
	if(insertchk()){
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
}
function update(data){
	if(updatechk(data)){
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