<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
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


	<h1>상품등록 페이지</h1>
	<form enctype="multipart/form-data" action="${pageContext.request.contextPath}/AddGoodsList" method="post">
		<table border="1">
			
			<tr>
				<th>상품명</th>
				<td><input type="text" name="goodsName" id = "goodsName"></td>
			</tr>
			<tr>
				<th>판매가격</th>
				<td><input type="number" name="goodsPrice" id = "goodsPrice"></td>
			</tr>
			<tr>
				<th>솔드아웃</th>
				<td>
					<input type="radio" name="soldout" id = "soldout" value="Y">판매중 <input type="radio" name="soldout" id = "soldout" value="N">★솔드아웃★
				</td>
			</tr>
			<tr>
				<th>카테고리</th>
				<td>
					<select name = "goodsCategory" id = "goodsCategory">
						<option value=''>--선택--</option>
						<option value='육류'>육류</option>
						<option value='육가공류'>육가공류</option>
						<option value='과일'>과일</option>
						<option value='기름'>기름</option>
						<option value='건강식품'>건강식품</option>
						
					</select>
				</td>
			</tr>
			<tr>
				<th>추천상품</th>
				<td><input type="number" name="hit" id = "hit">☆☆☆</td>
			</tr>
			<tr>
				<th>사진등록</th>
				<td>
					<div><input type="file" name="filename" accept="image/jpeg, image/png"></div>
				</td>
			</tr>
			<tr>
				<th>관리자</th>
				<td><input type="text" name="empId" id = "empId" value= "${loginEmp.empId}" readonly="readonly"></td>
				
			</tr>
		</table>
		<button type="submit">상품등록</button>
	</form>
</body>
</html>

