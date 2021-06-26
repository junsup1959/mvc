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
	width: 760px;
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
<!-- -----영화관 생성 button css-------- -->
    <style>
        *{
            margin: 0;
            padding: 0;
        }
        .clearfix::before, .clearfix::after {content: ''; display: block; clear: both}
        
        .btn {width : 200px; height : 50px; line-height: 50px; background: teal; color: #fff; font-size: 25px; text-align: center; border-radius: 7px; margin: 20px;}
        .btn:hover {background: coral; font-weight: bold;}
        
        .modal {position: absolute; width: 550px; height: 400px; top: 50%; left: 50%; padding: 10px; background: #fff; border-radius: 10px; transform: translate(-50%,-50%); z-index: 10}
        .remove {display: none; }
        .modal h2 {color : teal; font-weight: 600; font-size: 26px;}
        .modalCon {padding: 10px 0;}
        .modal #createScreen p {display: block; width: 350px; height: 40px; line-height: 40px; margin: 10px auto; }
        .modal #createScreen p input,select { width: 100%;height: 40px; margin : 0 auto; line-height: 40px; border: 1px solid #ccc; border-radius: 7px;}
        .modal #createScreen p select { width: 100%;height: 40px; line-height: 40px; border: 1px solid #ccc; border-radius: 7px;}
        .modal #createScreen p:nth-child(4) input {display: inline-block; width:30px; height: 20px; }
        .modal #createScreen p:nth-child(5) {width : 530px;}
        .modal #createScreen p:nth-child(5) input {display: inline-block; width:160px; }
        input.btn {margin: 0;}
        .bg {position : absolute; width: 100%; height: 100%; top: 0; left: 0; background: rgba(0,0,0,0.5); z-index: 5}
    </style>
    
<!-- ------------------- -->
<div class="btn" onclick="location.href='${cpath}/admin/cinema/addCinema'">상영 시간 추가</div>
<div class="c_cont">

	<div class="theaterList listT">
		<span class="branch">지점</span>
		<span class="branchcode">상영관 코드</span>
		<span class="capacity">수용인원</span>
		<span class="usable">가용여부</span>
		<span>수정</span>
		<span>삭제</span>
	</div>
	
	<c:forEach var="theater" items="${cinemaList }">
	<div class="theaterList">
		<span class="branch">${theater.branch }</span>
		<span class="branchcode">${theater.branch_code }</span>
		<span class="capacity">${theater.seat_amount }</span>
		<span class="capacity">${theater.screen_code}</span>
		
		
<%-- 		<c:choose> --%>
<%-- 			<c:when test="${theater.usable eq 'y' }"> --%>
<!-- 				<span class="usable">사용가능</span> -->
<%-- 			</c:when> --%>
<%-- 			<c:otherwise> --%>
<!-- 				<span class="usable">사용불가</span> -->
<%-- 			</c:otherwise> --%>
<%-- 		</c:choose> --%>
		<span class="Theater_update" onclick="modify('${theater.branch_code}')">수정</span>
		<span class="Theater_del" onclick="delete('${theater.branch_code}')">삭제</span>
		<span></span>
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




<!-- -----------영화관 생성 button-------------------- -->
<div class="btn" onclick="modalUp()">영화관 생성</div>
 
  <div class="bg remove"></div>
   <div class="modal remove">
   <h2>영화관 생성</h2>
   <hr style="border-color: teal">
   <div class="modalCon">
    <form id="createScreen" method="post">
        <p>	    
            <select name="branch">
	        	<optgroup label="서울">
	        		<option value ="강남">강남점</option>
	        		<option value ="홍대">홍대점</option>
	        		<option value ="명동">명동점</option>
	        		<option value ="구로">구로점</option>
	        	</optgroup>
	        	<optgroup label="부산">
	        		<option value ="서면">서면점</option>
	        		<option value ="해운대">해운대점</option>
	        		<option value ="남포">남포점</option>
	        		<option value ="동래">동래점</option>
	        	</optgroup>
	        	<optgroup label="그외지역">
	        		<option value ="김해">김해점</option>
	        		<option value ="대구">대구점</option>
	        		<option value ="광주">광주점</option>
	        		<option value ="전주">전주점</option>
	        		<option value ="천안/아산">천안/아산</option>
	        		<option value ="강릉">강릉점</option>
	        	</optgroup>
	        </select>
        </p>
        <p>
           <select name="screen_code">
            <option>선택하세요</option>
            <option value="1">1관</option>
            <option value="2">2관</option>
            <option value="3">3관</option>
            <option value="4">4관</option>
            <option value="5">5관</option>
            <option value="6">6관</option>
            <option value="7">7관</option>
            </select>
        </p>
        
        <p>
            <select name="seat_amount">
<!--
               //row 12 :  120 132 144  156 168 180 192
                //row 14 :  224 238
-->
                <option value="80">80명</option>
                <option value="120">120명</option>
                <option value="156">156명</option>
                <option value="180">180명</option>
                <option value="224">224명</option>
                <option value="252">252명</option>
            </select>
        </p>
        <p class="clearfix">
            <label for="usable">사용</label><input type="radio" name="usable" id="usable" value="y" onchange="deldate()" checked>
            &nbsp;&nbsp;
            <label for="nusable">사용안함</label><input type="radio" name="usable"  id="nusable" value="n" onchange="createdate()">
        </p>
        <p id="ndate" class="clearfix"></p>
        <p><input type="submit" class="btn" value="상영관생성"></p>
    </form>
    </div>
   </div> 

<!-- ------------------------------- -->


<script>



// function del(data){
// 	if(confirm('정말 삭제하시겠습니까?')){
// 		const url ='${cpath}/admin/cinema/'+data
// 		const opt={
// 				method : 'DELETE'
// 		}
// 		fetch(url,opt)
// 		.then(resp => resp.text())
// 		.then(text =>{
// 			if(+text==1){
// 				alert('삭제 성공')
// 				location.reload()
// 			}else{
// 				alert('삭제 실패')
// 			}
// 		})
// 	} 
// }
</script>




<!-- -------------영화관 생성 button script------------------ -->

<script>
	
	document.forms.createScreen.onsubmit =	function(event){
		event.preventDefault()
		const formData = new FormData(event.target)	
		const url = '${cpath}/admin/cinema/cinema'
		const opt = {
			method: 'POST',
			body: formData,
		}
		fetch(url, opt)
		.then(resp => resp.text())
		.then(text => {
			console.log(text)
			if(+text == 1){
				alert("입력이 완료되었습니다.")
				location.href = '${cpath}/admin/cinema/cinema'
				close();
			}else{
				alert("이미 존재하는 상영관입니다.")
				return false
			}
		})
	}

        const modal = document.querySelector('.modal')
        const bg = document.querySelector('.bg')
        function modalUp(){                
            modal.classList.remove('remove')
            bg.classList.remove('remove')
        }
        
        function close(){
            modal.classList.add('remove')
            bg.classList.add('remove')
        }
        bg.addEventListener('click', close)
        
       function createdate(){
           let check = document.getElementById('nusable')
           let ndate = document.getElementById('ndate')
          if(check.checked){       
        	  ndate.innerHTML = '시작일 <input type="date" name="branch_sdate" required> &nbsp;&nbsp; 종료일<input type="date" name="branch_edate" required>'
          }
              
      }
        
       
      function deldate(){	
          let check = document.getElementById('usable')
           let ndate = document.getElementById('ndate')
          if(check.checked){
              ndate.innerHTML = ''
          } 
      }
      
  
</script>



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



</script>

<%@include file="../footer.jsp" %>