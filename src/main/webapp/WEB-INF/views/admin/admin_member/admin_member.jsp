<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>
<script>
function tab(t){
//  var name = ".con" + t
  var choice =  document.querySelector('.con'+t)

  var all = document.querySelectorAll('.right>div')
  for(var i =0; i < all.length;i++){
      all[i].style.display = "none"
  }
  choice.style.display="block"
  
  
  
}
</script>
<section id="bodyWrap">

        <div class="left">
            <ul>
                <li onclick="tab(1)">사원목록</li>
                <li onclick="tab(2)">사원입력</li>
            </ul>
        </div>

        <div class="right">
            <div class="con1">
                <h1>TAB 01</h1>
                <c:forEach var="a" items="${list}">
				${a.admin_name}<br>
				${a.admin_addr}<br>
				${a.admin_phone}<br>
				${a.admin_store}<br>
				${a.admin_jday}<br>
				${a.admin_dept}<br>
				</c:forEach>
            </div>
            <div class="con2">
                <h1>TAB 02</h1>
                <form method="post">
					<input type="text" name="admin_name" placeholder="이름"><br>
					<input type="password" name="admin_password" placeholder="비밀번호"><br>
					<input type="tel" name="admin_phone" placeholder="폰번호"><br>
					<input type="text" name="admin_addr" placeholder="주소"><br>
					<select name="admin_store">
						<option value="서울점">서울점</option>
						<option value="부산점">부산점</option>
					</select>
					입사일 : <input type="date" name="admin_jday"><br>
					<select name="admin_dept">
						<option value="1">1부서</option>
						<option value="2">2부서</option>
						<option value="3">3부서</option>
						<option value="4">4부서</option>
					</select>
					<input type="submit" value="작성"><br>
				</form>
            </div>
        </div>

</section>

사원추가...// 사원 리스트 ///사원 검색??!!
<br>




<br>
<a href="${cpath }/admin/admin_member/insert">사원 추가</a>

<%@include file="../footer.jsp" %>

