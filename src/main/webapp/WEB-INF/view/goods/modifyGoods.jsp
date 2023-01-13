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


	<h1>상품수정 페이지</h1>
	<form action="${pageContext.request.contextPath}/ModifyGoods" method="post">
		<input type="hidden" name="goodsCode" value="${goods.goodsCode}">
		<table border="1">
			<tr>
				<th>상품코드</th>
				<td>${goods.goodsCode}</td>
			</tr>
			
			<tr>
				<th>상품명</th>
				<td><input type="text" name="goodsName" id = "goodsName" value="${goods.goodsName}"></td>
			</tr>
			<tr>
				<th>판매가격</th>
				<td><input type="number" name="goodsPrice" id = "goodsPrice" value ="${goods.goodsPrice}">원</td>
			</tr>
			<tr>
				<th>솔드아웃</th>
							
				<td>
					<c:if test="${goods.soldout eq 'Y'}">
						<input type="radio" name="soldout" value="Y" checked="checked">판매중 
						<input type="radio" name="soldout" value="N">★솔드아웃★
					</c:if>
					<c:if test="${goods.soldout eq 'N'}">
						<input type="radio" name="soldout" value="Y">판매중
						<input type="radio" name="soldout" value="N" checked="checked">★솔드아웃★
					</c:if>
				</td>

				
			</tr>
			<tr>
				<th>카테고리</th>
				
				
				<td>
					<select name = "goodsCategory" id = "goodsCategory">
						<c:if test="${goods.goodsCategory eq '육류'}">
							<option value='육류' selected="selected">육류</option>
							<option value='육가공류'>육가공류</option>
							<option value='과일'>과일</option>
							<option value='기름'>기름</option>
							<option value='건강식품'>건강식품</option>
						</c:if>
						
						<c:if test="${goods.goodsCategory eq '육가공류'}">
							<option value='육류'>육류</option>
							<option value='육가공류' selected="selected">육가공류</option>
							<option value='과일'>과일</option>
							<option value='기름'>기름</option>
							<option value='건강식품'>건강식품</option>
						</c:if>
						
						<c:if test="${goods.goodsCategory eq '과일'}">
							<option value='육류'>육류</option>
							<option value='육가공류'>육가공류</option>
							<option value='과일' selected="selected">과일</option>
							<option value='기름'>기름</option>
							<option value='건강식품'>건강식품</option>
						</c:if>
						
						<c:if test="${goods.goodsCategory eq '기름'}">						
							<option value='육류' >육류</option>
							<option value='육가공류'>육가공류</option>
							<option value='과일'>과일</option>
							<option value='기름' selected="selected">기름</option>
							<option value='건강식품'>건강식품</option>
						</c:if>
						
						<c:if test="${goods.goodsCategory eq '건강식품'}">			
							<option value='육류' >육류</option>
							<option value='육가공류'>육가공류</option>
							<option value='과일'>과일</option>
							<option value='기름'>기름</option>
							<option value='건강식품' selected="selected">건강식품</option>
						</c:if>
					</select>
				</td>
				
				
			</tr>
			<tr>
				<th>상품사진</th>
				<td>
					<img src="${pageContext.request.contextPath}/upload/${goods.fileName}" width="400" height="400">
				</td>
			</tr>
			<tr>
				<th>관리자</th>
				<td><input type="text" name="empId" id = "empId" value="${loginMember.empId}"></td>
			</tr>
		</table>
		<button type="submit">상품수정</button>
	</form>

</body>
</html>