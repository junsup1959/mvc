<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
// interceptor 로 로그인 실패시에도 로그인 화면으로 가게됨.
	const msg = '${msg}'
	alert(msg);
	location.href = '${cpath}/admin'
</script>
</body>
</html>