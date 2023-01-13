<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>addOrderDirect</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script>
			$(document).ready(function(){
				
				var customerPoint = Number('<c:out value="${customer.point}"/>');
				var goodsPrice = Number('<c:out value="${goodsPrice}"/>');
				var optionCk = $('select option:selected').val(); // 선택된 옵션의 값
				console.log(optionCk);
				console.log(goodsPrice);
				
				$('#addressCode').change(function(){ // 주소 선택 값이 바뀌면
					optionCk = $('select option:selected').val(); // 선택된 옵션의 값을 가져오기
					if(optionCk != 0){ // 주소 선택 값이 있으면
						$('#newAddress').val(''); // 새 주소 입력칸을 비우고
						$("#newAddress").attr("disabled",true); // 비활성화
					} else { // 선택 안하면
						$("#newAddress").attr("disabled",false); // 활성화
					}
				});
				
				// 포인트 적용 버튼이 눌리면
				$('#applyPoint').click(function(){
					if(Number($('#point').val()) > customerPoint){
						alert('보유 포인트가 모자랍니다.');
						$('#point').val('');
						return;
					}
					if(Number($('#point').val()) < 0){
						alert('0 이상 입력가능합니다.');
						$('#point').val('');
						return;
					}
					$('#currentPoint').text(customerPoint-Number($('#point').val())); // 현재 포인트 변경
					$('#totalPrice').text(goodsPrice-Number($('#point').val())); // 총 금액 변경
					$('#orderPrice').attr('value', goodsPrice-Number($('#point').val())); // 넘어갈 주문 금액 value 변경
				});
				
				$('#addOrderBtn').click(function(){
					if($('#newAddress').val() && optionCk != 0){ // 두 곳에 주소 작성이 되었을 경우
						console.log($('#newAddress').val());
						alert('주소는 한 곳에만 입력가능합니다.(주소 선택 또는 새 주소 입력)');
						return;
					} else if(!$('#newAddress').val() && optionCk == 0){ // 주소 작성이 되지 않았을 경우 
						console.log($('#newAddress').text());
						alert('기존 주소를 선택하거나 새 주소를 입력하세요.');
						return;
					}
					if(Number($('#point').val()) > customerPoint){
						alert('사용 가능한 포인트 보다 입력 포인트가 많습니다.');
						return;
					}
					$('#addOrderForm').submit();
				});
				
			});
		</script>
	</head>
	<body>
		<!-- 
			주문 페이지 ->(이 시점에 DB orders 테이블로 넘어감) 주문완료
			사용자 정보(사용자 포인트 readonly, 이름readonly, 번호readonly, 주소)
			주문 상품 정보(상품 코드, 상품 이름readonly, 상품 갯수readonly, 총 주문 금액readonly - 사용자 포인트 사용 여부에 따라 달라짐)
		 -->

		<!-- 로그인(회원) -->
		<jsp:include page="/inc/menuForCustomer.jsp"></jsp:include>

		<h1>Add Order Direct</h1>
		<form action="${pageContext.request.contextPath}/AddOrderDirect" method="post" id="addOrderForm">
			<input type="hidden" name="goodsCode" value="${goodsCode}">
		 	<input type="hidden" name="orderPrice" id="orderPrice" value="${order.orderPrice}">
		 	<!-- 상품코드, (상품가격), 아이디, 옵션, 주소코드, 주문수량, 총가격 -->
		 	<table border="1" style="width:50%;"> <!-- 주문고객정보 -->
	 			<tr>
	 				<th colspan="4">주문회원 정보</th>
	 			</tr>
		 		<tr>
		 			<td>이름</td>
		 			<td>${customer.customerName}</td>
		 			<td>전화번호</td>
		 			<td>${customer.customerPhone}</td>
		 		</tr>
		 		<tr>
		 			<td colspan="1">주소</td>
		 			<td colspan="3">
		 				<c:if test="${fn:length(addressList) == 0}"> <!-- 리스트에 데이터가 없으면 -->
			 				<select name="addressCode">
			 					<option value="0">====주소 선택====</option>
			 				</select>
		 				</c:if>
		 				<c:if test="${fn:length(addressList) > 0}"> <!-- 리스트에 데이터가 있으면 -->
			 				<select name="addressCode" id="addressCode">
			 					<option value="0">====주소 선택====</option>
			 					<c:forEach var="address" items="${addressList}">
			 						<option value="${address.addressCode}">${address.address}</option>
			 					</c:forEach>
			 				</select>
		 				</c:if>
		 			</td>
		 		</tr>
		 		<tr>
		 			<td colspan="1">
	 					새 주소 추가
	 				</td>
	 				<td colspan="3">
	 					<input type="text" name="newAddress" id="newAddress" placeholder="추가할 주소지 작성">
	 				</td>
		 		</tr>
		 		<tr>
		 			<td colspan="4">사용가능 포인트: <span id="currentPoint">${customer.point}</span>P</td>
		 		</tr>
		 	</table>
		 	<br>
		 	<table border="1" style="width:50%;"> <!-- 주문상품정보 -->
	 			<tr>
	 				<th colspan="5">주문상품</th>
	 			</tr>
	 			<tr>
	 				<th colspan="2">상품</th>
		 			<th>상품금액</th>
		 			<th>갯수</th>
		 			<th>상품옵션</th>
	 			</tr>
	 			<tr>
	 				<td>
	 					<img src="${pageContext.request.contextPath}/upload/${fileName}" width="100" height="100">
	 				</td>
		 			<td>${goodsName}</td>
		 			<td>${goodsPrice}</td>
		 			<td>${order.orderQuantity}</td>
		 			<td>${order.goodsOption}</td>
		 		</tr>
		 		<tr>
		 			<td colspan="1">사용할 포인트</td>
		 			<td colspan="2">
		 				<input type="number" name="point" id="point" max="${customer.point}" placeholder="사용할 포인트 입력">P
		 				<button type="button" id="applyPoint">적용</button>
		 			</td>
	 				<td colspan="2">총 주문금액: <span id="totalPrice">${order.orderPrice}</span>원</td> <!-- 자바스크립트로 수정 -->
	 			</tr>
		 	</table>

			<button type="button" id="addOrderBtn">주문</button>
		</form>
	</body>
</html>