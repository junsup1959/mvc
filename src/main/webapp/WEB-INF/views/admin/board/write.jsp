<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="../header.jsp" %>

    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <script src="${cpath }/resources/summernote/summernote-lite.js"></script>
	<script src="${cpath }/resources/summernote/lang/summernote-ko-KR.js"></script>
	<link rel="stylesheet" href="${cpath }/resources/summernote/summernote-lite.css"> 
    
    
    <%-- 제이쿼리 충돌문제 차후 미해결시 재작성 --%>

<script>
$(document).ready(function() {
	//여기 아래 부분
	$('#summernote').summernote({
		  height: 340,                 // 에디터 높이
		  minHeight: null,             // 최소 높이
		  maxHeight: null,             // 최대 높이
		  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
		  lang: "ko-KR",					// 한글 설정
		  placeholder: '최대 2048자까지 쓸 수 있습니다',	//placeholder 설정
		  toolbar: [
			    // [groupName, [list of button]]
			    ['fontname', ['fontname']],
			    ['fontsize', ['fontsize']],
			    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
			    ['color', ['color']],
			    ['table', ['table']],
			    ['para', ['ul', 'ol', 'paragraph']],
			    ['height', ['height']],
			    ['insert',['picture','link','video']],
			    ['view', ['fullscreen', 'help']]
			  ],
		fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
		fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
		callbacks: {	//여기 부분이 이미지를 첨부하는 부분
			onImageUpload : function(files) {
				uploadSummernoteImageFile(files[0],this);
			}	
		}
	});
	function uploadSummernoteImageFile(file, editor) {
		data = new FormData();
		data.append("file", file);
		$.ajax({
			data : data,
			type : "POST",
			url : "${cpath}/admin/board/write/uploadSummernoteImageFile",
			contentType : false,
			processData : false,
			success : function(data) {
            	//항상 업로드된 파일의 url이 있어야 한다.
				$(editor).summernote('insertImage', data.url);
			}
		});
	}
		
});
</script>

<section id="bodyWrap">
	<div class="noticeWrap">
		<form method="post" enctype="multipart/form-data">
			<input type="hidden" name="admin_num" value="${ad_login.admin_num}">
			<p><input type="text" name="board_title" placeholder="제목" class="b-title"></p>
		  	<p>
		  		<span id="bdate_span">시작일</span>
		  		<input type="date" name="board_bdate" id='bdate'>
				<span id="edate_span">종료일</span>
				<input type="date" name="board_edate" id='edate'>
			</p>
		  	<p>
			  <span>지점</span> 
			  <select name="board_store">
			  		<option value="부산">서울점</option>
			  		<option value="서울">부산점</option>
			  	</select>

		  		&nbsp;&nbsp;<span>구분</span>
		  		<select name="board_notice" id="ne">
		  			<option value="E">이벤트</option>
		  			<option value="N">공지</option>
		  		</select>
		  	</p>
		  	<p><input name="file" type="file"></p>
		   	<p>
		   		<textarea id="summernote" name="board_content"></textarea>
		   	</p>
		 	<p>
		 		<button class="btn2">공지/이벤트작성</button>
		 	</p>
	 	</form>
	</div>
</section>

<script>
	const select = document.getElementById('ne')
	const bdate = document.getElementById('bdate')
	const edate = document.getElementById('edate')
	const bspan=document.getElementById('bdate_span')
	const espan=document.getElementById('edate_span')
	
	function getToday(){
    var date = new Date();
    var year = date.getFullYear();
    var month = ("0" + (1 + date.getMonth())).slice(-2);
    var day = ("0" + date.getDate()).slice(-2);

    return year + "-" + month + "-" + day;
	}
	
	
	select.onchange = function(event){
		if(select.selectedIndex==1){//공지 선택
			bspan.innerText ='작성일';
			espan.innerText ='';
			bdate.value = getToday();
			bdate.required=true;
			edate.setAttribute("type", "hidden");
			edate.required=false;
		}else{
			bspan.innerText ='시작일';
			espan.innerText ='종료일';
			bdate.value = '';
			edate.setAttribute("type", "date");
			edate.required=true;
		}
	}
	
</script>

<%@include file="../footer.jsp" %>