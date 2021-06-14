<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
  	<footer  class="cf">
        <div>
            <div><h2>MVC</h2></div>
            <div>03058 서울시 종로구 율곡로 75 현대빌딩 사업자등록번호 101-81-16293 / 1577-7755<br>
                © MVC Movie Review C</div>
            <div>
                <i class="xi-kakaotalk"></i>
                <i class="xi-facebook-official"></i>
                <i class="xi-instagram"></i>
            </div>
        </div>
    </footer>

<script>
$(function(){
	$("#mopen").click(function(){
		//$("nav").show();
		$("nav").toggleClass("on");
		$(this).toggleClass("on");

	});


});
</script>
    
</body>
</html>
