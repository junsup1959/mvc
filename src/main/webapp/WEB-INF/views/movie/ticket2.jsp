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
			<form><!-- 좌석 다시 선택하면 밑에 폼이 초기화가 되어서 값을 넣기 힘들어서 @_@;;만듬 -->
	       		<input type="hidden" name="start_date" value="${param.day }">   
	            <input type="hidden" name="movie_code" value="${param.movie }">   
	            <input type="hidden" name="branchcode" value="${param.branch }">
       		</form>
       		
       		
           <form id="ticket">
              <!-- 전페이지에서 영화 제목, 영화관, 날짜, 시간 가져와서 같이 넘기기-->
               
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
			ticket(this,0)
			
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
    // 예매 좌석을 배열로 받아오기
 $(document).ready(function(){
    var nseat = ["1-1", "3-5", "4-7","8-9"]     // 예매한 좌석이 있을 경우    
    for(var i = 0; i < nseat.length; i++){		// 예매수만큼 좌석 번호를 확인 하여
        var nSeatNum = nseat[i]
        var resSeat = $('#'+ nSeatNum)
        resSeat.addClass('off')					// 새로운 className 부여
        resSeat.click(function(){
//            alert('예매된 좌석입니다')
            return false
        })
    }
    
 });
    
    // 좌석 선택 여러명일 경우 연석만 선택 가능
    $('.row > span').click(function(){
    	var flag = true
    	var seatNum
    	if($(this).parent().hasClass('off') === true){
            alert('선택할수 없는 좌석입니다')
            $('.row').removeClass('on')
            flag = false
        }else{
            // 예약 인원
            console.log('인원 : ' + person)
            $('.row').removeClass('on')
            $(this).parent().addClass('on')
            seatNum  = [$(this).text()]
        }
         
        
        
//        console.log(col)        // 행 끝번호
        
        
        
        if(person > 1 && flag == true){                             // 다수 인원 예매시       
        	
            const text = $(this).text().split('-')[0]    
            var index = $(this).parent().index()
           
            for(i = 1; i < person; i++){            // 연석으로만 예매 가능
                index++
                const id = '#' + text + '-' + index
                const target = $(id)
                target.addClass('on')
                
                
                if(index > col || target.hasClass('off') === true){                    // (인원수 > 한행 끝번호) 보다 클 경우 선택 불가
                    alert('선택할수 없는 좌석입니다')
                    $('.row > span').parent().removeClass('on')
                    flag = false
                    break
                }else{
                	const t = target.find('span').text()
                    seatNum[i] = t
                }     
                flag = true
            }
            
        }       
        if(flag){
        alert(seatNum + '좌석을 선택하셨습니다')
        console.log(seatNum)
        ticket(this, seatNum)
        }else{
        	reset()
        	ticket(this, 0)
        }
       
    })
        
        
        function reset(){
            $('.row').removeClass('on')
        }
    </script>
    
    <script>
        // ticket form onsubmit 
    
    function ticket(event,seatNum){
        console.log("어른 : " + adult  + " 어린이 : "+ youth + " 우대 : " + ct)
        const div  = document.querySelector('.ticketinfo')			// 화면 출력용
        div.innerHTML = ''
        div.innerHTML = '<img src="' + '">'
        
        const ticketForm = document.getElementById('ticket')
		ticketForm.innerHTML=''									// 선택된 인원이 없을 경우 form 내용 reset
		let sum='';
		
        if(seatNum != 0){
			for(let i = 0;  i < seatNum.length ; i++){
	            const p = document.createElement('p')			// 화면 출력용
	            p.innerText = ''
	            p.innerText = '좌석 : ' + seatNum[i]     
	            div.appendChild(p)
	            if(i==0){sum +=  seatNum[i]}
	            sum+=","+seatNum[i];
	            ticketForm.innerHTML += '<input type="hidden" name="seatNum" value="' + sum + '">'			// formData 생성
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
	        
	        
	        ticketForm.innerHTML += '<input type="hidden" name="member_age" value="' + adult +","+youth+","+ct +'">'
	        ticketForm.innerHTML += '<input type="hidden" name="reserv_num" value="' + person + '">'
	        ticketForm.innerHTML += '<input type="hidden" name="pay" value="' + (10000 * adult + 8000 * youth + 7000 * ct) + '">'
	        
	        
        
       		/* <input type="submit" class="ticketSubmit" value="예약"> */
        	ticketForm.innerHTML += '<input type="submit" class="ticketSubmit" value="예약" style="width : 310px;">'
        
        
		ticketForm.addEventListener('submit', function(event){
			event.preventDefault();
			if('${login}' == '' || '${login}' == null){return;} //로그인 안되면 입력못하게 막음. 비로그인 예약이 있다면 새로운 함수로 ㅋㅋㅋ
				IMP.init('imp22022976');
				  IMP.request_pay({
		                pg : 'kakaopay',
		                pay_method : 'kakaopay',
		                merchant_uid : 'merchant_' + new Date().getTime(),
		                name : '주문명:'+document.querySelector('input[name=movie_code]').value,
		                amount : document.querySelector("input[name=pay]").value,
		                buyer_email : '${login.member_email}',
		                buyer_name : '${login.member_name}',
		                buyer_tel : '${login.member_phone}',
		                buyer_addr : '${login.member_addr1}'+'${login.member_addr2}',
		               
		            }, function(rsp) {
		                if ( rsp.success ) {
		                	//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
		                	const formData = new FormData(event.target)
		                	formData.append('imp_uid',rsp.imp_uid)
		                	formData.append('merchant_uid',rsp.merchant_uid)
		                	formData.append('member_name',"${login.member_name }")
		                	formData.append('member_email','${login.member_email }')
		                	formData.append('branchcode',document.querySelector('input[name=branchcode]').value)
		                	formData.append('movie_code',document.querySelector('input[name=movie_code]').value)
		                	formData.append('start_date',document.querySelector('input[name=start_date]').value)
		                	
		                	const ent = formData.entries();				
							let ob = {};								
							while(true) {							
								next = ent.next();						
								if(next.done) break;
								ob[next.value[0]] = next.value[1];		
							}
		                	const url ="${cpath}/payments"
		                	const opt ={
		                			method : "POST",
		                			body: JSON.stringify(ob),
		                			headers: {	
		                 				'Content-Type': 'application/json; charset=utf-8'
		                 			}
		                	}
		       				fetch(url,opt).then(resp=>resp.text())
		       				.then(text=>{
		       						console.log(text)
		       					if(+text==1){
		       						alert('결제 성공하셨습니다.')
		       					}else if(text=='n'){
		       						alert('데이터 위변조 문제로 결제가 취소되었습니다.')
		       					}else{
		       						alert('서버측 문제로 결제가 기록되지 않았습니다. 고객센터로 문의바랍니다.')
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
    }
    </script>

<%@ include file="../footer.jsp" %>