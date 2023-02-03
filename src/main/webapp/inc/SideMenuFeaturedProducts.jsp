<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- side 추천상품 -->					
<div class="p-t-35">
	<h4 class="mtext-112 cl2 p-b-33">
		Featured Products
	</h4>
	
	<ul>
		<c:forEach var="sg" items="${sideGoodsList}">
		<li class="flex-w flex-t p-b-35">
			<a href="${pageContext.request.contextPath}/GoodsOne?goodsCode=${sg.goodsCode}" class="wrao-pic-w size-214 hov-ovelay1 m-r-20">
				<img src="${pageContext.request.contextPath}/upload/${sg.fileName}" width="90px" height="110px" >
			</a>

			<div class="size-215 flex-col-t p-t-8">
				<a href="${pageContext.request.contextPath}/GoodsOne?goodsCode=${sg.goodsCode}" class="stext-116 cl8 hov-cl1 trans-04">
					${sg.goodsName}
				</a>

				<span class="stext-116 cl6 p-t-20">
					${sg.goodsPrice}원
				</span>
			</div>
		</li>
		</c:forEach>
	</ul>
</div>