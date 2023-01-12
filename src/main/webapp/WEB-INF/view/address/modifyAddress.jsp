<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>modify address</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script>
			$(document).ready(function(){
				$('#modifyAddressBtn').click(function(){
					$('#modifyAddressForm').submit();
				});
			});
		</script>
	</head>
	<body>
		<!-- 로그인(회원) -->
		<jsp:include page="/inc/menuForCustomer.jsp"></jsp:include>
		
		<!-- 본문 -->
		<h1>MODIFY ADDRESS</h1>
		<form action="${pageContext.request.contextPath}/ModifyAddress" method="post" id="modifyAddressForm">
			<input type="hidden" name="addressCode" value="${addressCode}">
			<table>
				<tr>
					<th>주소</th>
					<td>
						<input type="text" name="address" id="address" value="${address}">
					</td>
				</tr>
			</table>
			<button type="button" id="modifyAddressBtn">수정</button>
		</form>
	</body>
</html>