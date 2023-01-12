<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>address List</title>
	</head>
	<body>
		<!-- 로그인(회원) -->
		<jsp:include page="/inc/menuForCustomer.jsp"></jsp:include>
		
		<!-- 본문 -->
		<h1>ADDRESS LIST</h1>
		<c:if test="${fn:length(addressList) == 0}"> <!-- 리스트에 데이터가 없으면 -->
			<table>
				<tr>
					<th>등록된 주소가 없습니다.</th>
				</tr>
			</table>
		</c:if>
		<c:if test="${fn:length(addressList) > 0}"> <!-- 리스트에 데이터가 있으면 -->
			<table>
				<tr>
					<th>주소지</th>
					<th>생성일</th>
					<th>수정/삭제</th>
				</tr>
				<c:forEach var="address" items="${addressList}">
					<tr>
						<td>${address.address}</td>
						<td>${address.createdate}</td>
						<td>
							<a href="${pageContext.request.contextPath}/ModifyAddress?addressCode=${address.addressCode}">수정</a>
							<a href="${pageContext.request.contextPath}/RemoveAddress?addressCode=${address.addressCode}">삭제</a>
						</td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
		<a href="${pageContext.request.contextPath}/AddAddress">주소 추가</a>
	</body>
</html>