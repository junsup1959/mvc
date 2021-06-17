<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>
<script>
//leftMenu 클릭시
/* 
 function tab(t){
//  var name = ".con" + t
  var choice =  document.querySelector('.con'+t)

  var all = document.querySelectorAll('.rightWrap>div')
  for(var i =0; i < all.length;i++){
      all[i].style.display = "none"
  }
  choice.style.display="block"  
  
}

 */

// ------leftMemnu && update ------
function tab(t, admin_num){
	 //update 처리
	if((t != null) && (admin_num != null)){
		const updateForm = document.getElementById('updateForm')
	  	console.log(admin_num) // 클릭할 사원번호가 받아와지는지 확인
	  
		const url = '${cpath}/admin/admin_member/' + admin_num
		const opt = {method:'GET'}
		fetch(url, opt)
		.then(function(resp){return resp.json()})
		.then(function(json) {
			
			updateForm.innerHTML = ''
			for(key in json){
//				console.log(key, ':', json[key])
					const span = document.createElement('span');
					const input = document.createElement('input');
					if(key != 'admin_password'){
						span.innerText = key;
						input.name = key;
						input.value = json[key];
						switch(key){
						case 'admin_num' : input.readOnly = 'readonly'; break;
						}
						updateForm.appendChild(span);
						updateForm.appendChild(input);
					}
			}	
			const submit = document.createElement('input');
			submit.type='submit';
			submit.value='정보수정'
			submit.className = 'btn3'
			updateForm.appendChild(submit);
		})
		
		updateForm.onsubmit = function(e){
			e.preventDefault();
			const formData = new FormData(e.target);
			const url = '${cpath}/admin/admin_member/update'
			const opt = {
					method:'POST',
					body:formData
			}
			
			fetch(url, opt)
			.then(resp => resp.text())
			.then(text => {
				if(+text == 1){		
					alert('정보수정 완료!')
					location.reload()
				}else{
					alert('정보수정 실패!')
				}
			})
		}
	}
  
var choice =  document.querySelector('.con'+t)
  var all = document.querySelectorAll('.rightWrap>div')
  for(var i =0; i < all.length;i++){
      all[i].style.display = "none"
  }
  
  choice.style.display="block"  
	
}
</script>
<section id="bodyWrap">

        <div class="leftWrap">
            <ul>
                <li onclick="tab(1)">사원목록</li>
                <li onclick="tab(2)">사원입력</li>
                <li onclick="tab(3)">퇴사자관리</li>
            </ul>
        </div>

        <div class="rightWrap">
            <div class="con1">
                <h2>사원목록</h2>
                <c:if test="${empty list }">
                	<h2>사원 목록이 없습니다.</h2>
                </c:if>
                <c:if test="${not empty list }">
	                <div class="list-title cf">
	                	<span>사원번호</span>
	                	<span>지점</span>
	                	<span>직급</span>
	                	<span>사원명</span>
	                	<span>입사일</span>
	                	<span>연락처</span>
	                	<span>주소</span>
	                </div>
	                <div class="list cf">
	                <c:forEach var="a" items="${list}"> 
					<p onclick="tab(4, ${a.admin_num})">
	                	<span>${a.admin_num}</span>
	                	<span>${a.admin_store}</span>
	                	<span>
							<c:choose>
								<c:when test="${a.admin_dept  == 1 }">
											총괄관리자
								</c:when>
								<c:when test="${a.admin_dept  == 2}">
											지점장
								</c:when>	
								<c:when test="${a.admin_dept == 3 }">
											매니저
								</c:when>	
								<c:when test="${a.admin_dept == 4 }">
											사원
								</c:when>		
							</c:choose>
						</span>
						<span>${a.admin_name}</span>
						<span>${a.admin_jday}</span>
						<span>${a.admin_phone}</span>		
						<span>${a.admin_addr}</span>
						</p>	
					</c:forEach>
					<article>
						<c:if test="${paging.prev }">
						   	<a href="${cpath }/admin/admin_member?page=${paging.begin-1}">
						   	[이전]</a>
					   	</c:if>
						<c:forEach var="i" begin="${paging.begin }" end="${paging.end}">
							<span onclick="name(${i})">[${i}]</span>
						</c:forEach>
						<c:if test="${paging.next }">
						   	<a href="${cpath }/admin/admin_member?page=${paging.end+1}">
						   	[다음]</a>
					   	</c:if>
					</article>
					</div>
					
				</c:if>
            </div>
            
            <div class="con2">
                <h2>사원입력</h2>
                <div class="insertForm">
	                <form id="insertForm">
						<input type="text" name="admin_name" placeholder="이름"><br>
						<input type="password" name="admin_password" placeholder="비밀번호"><br>
						<input type="tel" name="admin_phone" placeholder="폰번호"><br>
						<input type="text" name="admin_addr" placeholder="주소"><br>
						근무지<select name="admin_store">
							<option value="서울점">서울점</option>
							<option value="부산점">부산점</option>
						</select><br>
						입사일 <input type="date" name="admin_jday"><br>
						직급 <select name="admin_dept">
							<option value="1">총괄관리자</option>
							<option value="2">지점장</option>
							<option value="3">매니저</option>
							<option value="4">사원</option>
						</select>
						<input type="submit" value="사원계정생성" class="btn3"><br>
					</form>
				</div>
            </div>
            
            <div class="con3">
            	<h2>퇴사자관리</h2>
            	<p>
            		퇴사일 - 기본값 x, 퇴사여부 - 기본값 n 입력(db 2열 추가)
            	</p>
            </div>
            
            
            <div class="con4">
                <h2>사원정보수정</h2>
                <div class="updateForm">
	                <form id="updateForm">
						
					</form>
				</div>
            </div>
            
        </div>

</section>

<script>
	document.getElementById('insertForm').onsubmit = function(e){
		e.preventDefault();
		const formData = new FormData(e.target);
		
		const url = '${cpath}/admin/admin_member/insert';
		const opt = {
				method:'POST',
				body:formData,
		}
		
		fetch(url, opt)
		.then(resp => resp.text())
		.then(text => {
			console.log(text)
			if(+text == 1){
				e.target.reset()
				alert('사원계정생성성공!!!!')
				location.reload()
			}else{
				alert('실패');
			}
		});
	}
	
	
	
	
	function name(data){
		location.href="${cpath }/admin/admin_member?page="+data
		
	}
</script>

<%@include file="../footer.jsp" %>

