<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

		<!-- Header desktop -->
		<div class="container" style="z-index: 1;position: relative;">
			<div class="wrap-menu-desktop">
				<nav class="limiter-menu-desktop container">
					
					<!-- Logo desktop -->		
					<a href="${pageContext.request.contextPath}/Home" class="logo">
						<img src="./images/icons/logo-01.png" alt="IMG-LOGO">
					</a>

					<!-- Menu desktop -->
					<div class="menu-desktop">
						<ul class="main-menu">
							<li class="active-menu">
								<a href="${pageContext.request.contextPath}/Admin">Admin</a>
								<ul class="sub-menu">
									<c:if test="${loginMember.authCode == 1 || loginMember.authCode == 2}">
										<li><a href="${pageContext.request.contextPath}/GoodsList">상품관리</a></li>
										<li><a href="${pageContext.request.contextPath}/ReviewList">리뷰관리</a></li>
										<li><a href="${pageContext.request.contextPath}/QuesionList">문의관리</a></li>
										<li><a href="${pageContext.request.contextPath}/OrderList">주문관리</a></li>
										<li><a href="${pageContext.request.contextPath}/NoticeList">공지관리</a></li>
									</c:if>
									
									<c:if test="${loginMember.authCode == 3}">
										<li><a href="${pageContext.request.contextPath}/GoodsList">상품관리</a></li>
										<li><a href="${pageContext.request.contextPath}/ReviewList">리뷰관리</a></li>
										<li><a href="${pageContext.request.contextPath}/QuesionList">문의관리</a></li>
										<li><a href="${pageContext.request.contextPath}/OrderList">주문관리</a></li>
										<li><a href="${pageContext.request.contextPath}/NoticeList">공지관리</a></li>
										<li><a href="${pageContext.request.contextPath}/GoodsListForAdmin3">모든 상품관리</a></li>
										<li><a href="${pageContext.request.contextPath}/EmpList">사원관리</a></li>
									</c:if>
								</ul>
							</li>
							
							<li class="active-menu label1" data-label1="hot">
								<a href="${pageContext.request.contextPath}/Home">Shop</a>
								<ul class="sub-menu">
									<li><a href="${pageContext.request.contextPath}/Home">건강식품</a></li>
									<li><a href="${pageContext.request.contextPath}/Home">육류</a></li>
									<li><a href="${pageContext.request.contextPath}/Home">육가공류</a></li>
									<li><a href="${pageContext.request.contextPath}/Home">과일</a></li>
									<li><a href="${pageContext.request.contextPath}/Home">기름</a></li>
								</ul>
							</li>

							<li>
								<a href="${pageContext.request.contextPath}/OrderList">ORDER</a>
							</li>

							<li>
								<a href="${pageContext.request.contextPath}/NoticeList">NOTICE</a>
							</li>
							
						</ul>
					</div>	

					<!-- Icon header -->
					<div class="wrap-icon-header flex-w flex-r-m">

						<a href="${pageContext.request.contextPath}/CartList" class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 js-show-cart">
							<i class="zmdi zmdi-shopping-cart"></i>
						</a>
						
						<a href="${pageContext.request.contextPath}/MyPage" class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 js-show-modal-account">
							<i class="zmdi zmdi-account"></i>
						</a>
						
						<a href="${pageContext.request.contextPath}/Logout" class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 js-show-modal-logout">
							<i class="zmdi zmdi-arrow-right"></i>
						</a>
					
					</div>
				</nav>
			</div>	
		</div>
