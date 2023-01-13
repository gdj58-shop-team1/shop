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
				
				var optionCk = $('select option:selected').val(); // 선택된 옵션의 값
				console.log(optionCk);
				
				$('#addressCode').change(function(){ // 주소 선택 값이 바뀌면
					optionCk = $('select option:selected').val(); // 선택된 옵션의 값을 가져오기
					if(optionCk != 0){ // 주소 선택 값이 있으면
						$('#newAddress').val(''); // 새 주소 입력칸을 비우고
						$("#newAddress").attr("disabled",true); // 비활성화
					} else { // 선택 안하면
						$("#newAddress").attr("disabled",false); // 활성화
					}
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
					$('#addOrderForm').submit();
				});
				
				$('#usePoint').change(function(){
					"<c:out value='${orderCustomer.point}'/>";
					let orderPoint = "<c:out value='${orderCustomer.point}'/>";
					let usePoint = Number($('#usePoint').val());
					
					if(usePoint < 0) { // 사용하려는 point가 음수 일경우
						$('#orderPoint').text("<c:out value='${orderCustomer.point}'/>");
						alert('0 이상의 포인트를 입력해주세요');
						return;
					}
					
					if(orderPoint < usePoint) { // 사용하려는 point가 보유 포인트 보다 클 경우
						$('#orderPoint').text("<c:out value='${orderCustomer.point}'/>");
						alert('보유 포인트가 모자랍니다.');
						return;
					}

					// 포인트 처리
					console.log('orderPoint : ' + orderPoint);
					console.log('usePoint : ' + usePoint);
					let tempPoint = orderPoint - usePoint;
					$('#orderPoint').text(tempPoint);
					console.log(usePoint);
					console.log($('#orderPoint').val());
					
					// 포인트 사용으로 인해 변경된 가격 처리
					
					// 전체 가격 처리
					let totalPrice = "<c:out value='${totalPrice}'/>";
					$('#totalPrice').text(totalPrice - usePoint);
					
					// 상품별 가격처리
					let orderPriceList = document.querySelectorAll('.orderPrice');
					let orderPriceHiddenList = document.querySelectorAll('.orderPriceHidden');
					let shareUsePointList = document.querySelectorAll('.shareUsePotint');
					let remainderUsePointList = document.querySelectorAll('.remainderUsePoint');
					
					let listLength = orderPriceList.length;
					
					let shareUsePoint = Math.floor(usePoint / listLength);
					let remainderUsePoint = usePoint % listLength;
					console.log(shareUsePoint);
					console.log(remainderUsePoint);
					for(let i = 0; i<listLength; i++) {
						
						let orderPrice = $(orderPriceHiddeneList[i]).val();
						
						if(i == 0) {
							orderPrice = orderPrice - shareUsePoint - remainderUsePoint;
							$(orderPriceList[i]).val(orderPrice);
							$(shareUsePointList[i]).val(shareUsePoint + remainderUsePoint);
						} else {
							orderPrice = orderPrice - shareUsePoint;
							$(orderPriceList[i]).val(orderPrice);
							$(shareUsePointList[i]).val(shareUsePoint);
						}
					}
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
		<form action="${pageContext.request.contextPath}/AddOrderFromCart" method="post" id="addOrderForm">
		 	<!-- 자바스크립트로 수정 -->
		 	<!-- 상품코드, (상품가격), 아이디, 옵션, 주소코드, 주문수량, 총가격 -->
		 	<table border="1" style="width:50%;"> <!-- 주문고객정보 -->
	 			<tr>
	 				<th colspan="4">주문회원 정보</th>
	 			</tr>
		 		<tr>
		 			<td>이름</td>
		 			<td>${orderCustomer.customerName}</td>
		 			<td>전화번호</td>
		 			<td>${orderCustomer.customerPhone}</td>
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
	 			<c:forEach var="map" items="${cartList}">
	 				<input type="hidden" name="goodsCode" value="${map.goodsCode}">
	 				<input type="hidden" name="goodsName" value="${map.goodsName}">
				 	<input type="hidden" name="orderPrice" value="${map.orderPrice}"> 	
				 	<input type="hidden" name="goodsOption" value="${map.goodsOption}">
				 	<input type="hidden" name="orderQuantity" value="${map.orderQuantity}">
				 
		 			<tr>
		 				<td id="filename"><img src="${pageContext.request.contextPath}/upload/${map.fileName}" name="filename" width="100" height="100"></td>
			 			<td id="goodsName">${map.goodsName}</td>
			 			<td>
			 				<input type="text" id="orderPrice" class="orderPrice" value="${map.orderPrice}" readonly="readonly">
			 				<input type="hidden" id="orderPriceHidden" class="orderPriceHidden" value="${map.orderPrice}" readonly="readonly">
			 			</td>
			 			<td>${map.orderQuantity}</td>
			 			<td>${map.goodsOption}</td>
			 		</tr>
	 			</c:forEach>

		 		<tr>
		 			<td colspan="1">잔여 포인트 <span id="orderPoint">${orderCustomer.point}</span></td>
		 			<td colspan="2">
		 				<input type="number" name="usePoint" id="usePoint" placeholder="사용할 포인트 입력"> P
		 				<button type="button">적용</button>
		 			</td>
	 				<td colspan="2">총 주문금액: <span id="totalPrice">${totalPrice}</span>원</td> <!-- 자바스크립트로 수정 -->
	 			</tr>
		 	</table>
		 	
			<input type="hidden" name="shareUsePoint" value="0">
		 	<input type="hidden" name="remainderUsePoint" value="0">
		 	<input type="hidden" name="totalPrice" value="${totalPrice}">
		 	
			<button type="button" id="addOrderBtn">주문</button>
		</form>
	</body>
</html>