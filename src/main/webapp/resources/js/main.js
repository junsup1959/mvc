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
        responsive: [//반응형웹 - 모바일 크기에서 화살표 안보이게 하기
        { 
            breakpoint: 768,
            settings: {
            arrows:false,
            dots: false
            }
        }
    ]
    });
    
    // 모바일 메뉴 열기
    $(".mopen").on("click", function(){
       // $("nav").addClass("on"); 
        $(this).toggleClass("on");
        $("nav").toggleClass("on");
    });
    
    $("nav>ul>li").on("click",function(){
        $("nav>ul>li").removeClass("on");
        $(this).addClass("on"); 
    });
    
    
    ////////////////////제이쿼리 끝///////////////////////////////////////////   
});







