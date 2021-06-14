<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <style>
        * {margin: 0;padding: 0;}
        body {width : 1000px; margin: 0 auto; }
        h1 {margin-top: 250px; margin-left: 200px; color: teal; margin-bottom: 20px;}
        .wrap {position: relative; width: 600px; height: 200px; margin: 0 auto; border: 3px solid teal; border-radius: 40px;}
        .wrap::after {content:''; display: block; clear: both}
        .loginForm div {float: left; width: 200px; height: 200px; background: teal; border-radius: 30px 0 0 30px; text-align: center;}
        .loginForm div h2 {font-size: 40px; color: #fff; margin-top: 70px;}
        .loginForm form { padding-top: 20px; }
        .loginForm form input {width: 300px; height: 40px; line-height: 40px; margin-left: 30px; margin-bottom: 5px; padding: 5px 10px; font-size: 20px; border: 1px solid #ccc; border-radius: 5px;}
        .loginForm form input.btn {position: absolute; width: 150px; background: teal; color: #fff; border: none; right: 50px; bottom: 10px;}
        .loginForm form input.btn:hover {background: coral; }
    </style>
</head>
<body>
 <h1>MVC 직원</h1>
  <div class="wrap">
       <div class="loginForm">
          <div><h2>MVC</h2></div>
           <form method="POST">
               <p><input type="text" name="admin_num" placeholder="ID" required></p>
               <p><input type="password" name="admin_password" placeholder="비밀번호" required></p>
               <p><input type="submit" value="로그인" class="btn"></p>
           </form>
       </div>
   </div>
    
</body>
</html>