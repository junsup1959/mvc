<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>


<%-- 1대 1 문의 페이지 여기도 DB가 필요 --%>

<section id="bodyWrapBg">
	<div class="qnaContent">
		<h2>1:1 문의</h2>
		<div class="topcont">
			<div class="recomment">
				<ul>
					<li style="font-size: 12px;">문의하시기 전 FAQ를 확인하시면 궁금증을 더욱 빠르게 해결하실 수 있습니다.</li>
				</ul>
			</div>
		</div>
		
		<div style="border: 1px solid #555; padding-left: 20px; ">
		<p style="height : 35px; line-height : 35px">
			<input type="checkbox" id="chk"><label> &nbsp;&nbsp; <strong>개인정보 수집에 대한 동의</strong></label>
		<span>[필수]</span>
		</p>
		
		</div>
		<div style="font-size:13px; line-height: 13px;">
			귀하께서 문의하신 다음의 내역은 법률에 의거하여 개인정보 수집,이용에 대한 본인의 동의가 필요한 항목입니다.<br><br>
			<b style="font-size : 15px; line-height : 18px; font-weight: bold; ">[개인정보의 수집 및 이용목적]</b><br>
			회사는 단체관람/대관 문의 내역의 확인,요청사항 처리 또는 완료시 원활한 의사소통 경로 확보를 위해 수집중입니다.<br><br>
			<b style="font-size : 15px; line-height : 18px;  font-weight: bold;">[수집하는 개인정보의 항목]</b><br>
			이름, 연락처, 이메일 주소<br><br>
			<b style="font-size : 15px; line-height : 18px;  font-weight: bold;">[개인정보의 보유기간 및 이용기간]</b><br>
			문의 접수 ~ 처리 완료 후 6개월<br>
			(단, 관계법령의 규정에 의하여 보존 할 필요성이 있는 경우에는 관계 법령에 따라 보존)<br>
			자세한 내용은 '개인정보 처리방침'을 확인하시기 바랍니다.<br>			
		</div>
		<div style="margin-top: 10px;font-size : 15px; line-height : 18px; font-weight: bold; "">* 원활한 서비스 이용을 위한 최소한의 개인정보이므로 동의하지 않을 경우 서비스를 이용하실 수 없습니다</div>
		<div class="qnaForm">
		<form method="post" action="">
			<table>
				<tr>
					<td>문의지점</td>
					<td colspan="3"><input type="radio">지점문의 
						<select title="지역선택">
							<option>서울</option>
							<option>대전</option>
							<option>부산</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>문의 유형</th>
					<td colspan="3">
						<select title="문의유형">
							<option>영화정보문의</option>
							<option>결제 관련문의</option>
							<option>이벤트 문의</option>
						</select>
					</td>
				</tr>
				<tr>
				<th>이름</th>
				<td><input type="text"></td>
				<th>이메일</th>
				<td><input type="email"></td>
				</tr>
				<tr>
				<th>휴대전화</th>
				<td colspan="3">
					<span><input type="text" name="num1"></span>-
					<span><input type="text" name="num2"></span>-
					<span><input type="text" name="num3"></span>
				</td>
				</tr>
				<tr>
				<th>제목</th>
				<td colspan="3"><input type="text"></td>
				</tr>
				<tr>
				<th>내용</th>
				<td colspan="3" >
					<textarea style="width : 800px;height : 150px; resize: none;" ></textarea>
				</td>
				</tr>
				<tr>
				<th>사진첨부</th>
				<td colspan="3">
					<ul>
						<li>JPEG, PNG 형식의 5M 이하의 파일만 첨부 가능합니다. (최대 5개) <input type="file"></li>
						<li> 개인정보가 포함된 이미지 등록은 자제하여 주시기 바랍니다.</li>
					</ul>
				</td>
				</tr>
			</table>
				<input type="submit" value="등록" class="btn3" >
		</form>
		</div>
	</div>
</section>
<%@ include file="../footer.jsp" %>