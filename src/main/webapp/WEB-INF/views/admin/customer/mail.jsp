<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>    



<h1>메일 전송</h1>
<hr>

<form id="sendMailForm">
		<div>
			<p>
				제목
				<input type="text" id="title" >
			</p>
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
			
			
			
			<textarea rows="20" cols="50" placeholder="내용을 입력해 주세요." id="textBody">가나다라</textarea>			
			<input type="submit" value="메일 전송">
		</div>
</form>


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
// 			if(text.length == 128){
// 				authMailForm.classList.remove('hidden')
// 				sendMailMsg.innerText = '입력한 이메일로 인증 번호를 전송했습니다.'
// 				sendMailMsg.style.color = 'blue'
// 				sendMailMsg.style.fontWeight = 'bold'
// 			}else{
// 				sendMailMsg.innerText = '이메일을 확인하지 못했습니다.'
// 				sendMailMsg.style.color = 'red'
// 				sendMailMsg.style.fontWeight = 'bold'
// 			}		
		})
	}
	
	sendMailForm.onsubmit = sendMailHandler;


</script>


</body>
</html>