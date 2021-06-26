<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>MVC</title>
    <link href="${cpath }/resources/css/style.css" rel="stylesheet">
    <link href="${cpath }/resources/css/body.css" rel="stylesheet">
    <link href="${cpath }/resources/css/movie.css" rel="stylesheet">
    <link href="${cpath }/resources/css/slick.css" rel="stylesheet">
    <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
    <script src="${cpath }/resources/js/jquery-1.12.4.js"></script>
    <script src="${cpath }/resources/js/slick.min.js"></script>
    <script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" type="text/javascript"></script>
    <link rel="stylesheet" href="http://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
    <link rel="stylesheet" href="${cpath }/resources/css/style.css">
</head>

<script>
$(document).ready(function(){
    ////////////////////제이쿼리 시작///////////////////////////////////////////
//        $("p").on("click",function(){
//            $("h1").toggle();
//        });
    
    $(".slider-main").slick({
        autoplay:true,
        dots:true,
        prevArrow:"<div class='prev'></div>",
        nextArrow:"<div class='next'></div>",
//        responsive: [//반응형웹 - 모바일 크기에서 화살표 안보이게 하기
//        { 
//            breakpoint: 768,
//            settings: {
//            arrows:false,
//            dots: false
//            }
//        }
    
    });
    
    // menu
    $(".menu ul li").hover(function() {
       $(this).find(".sub").stop().slideDown(200);
        $(".mbg").stop().slideDown(200);
    }, function(){
        $(this).find(".sub").stop().slideUp(200);
        $(".mbg").stop().slideUp(200);
    });
    
    
    // tab
    var tabBtn = $(".tabBtn > ul > li");
    var tabCon = $(".tabCon > div");
    tabCon.hide().eq(0).show(); //tabCon 박스 둘다 숨기고 그 중 첫번째 박스만 보여줘라
        
        tabBtn.click(function(e){ //탭 버튼 클릭시
            e.preventDefault(); 
            var target = $(this); //현재 어떤 버튼이 클릭을 했는가?
            var index = target.index(); //클릭한 버튼의 번호 저장
            
            tabBtn.removeClass("active"); // 우선 active 삭제
            target.addClass("active"); // 클릭한 메뉴에 active 붙이기
            
            tabCon.css("display","none"); //tabCon을 안보이게 하고
            tabCon.eq(index).css("display", "block");
            //클릭한 탭메뉴에 해당하는 tabCon을 보여주기
            
        });
    
    ////////////////////제이쿼리 끝///////////////////////////////////////////   
});    
</script>
<body>
    <header id="header" class="clearfix">
        <div class="top-menu">
            <div class="top-left-nav">
                <ul class="clearfix">
                    <li><a href="">사이트맵</a></li>
                    <li><a href="${cpath }/event/qna">문의하기</a></li>
                    <li><a href="${cpath }/notice/?search=&keyword=&cate=3&page=1">공지사항</a></li>
                </ul>
            </div>
            
            <h1 class="logo"><a href="${cpath }/">MVC</a></h1>
            
            <div class="top-right-nav">
                <ul class="clearfix">
                    <li><a href="${cpath }/member/membership">멤버십</a></li>
					<c:if test="${empty login }">                    
	                    <li><a href="${cpath }/member/login">로그인</a></li>
	                    <li><a href="${cpath }/member/join">회원가입</a></li>
                    </c:if>
					<c:if test="${not empty login }">                    
	                    <li><a href="${cpath }/member/logout">로그아웃</a></li>
	                    <li><a href="${cpath }/member/mypage?member_email=${login.member_email }" >마이페이지</a></li>
	                    
	                    
	                    
                    </c:if>
                    
                </ul>
            </div>
        </div>
        <!-- 상단 메뉴(sns, 로고, 로그인, 회원가입) -->
        
        <div class="mopen">
        <span></span>
        <span></span>
        <span></span>
        <span></span>
        </div>
        <!-- 반응형 웹 - 햄버거 메뉴 -->
        
        <nav class="menu">
           <div class="mbg"></div>
            <ul class="clearfix">
                <li><a href="${cpath }/movie/ticket">예매</a>
                    <ul class="sub clearfix">
                        <li><a href="${cpath }/movie/ticket">예매하기</a></li>
                        <li><a href="">상영시간표</a></li>
                    </ul>
                </li>
                <li><a href="${cpath }/movie/dailyMovie">영화</a>
                    <ul class="sub clearfix" >
                        <li><a href="${cpath }/movie/dailyMovie">현재상영작</a></li>
                        <li><a href="${cpath }/movie/weeklyMovie">상영예정작</a></li>
                        <li><a href="${cpath }/movie/review">리뷰/평점</a></li>
                    </ul>
                </li>
                <li><a href="${cpath }/movie/cinema">영화관</a>
                    <ul class="sub clearfix">
                        <li><a href="${cpath }/movie/cinema">해운대점</a></li>
                        <li><a href="">서면점</a></li>
                        <li><a href="">기타등등</a></li>
                    </ul>
                </li>
                <li><a href="${cpath }/event/?search=&keyword=&cate=2&page=1">이벤트</a>
                    <ul class="sub clearfix">
                        <li><a href="${cpath }/event/?search=&keyword=&cate=2&page=1">이벤트</a></li>
                        <li><a href="">시사회</a></li>
                        <li><a href="">제휴/할인</a></li>
                        <li><a href="${cpath }/event/last/?search=&keyword=&cate=4&page=1">지난이벤트</a></li>
                    </ul>
                </li>
            </ul>
        </nav>    
        <!-- main menu -->
    </header>
    <!-- header 끝 -->
