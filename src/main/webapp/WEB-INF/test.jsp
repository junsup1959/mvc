<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
12344
<h1>TEST</h1>
<button id="e1"> 보내기</button>
<button id="e2">주문조회</button>	

</body>

<script>
document.getElementById('e1').onclick=function(event) {
	
	const obj ={
			imp_uid : rsp.imp_uid,
			merchant_uid : rsp.merchant_uid
			//db에 입력할 데이터 추가입력
			//필수정보 좌석,결제 예정금액(script 내의 값이 아니라 html에서 불러와야함. 대조 증명하기위해)
	}
	const url ="${cpath}/payments"
	const opt ={
			method : "POST",
			body: JSON.stringify(obj),
				headers: {	
		 				'Content-Type': 'application/json; charset=utf-8'	                	 			
			}
	fetch(url,opt) .then(resp =>resp.text())
	.then(text=>{
			console.log(text)
		})
	}
	
}

document.getElementById('e2').onclick=function(event) {
const merchant_uid = 'merchant_1624335977380'
			//db에 입력할 데이터 추가입력
			//필수정보 좌석,결제 예정금액(script 내의 값이 아니라 html에서 불러와야함. 대조 증명하기위해)
	
	const url ="${cpath}/payments/"+merchant_uid
	const opt ={
			method : "GET",
			body: JSON.stringify(obj),
				headers: {	
		 				'Authorization' : "cfdf800c826f56c9fd8aa3aa042657ddbfac28e4"
			}
	}
	fetch(url,opt) .then(resp =>resp.json())
	.then(json=>{
		console.log(json)
	})
}
}
</script>

</html>