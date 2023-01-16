<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>add address</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script>
			$(document).ready(function(){
				$('#addAddressBtn').click(function(){
					if($('#address').val() == ''){
						alert('내용을 입력하세요.');
						return;
					}
					
					$('#addAddressForm').submit();
				});
			});
		</script>
	</head>
	<body>
		<!-- 로그인(회원) -->
		<jsp:include page="/inc/menuForCustomer.jsp"></jsp:include>
		
		<!-- 본문 -->
		<h1>ADD ADDRESS</h1>
		<form action="${pageContext.request.contextPath}/AddAddress" method="post" id="addAddressForm">
			<table>
				<tr>
					<th>주소</th>
					<td>
						<input type="text" name="address" id="address" placeholder="추가할 주소 입력">
					</td>
				</tr>
			</table>
			<button type="button" id="addAddressBtn">추가</button>
		</form>
	</body>
</html>