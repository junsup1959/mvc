<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

	
	
   <form id="" method="post">
        <p>	    
            <select name="branch" onchange="javascript:myListener(this)">
	        		<option>지점을 선택해 주세요.</option>
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
			<select id="screen_code" name="screen_code">
			
			
			</select>        
        
<!-- 			<select name="screen_code"> -->
<!-- <!-- 			branch 의 screen_code 를 뿌려주기 -->
<%-- 				<c:forEach var="theater" items="${cinemaList }"> --%>
<%-- 					<option>${theater.branch_code }</option> --%>
<%-- 				</c:forEach> --%>
<!--            </select> -->
        </p>
        
        <p>
<!--         현재 상영 영화 api 로 가져와서 런타임이랑 몇가지 정보 받아오기 시간 입력해서 theater_info 에 넣기 -->
            <select name="seat_amount">
            
            </select>
        </p>
        <p><input type="submit" class="btn" value=""></p>
    </form>
    
<script>
	function myListener(obj) {
		
		const screen_code = document.getElementById("screen_code")
        screen_code.options.length = 0;
		console.log("screen_code : "+screen_code)
        const branch = obj.value
        
    	const url = '${cpath}/admin/cinema/screenCodes/' + branch
		const opt = {
    			method: 'get'
    		}
    		fetch(url, opt)
    		.then(resp => resp.json())
    		.then(json => {
    			console.log("Ajax text : " +json)
        const screen_codes ={
            	g: json,
            	h: json,
            	m: json,
            	k: json,
            	s: json,
            	u: json,
            	n: json,
            	d: json,
            	q: json,
            	g: json,
            	w: json,
            	e: json,
            	r: json,
            	t: json,	
            	
            }
    			
        console.log(branch)
        
       	let list = {};
        switch(branch){
        case '강남':
        	list = screen_codes.g;
        	appendList(list);break;
        case '홍대':
        	list = screen_codes.h;
        	appendList(list);break;
        case '명동':
        	list = screen_codes.m;
        	appendList(list);break;
        case '구로':
        	list = screen_codes.k;
        	appendList(list);break;
        case '서면':
        	list = screen_codes.s;
        	appendList(list);break;
        case '해운대':
        	list = screen_codes.u;
        	appendList(list);break;
        case '남포':
        	list = screen_codes.n;
        	appendList(list);break;
        case '동래':
        	list = screen_codes.d;
        	appendList(list);break;
        case '김해':
        	list = screen_codes.q;
        	appendList(list);break;
        case '대구':
        	list = screen_codes.g;
        	appendList(list);break;
        case '광주':
        	list = screen_codes.w;
        	appendList(list);break;
        case '전주':
        	list = screen_codes.e;
        	appendList(list);break;
        case '천안/아산':
        	list = screen_codes.r;
        	appendList(list);break;
        case '강릉':
        	list = screen_codes.t;
        	appendList(list);break;
        }
        
    		})
        
   
        
        function appendList(list){
	        for(let i = 0; i < list.length; i++){
	        	const option = document.createElement('option')
	        	console.log("list"+[i]+": "+list[i])
	        	option.innerText = list[i]
	        	screen_code.appendChild(option)
       	 }
        }
        
        
        
    }
    
 
    
   
    
</script>


<%@include file="../footer.jsp" %>