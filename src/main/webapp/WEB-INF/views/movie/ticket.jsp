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
                <ul class="movie">
                    <li><span>[등급]</span><b>영화1</b></li>
                    <li><span>[등급]</span><b>영화2</b></li>
                    <li><span>[등급]</span><b>영화3</b></li>
                    <li><span>[등급]</span><b>영화4</b></li>
                    <li><span>[등급]</span><b>영화5</b></li>
                    <li><span>[등급]</span><b>영화6</b></li>
                    <li><span>[등급]</span><b>영화7</b></li>
                    <li><span>[등급]</span><b>영화8</b></li>
                    <li><span>[등급]</span><b>영화9</b></li>
                    <li><span>[등급]</span><b>영화10</b></li>
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