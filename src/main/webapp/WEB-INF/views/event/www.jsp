<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <script src="${cpath }/resources/summernote/summernote-lite.js"></script>
	<script src="${cpath }/resources/summernote/lang/summernote-ko-KR.js"></script>
	<link rel="stylesheet" href="${cpath }/resources/summernote/summernote-lite.css"> 
    
    
    <%-- 제이쿼리 충돌문제 차후 미해결시 재작성 --%>

<script>
$(document).ready(function() {
	//여기 아래 부분
	$('#summernote').summernote({
		  height: 300,                 // 에디터 높이
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
			    ['color', ['forecolor','color']],
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
			url : "/uploadSummernoteImageFile",
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


</head>
<body>
	<h2>공지사항 작성하기</h2>
	<form method="post">
	<p><input type="text" name="title" placeholder="제목" ></p>
  	<p><input type="date" name="begin">시작일</p>
  	<p><input type="date" name="end">마감일</p>
  	<p><textarea id="summernote" name="content"></textarea></p>
 	<button>작성</button>
 	</form>
</body>
</html>