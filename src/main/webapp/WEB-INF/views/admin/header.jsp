<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>관리자</title>
    <link rel="stylesheet" href="http://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
    <link rel="stylesheet" href="${cpath }/resources/css/admin.css">
<script src="http://code.jquery.com/jquery-1.2.4.js"></script>
</head>
<script>

</script>
<body>
    <header class="cf">
        <h1><a href="${cpath }/admin">MVC</a></h1>
        <nav class="adminMy">
	        <h4>${ad_login.admin_name }님</h4>     
	        	<ul class="cf">
	        		<li><a href="${cpath }/admin/adminMypage">마이페이지</a></li>
	        		<li><a href="${cpath }/admin/logout">로그아웃</a></li>
	        		<li><a href="">기타</a></li>
	        	</ul>
        </nav>
    </header>

    <nav class="adminMenu">
        <ul class="cf">
            <li><a href="${cpath }/admin/admin_member">인사관리</a></li>
            <li><a href="#">영화관리</a></li>
            <li><a href="${cpath }/admin/board">공지/이벤트관리</a></li>
             <li><a href="#">리뷰관리</a></li>
            <li><a href="#">사내게시판</a></li>
           
        </ul>
    </nav>
