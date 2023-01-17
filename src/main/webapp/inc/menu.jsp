<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		<!-- Header desktop -->
		<div class="container">
			<div class="wrap-menu-desktop">
				<nav class="limiter-menu-desktop container">
					
					<!-- Logo desktop -->		
					<a href="${pageContext.request.contextPath}/Home" class="logo">
						<img src="./images/icons/logo-01.png" alt="IMG-LOGO">
					</a>

					<!-- Menu desktop -->
					<div class="menu-desktop">
						<ul class="main-menu">
							<li class="active-menu label1" data-label1="hot">
								<a href="index.html">Shop</a>
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
						
						<a href="${pageContext.request.contextPath}/Signin" class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 js-show-modal-zmdi-account-add">
							<i class="zmdi zmdi-account-add"></i>
						</a>
						
						<a href="${pageContext.request.contextPath}/Login" class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 js-show-modal-sign-in">
							<i class="zmdi zmdi-sign-in"></i>
						</a>
					
					</div>
				</nav>
			</div>	
			
			<div>오늘의 접속자 : ${todaySiteCounter}</div>
			<div>총 접속자 : ${totalSiteCounter}</div>
	
		</div>