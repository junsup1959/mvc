<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<section id="movieWrap">
  <section id="stWrap" class="clearfix">
   <article id="seatWrap">
    <div class="count">
        <div class="cell">성인 <input type="number" id="adult" min="0" max="4" onchange="total(this.id)" value="0"></div>
        <div class="cell">어린이 <input type="number" id="youth" min="0" max="4" onchange="total(this.id)" value="0"></div>
        <div class="cell">우대 <input type="number" id="ct" min="0" max="4" onchange="total(this.id)" value="0"></div>
    </div>
    <div class="screen"><span>screen</span></div>
    <div id="cover"><span>인원을 선택하세요</span></div>
   </article> 
   
   <article id="ticketWrap">
      <h1>예약 정보</h1>
       <div class="ticketinfo"> 

       </div>
       <div>
           <form id="ticket">
              <!-- 전페이지에서 영화 제목, 영화관, 날짜, 시간 가져와서 같이 넘기기-->
               <input type="submit" class="ticketSubmit" value="예약">
           </form>
        </div>
   </article>
   </section>
</section>
<script>   
    const cover = document.getElementById('cover')
    
    cover.onclick = function(){
        console.log(person)
        if(person != 0 ){
        cover.style.display = 'none'
            
        }else{
            
            alert('인원을 먼저 선택하세요')
        }
    }
    </script>
   <script>
       //인원 받아서 처리   
       let adult = 0
       let youth = 0
       let ct = 0
       var person = 0

         function total(name){
             var tmp = 0
             const  target = $('#' + name)
             if(name == 'adult'){
                adult = Number($('#'+name).val())             
             }else if(name == 'youth'){
                youth = Number($('#'+name).val())
             }else if(name == 'ct'){
                 ct = Number($('#'+name).val())
             }
             
             console.log($('#'+name).val())
             person = Number(adult) + Number(youth) + Number(ct)    // 전체 인원 구하기

             
             if(person > 4){                               // 4명 초과될 경우 
               alert('최대 4명까지만 예약가능합니다')
                var v = Number(target.val()) -1    // target + 1을 다시 target - 1로 변경하고 
                target.val(v)                        // 그 값을 입력한다 (눈에 보이는 값)
                
                if(name == 'adult'){                 // 위에 변수에 저장된 값도 -1 을 해준다
                    adult--            
                }else if(name == 'youth'){
                    youth--
                }else if(name == 'ct'){
                    ct--
                }
                person = Number(adult) + Number(youth) + Number(ct)     // 그리고 전체 인원을 다시 계산
                
              }
             
            // 인원 변경시 좌석 선택 reset()        
            alert('인원에 맞게 좌석을 선택해주세요')
            $('.row').removeClass('on')

            if(person == 0){
                cover.style.display = 'block'
            }
            console.log("어른 : " + adult  + " 어린이 : "+ youth + " 우대 : " + ct)
         }
        

    </script>
   

  <script>
       // 인원에 따른 영화관 좌석 생성
       const wrap = document.getElementById('seatWrap')
       const div = document.createElement('div')
       const seatAll = 80;     //row 12 :  120 132 144  156 168 180 192
                                //row 14 :  224 238
       var row = 0
       var col = 0
       div.className = 'seat'
       if(seatAll < 101){
        col = 10
        row = seatAll / col
        seat(col, row, seatAll)
           
       }else if(seatAll >= 101 && seatAll <=200){
        row = 12
        col = seatAll / row
        seat(col, row, seatAll)
       }else{
        row = 14
        col = seatAll / row
        seat(col, row, seatAll)
       }

    // 인원에 따른 영화관 좌석 생성
       function seat(col,row, count){
           for(let i = 1; i < row+1; i++){
               const ul = document.createElement('ul')
               ul.className = 'rowWrap'
               for(let j = 0; j < col+1; j++){
                   const li = document.createElement('li')          
                   li.className = 'row'
                   if(j == 0 ){
                       li.innerHTML = '<p>' + i + '열</p>'
                   }else{
                       li.setAttribute('id', i+'-'+j)
                       li.innerHTML= '<span>' + i + '-' + j + '</span>'
                       if((col >= 11 && col <=14) && count <= 200 && (j == 3 || j == col - 1)){
                           li.style.marginLeft = '10px'
                       }else if((col >= 15 && col <=18) && count <= 200 && (j == 5 || j == col - 3)){
                            li.style.marginLeft = '10px'    
                       }else if(count >= 200 && (j == 5 || j == col - 3)){
                                li.style.marginLeft = '10px'
                       }
                   }
                   ul.appendChild(li)
                   ul.style.width = (col+2) * 31 + 'px'
               }
               if(count >= 200 && (i == 4 || i == row - 4)){
                       ul.style.marginBottom = '10px'
                }else if((row == 12) && count > 120 && (i == 6)){
                    ul.style.marginBottom = '10px'
                }
               div.appendChild(ul)
           }

           wrap.appendChild(div)     
       }
    </script>
   
    
    <script>
    // 좌석 선택 여러명일 경우 연석만 선택 가능
    $('.row > span').click(function(){
        
                 // 예약 인원
        console.log('인원 : ' + person)
        $('.row').removeClass('on')
        $(this).parent().addClass('on')
        
        const seatNum = [$(this).text()]
        
        const text = $(this).text().split('-')[0]    
        var index = $(this).parent().index()
//        console.log(col)        // 행 끝번호
        
        var flag = true
        
        if(person > 1){                             // 다수 인원 예매시       
            for(i = 1; i < person; i++){            // 연석으로만 예매 가능
                index++
                const id = '#' + text + '-' + index
                const target = $(id)
                target.addClass('on')
                const t = target.find('span').text()
                seatNum[i] = t
                
                if(index > col){                    // (인원수 > 한행 끝번호) 보다 클 경우 선택 불가
                    alert('선택할수 없는 좌석입니다')
                    $('.row > span').parent().removeClass('on')
                    flag = false
                    break
                }     
                flag = true
            }
            
        }       
        if(flag){
        alert(seatNum + '좌석을 선택하셨습니다')
        console.log(seatNum)
        }
       ticket(this, seatNum)
    })
        
        
        function reset(){
            $('.row').removeClass('on')
        }
    </script>
    
    <script>
        // ticket form onsubmit 
    
    function ticket(event,seatNum){
        console.log("어른 : " + adult  + " 어린이 : "+ youth + " 우대 : " + ct)
        const div  = document.querySelector('.ticketinfo')
        div.innerHTML = ''
        div.innerHTML = '<img src="' + '">'
        
        for(let i = 0;  i < seatNum.length ; i++){
            const p = document.createElement('p')
            p.innerText = ''
            p.innerText = '좌석 : ' + seatNum[i]     
            div.appendChild(p)
        }
        const p1  = document.createElement('p')
        p1.innerText = '어른 : ' + adult  + '명, 어린이 : '+ youth + '명, 우대 : ' + ct + '명'
        div.appendChild(p1)
        const p2  = document.createElement('p')
        p2.innerText = '총인원 : ' + person + '명'
        div.appendChild(p2)
        const p3  = document.createElement('p')
        p3.innerText = '결제 금액 : ' + (10000 * adult + 8000 * youth + 7000 * ct) + '원' 
        div.appendChild(p3)
        const ticketForm = document.getElementById('ticket')
		ticketForm.addEventListener('submit', function(event){
			event.preventDefault();
			if('${login}' == '' || '${login}' == null){return;} //로그인 안되면 입력못하게 막음. 비로그인 예약이 있다면 새로운 함수로 ㅋㅋㅋ
				IMP.init('imp22022976');
				  IMP.request_pay({
		                pg : 'kakaopay',
		                pay_method : 'kakaopay',
		                merchant_uid : 'merchant_' + new Date().getTime(),
		                name : '주문명:결제테스트',
		                amount : 1500,
		                buyer_email : '${login.member_email}',
		                buyer_name : '${login.member_name}',
		                buyer_tel : '${login.member_phone}',
		                buyer_addr : '${login.member_addr1}'+'${login.member_addr2}',
		               
		            }, function(rsp) {
		                if ( rsp.success ) {
		                	//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
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
		                	}
		       				fetch(url,opt).then(resp=>resp.text())
		       				.then(text=>{
		       						console.log(text)
		       					if(+text==1){
		       						alert('결제 성공하셨습니다.')
		       					}else{
		       						alert('데이터 위변조 가능성이 있습니다. 고객센터에 문의해주세요.')
		       					}
		       				})	
		                } else {
		                    var msg = '결제에 실패하였습니다.';
		                    msg += '에러내용 : ' + rsp.error_msg;
	
		                    alert(msg);
		                }
		            });
			
		});
               
        

    }
    </script>

<%@ include file="../footer.jsp" %>