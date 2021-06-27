<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>
    <section id="visual">
        <h2>Movie reView Container</h2>
        <p>영화관 <br>사내 홈페이지</p>
    </section>

    <section id="contents">
        <div>
            <div>
               <h3>NEWs & Notice<small>more</small></h3>
                <c:if test="${not empty mainList }">
		            <ul>
		            <c:forEach var="no" items="${mainList }">
		                <li><a href="${cpath}/admin/board/read/${no.board_number}?search=&cate=${no.board_notice.equals('E')? 2: 3 }&keyword=&page=1">[${no.board_notice.equals('E')? '이벤트': '공지' }-${no.board_store }] ${no.board_title } <span>${no.board_bdate } </span></a></li>
		            </c:forEach>
		            </ul>
	            </c:if>
            </div>

            <div>
               <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3879.0483871687543!2d129.15843608790618!3d35.159666163390774!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x35688d594f295e25%3A0xce81d183b883faf7!2z67aA7IKw6rSR7Jet7IucIO2VtOyatOuMgOq1rCDsmrAx64-ZIDYyMi04!5e0!3m2!1sko!2skr!4v1624797648431!5m2!1sko!2skr" width="100%" height="250" frameborder="0" style="border:0;" allowfullscreen="" aria-hidden="false" tabindex="0"></iframe>            </div>
            <div>
                <h2><a href="tel:051-508-6119">전산실 : 051-508-6115~9</a></h2>
                <p>Fax : 1577-7755<br>
                 <a href="mailto:adminMVC@mvc.com">e-mail : adminMVC@mvc.com</a></p>
            </div>
        </div>
    </section>
    
    <%@include file="footer.jsp" %>