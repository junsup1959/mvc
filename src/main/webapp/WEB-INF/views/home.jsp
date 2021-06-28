<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@include file="header.jsp" %>
    

    <section id="slider">
        <div class="slider-main">
            <div class="slider-item">
                <a href=""><img src="https://caching2.lottecinema.co.kr/lotte_image/2021/Black/Black_1920774.jpg" alt=""></a>
            </div>
            <div class="slider-item">
                <a href=""><img src="https://caching2.lottecinema.co.kr/lotte_image/2021/Jam/Jam_1920774.jpg" alt=""></a>
            </div>
            <div class="slider-item">
                <a href=""><img src="https://caching2.lottecinema.co.kr/lotte_image/2021/Room/Room_1920774.jpg" alt=""></a>
            </div>
            <div class="slider-item">
                <a href=""><img src="https://caching2.lottecinema.co.kr/lotte_image/2021/Ella/Ella_1920774.jpg" alt=""></a>
            </div>
            <div class="slider-item">
                <a href=""><img src="https://caching2.lottecinema.co.kr/lotte_image/2021/Dark/0622/Dark_1920774.jpg" alt=""></a>
            </div>
            <div class="slider-item">
                <a href=""><img src="https://caching2.lottecinema.co.kr/lotte_image/2021/Luca/0602/Luca_1920774.jpg" alt=""></a>
            </div>
            <div class="slider-item">
                <a href=""><img src="https://caching2.lottecinema.co.kr/lotte_image/2021/Place/0602/Place_1920774.jpg" alt=""></a>
            </div>
        </div>
    </section>
    <!-- 슬라이드 메뉴 끝 -->
    
    <section id="tab">
        <div class="tabBtn">
            <ul  class="sub clearfix">
                <li class="active"><a href="">현재상영작 <span>TOP5</span></a></li>
                <li><a href="">상영예정작 <span>TOP5</span></a></li>
            </ul>
        </div>
        <div class="tabCon">
            <div>
                <ul class="clearfix">
                    <li>
                        <a href="#">
                            <img src="https://caching.lottecinema.co.kr//Media/MovieFile/MovieImg/202105/17387_103_1.jpg">
                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. </p>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <img src="https://caching.lottecinema.co.kr//Media/MovieFile/MovieImg/202106/17420_103_1.jpg">
                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. </p>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <img src="https://caching.lottecinema.co.kr//Media/MovieFile/MovieImg/202005/15586_103_1.jpg">
                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. </p>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <img src="https://caching.lottecinema.co.kr//Media/MovieFile/MovieImg/202101/16908_103_1.jpg">
                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <img src="https://caching.lottecinema.co.kr//Media/MovieFile/MovieImg/202106/17450_103_1.jpg">
                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. </p>
                        </a>
                    </li>
                </ul>
            </div>
            <div>
                <ul class="clearfix">
                    <li>
                        <a href="#">
                            <img src="https://caching.lottecinema.co.kr//Media/MovieFile/MovieImg/202106/17336_103_1.jpg">
                            <p></p>
                        </a>
                    </li>
                    
                    <li>
                        <a href="#">
                            <img src="https://caching.lottecinema.co.kr//Media/MovieFile/MovieImg/202105/17395_103_1.jpg">
                            <p></p>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <img src="https://caching.lottecinema.co.kr//Media/MovieFile/MovieImg/202106/17482_103_1.jpg">
                            <p></p>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <img src="https://caching.lottecinema.co.kr//Media/MovieFile/MovieImg/202106/17542_103_1.jpg">
                            <p></p>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <img src="https://caching.lottecinema.co.kr//Media/MovieFile/MovieImg/202106/17459_103_1.jpg">
                            <p></p>
                        </a>
                    </li>
                </ul>

            </div>
        </div>        
    </section>
    <!-- 탭메뉴(현재 상영작, 상영예정작) 끝 -->
    
    <section id="icon" class="clearfix">
       <div class="icon-item">
            <i class="xi-crown"></i>
            <p>멤버쉽</p>
        </div>
         <div class="icon-item">
            <i class="xi-calendar-list"></i>
            <p>상영시간표</p>
        </div>
        <div class="icon-item">
            <i class="xi-gift"></i>
            <p>이벤트</p>
        </div>
        <div class="icon-item">
            <i class="xi-coupon"></i>
            <p>할인카드안내</p>
        </div> 
        <div class="icon-item">
            <i class="xi-shop"></i>
            <p>스토어</p>
        </div>
    </section>
    <!-- 아이콘 끝 -->
    
     <section id="event" class="clearfix">
    	<c:if test="${not empty event }">
	    	<c:forEach var="event" items="${event}">
		        <div><a href="${cpath }/event/?search=&keyword=&cate=2&page=1" target="" title="이벤트 목록으로 이동하기">${event.board_title }</a></div>
		    </c:forEach>
        </c:if>
    </section>
    <!-- 이벤트 끝 -->
    
    <section id="content" class="clearfix">
        <div class="notice">
            공지사항
            <c:if test="${not empty notice }">
            <ul>
            <c:forEach var="no" items="${notice }">
                <li><a href="${cpath}/notice/${no.board_number}?search=&keyword=&cate=3&page=1">${no.board_title } <span>${no.board_bdate } </span></a></li>
            </c:forEach>
            </ul>
            </c:if>
        </div>
        <div class="store-notice">
           지점 공지
            <c:if test="${not empty notice }">
            <ul>
            <c:forEach var="no" items="${notice }">
                <li><a href="${cpath}/notice/${no.board_number}?search=&keyword=&cate=3&page=1">[${no.board_store }] ${no.board_title } <span>${no.board_bdate } </span></a></li>
            </c:forEach>
            </ul>
            </c:if>
        </div>
    </section>
    <!-- 공지사항(전체, 지점) 끝 -->
    
   

    
    
<%@ include file="footer.jsp" %>