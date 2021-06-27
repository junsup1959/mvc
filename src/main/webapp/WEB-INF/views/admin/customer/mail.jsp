<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>    

<section id="bodyWrap">
	<div class="noticeWrap">

<h1 class="mail">고객 메일 발송</h1>

<form id="sendMailForm">
		<div>
			<span>제목</span>
			<p><input type="text" id="title" ></p>
			<select name="listType" id="listType">
				<optgroup label="전체 발송">
					<option value="listAll">전체 발송</option>
				</optgroup>
				<optgroup label="등급별 발송">
	<!-- 			위의 select 가 listGrade 가 되면 hidden 클래스를 삭제 -->
					<option value="N">일반</option>
					<option value="G">골드</option>
					<option value="V">VIP</option>
					<option value="P">플레티넘</option>
				</optgroup>
			</select>
			</div>
			<hr color="#b6e7e7">
			
	<div>
		<textarea placeholder="내용을 입력해 주세요." id="textBody"></textarea>
	</div>		
			<input type="submit" value="메일 전송" class="btn2" style="margin-left:880px">
		
</form>
	</div>
</section>



<script>
	

	const sendMailForm = document.forms[0]
	const lo = document.getElementById('listType')

	const sendMailHandler = function(event){
		event.preventDefault()
		const textBody = document.getElementById('textBody').value
		const listType = lo.options[lo.selectedIndex].value
		const title = document.getElementById('title').value
		console.log(textBody)
		console.log(title)
		
		const url = '${cpath}/admin/customer/mailList?listType=' + listType + '&title='+ title + '&textBody=' + textBody
		const opt = {
			method: 'GET'
		}
		
		fetch(url, opt).then(resp =>resp.text())
		.then(text=> {
				alert(text)
				history.back(-1)
		})
	}
	
	sendMailForm.onsubmit = sendMailHandler;


</script>

<%@ include file="../footer.jsp" %>