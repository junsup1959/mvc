<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<section id="movieWrap">
        <div class="ticket"> 
             <nav class="nav" id="choice1">  
                 <h1 class="text">영화관</h1>     
                  <ul>
                      <li><p>부산</p>
                        <ul class="sub">
                            <li>서면점</li>
                            <li>해운대점</li>
                            <li>남포점</li>
                            <li>동래점</li>
                        </ul>
                    </li>
                    <li><p>서울</p>
                        <ul class="sub">
                            <li>강남점</li>
                            <li>홍대점</li>
                            <li>명동점</li>
                            <li>구로점</li>
                        </ul>
                    </li>
                    <li><p>그외지역</p>
                        <ul class="sub">
                            <li>김해점</li>
                            <li>대구점</li>
                            <li>광주점</li>
                            <li>전주점</li>
                            <li>천안/아산</li>
                            <li>강릉점</li>
                        </ul>
                    </li>
                </ul>
            </nav>
            
            <nav class="nav" id="choice2">
                <h1 class="text">영화선택</h1>
                <ul class="movie" id="daily">
                
                
<!--                     <li><span>[등급]</span><b>영화1</b></li> -->
                </ul>
            </nav>
            
        <div class="nav" id="choice3">
            <div class="text">날짜/시간선택</div>
            <ul id="dateForm"></ul>
            
            <div id="movieList">
                불러온 영화 목록 띄우기          
            </div>
    
        </div>
        </div>
        
        
    </section>
    
    
    
    
    
    
	<script>
	const key = "0c5277606b20ef880a6c3aec340bb83b"

	const client_id = "p3EkwlpyD99frDpNN5th";
	const client_secret = "_t4XeBaQvU";
	const test1 = '${dailyMovie }'
	const test2 = JSON.parse(test1)
		for(let i = 0;i< test2.boxOfficeResult.dailyBoxOfficeList.length ; i++ ){
			const movieName = test2.boxOfficeResult.dailyBoxOfficeList[i].movieNm
			
			const movieCode = test2.boxOfficeResult.dailyBoxOfficeList[i].movieCd
    		const movieCd = encodeURI(movieCode);
    		
    		const url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=" +key +"&movieCd=" + movieCd; 
    		const opt ={
    				method : 'GET'
    		}
    		fetch(url, opt)
    		.then(resp => resp.json())
    		.then(json => {
    			watchGradeNm = json.movieInfoResult.movieInfo.audits[0].watchGradeNm
				const li = document.createElement('li')
				const span = document.createElement('span')
				const b = document.createElement('b')
				li.append(span)
				li.append(b)
				
				span.innerHTML = watchGradeNm
				b.innerHTML = movieName
				
				document.getElementById('daily').appendChild(li)
    		})
			
			
		}
	
	</script>    
    
    
    <script>
        $('#choice1 p').on('click', function(){
            $(this).css({
               'border':'1px dotted #ccc',
                'color' : 'red',
                'background':'#fff',
                'font-weight':'bold'
            }).parent().siblings().find('p').css({
                'border':'none',
                'color' : '#000',
                'background':'#eee',
                'font-weight':'normal'
            });
            
            $(this).siblings('.sub').stop().show().parent().siblings().find('.sub').stop().hide();
        })
        
        $('#choice1 .sub li').on('click', function(){

            $(this).css({
               'border':'1px dotted #ccc',
                'color' : 'red',
                'font-weight':'bold'
            }).siblings().css({
                'border':'none',
                'color' : '#000',
                'font-weight':'normal'
            });
            
            const t= $(this).text();
            console.log(t)
        })
        
                
        $('#choice2 li').on('click', function(){
            $(this).css({
               'border':'1px dotted #ccc',
                'color' : 'red',
            }).siblings().css({
                'border':'none',
                'color' : '#000',                
            });
            const t2= $(this).find('b').text();
            console.log(t2)
        })
    </script>
    
    
    <script>
        var dateForm = document.getElementById('dateForm')
               
        const date = new Date()
        const week = ['일','월','화','수','목','금','토']
        var day = date.getDate()
        var w = date.getDay()

        for(let i = 0; i < 7; i++){
            
            const li = document.createElement('li')
            const p1 = document.createElement('p')
            const span = document.createElement('span')
            
            if(w == 6){
                li.setAttribute("style", "color:blue")
            }else if(w == 7){
                w = 0
                li.setAttribute("style", "color:red")
            }
            p1.textContent = day
            span.textContent = week[w]
            w++
            day++
            li.appendChild(p1)
            li.appendChild(span)
            dateForm.appendChild(li)
        }
        
        
    </script>
    
    <script>
    $('#dateForm li').on('click', function(){
        $(this).siblings().removeClass()
        $(this).addClass('on')
        
        const t3 = $(this).find('p').text()
        console.log(t3)
    })
    </script>


<%@ include file = "../footer.jsp" %>