<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script language=javascript>
	$(document).ready(function(){
				
	});
 </script>
 <script>
	 function chageLangSelect(){
		    var langSelect = document.querySelectorAll('.goodsOption');
		    // select element에서 선택된 option의 value가 저장된다.
		    var selectValue = langSelect.options[langSelect.selectedIndex].value;
		 
		    // select element에서 선택된 option의 text가 저장된다.
		    var selectText = langSelect.options[langSelect.selectedIndex].text;
		    
		    console.log(selectValue);
			console.log(selectText);
		}
	 const showValue = (target) => {
		  const value = target.value;
		  const text =  target.options[target.selectedIndex].text;
		  
		  document.querySelector(`div`).innerHTML = `text: ${text} value: ${value}`;
		}
 </script>
<title>장바구니</title>
</head>
<body>
	<!-- 세션 정보별로 메뉴 분기 -->
	<c:if test="${loginMember == null}"> <!-- 비로그인 -->
		<jsp:include page="/inc/menu.jsp"></jsp:include>	
	</c:if>
	<c:if test="${loginMember.level == 0}"> <!-- 로그인(회원) -->
		<jsp:include page="/inc/menuForCustomer.jsp"></jsp:include>	
	</c:if>
	<c:if test="${loginMember.level == 1}"> <!-- 로그인(사원) -->
		<jsp:include page="/inc/menuForEmp.jsp"></jsp:include>	
	</c:if>
	
	<h1>장바구니</h1>
	<form method="post" id = "cartListForm">
		<table border="1">
			<thead>
				<tr>
					<th>상품이미지</th>
					<th>상품명</th>
					<th>상품 옵션</th>
					<th>수량</th>
					<th>가격</th>
				</tr>
			</thead>
			<c:forEach var="map" items="${cartList}" varStatus="vs">
				<input type="text" id="${cartList}GoodsCode" name="goodsCode" value="${map.goodsCode}" hidden="hidden">
				<tr>					
					<td><img src="${pageContext.request.contextPath}/upload/${map.fileName}" id="fileName" name="fileName" width="100" height="100"></td>

					<td><input type="text" id="goodsName" name="goodsName" value="${map.goodsName}"></td>

					<td>
						
						<select name="goodsOption" id="goodsOption" class="goodsOption" onchange="showValue(this)">
							<c:if test="${map.goodsOption eq '일반포장'}">
								<option value="일반포장" selected="selected">1) 일반포장(+0원)</option>
								<option value="고급포장">2) 고급포장(+2,500원)</option>
								<option value="보자기">3) 보자기(+5,900원)</option>
							</c:if>
							
							<c:if test="${map.goodsOption eq '고급포장'}">
								<option value="일반포장">1) 일반포장(+0원)</option>
								<option value="고급포장" selected="selected">2) 고급포장(+2,500원)</option>
								<option value="보자기">3) 보자기(+5,900원)</option>
							</c:if>
							
							<c:if test="${map.goodsOption eq '보자기'}">
								<option value="일반포장">1) 일반포장(+0원)</option>
								<option value="고급포장">2) 고급포장(+2,500원)</option>
								<option value="보자기" selected="selected">3) 보자기(+5,900원)</option>
							</c:if>
						</select>
					</td>

					<td>
						<input type="number" name="cartQuantity" id="cartQuantity" class="goodsName" value="${map.cartQuantity}">
						<button type="button" id="minusBtn">-</button>
						<input type="number" name="cartQuantity" id="cartQuantity" class="goodsName" readonly="readonly" value="${map.cartQuantity}">
						<button type="button" id="plusBtn">+</button>
					</td>

					<td>${map.orderPrice}</td>
				</tr>
					
			</c:forEach>
		</table>
		
		<button type="button" id="orderBtn">주문하기</button>
	</form>
</body>
</html>