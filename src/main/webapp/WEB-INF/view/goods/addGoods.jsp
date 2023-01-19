<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/icons/favicon.png"/>
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/fonts/iconic/css/material-design-iconic-font.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/fonts/linearicons-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/animate/animate.css">
<!--===============================================================================================-->	
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/select2/select2.min.css">
<!--===============================================================================================-->	
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/slick/slick.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/MagnificPopup/magnific-popup.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/perfect-scrollbar/perfect-scrollbar.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/util.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/loginCss/assets/css/tailwind.output.css" />
<!--===============================================================================================-->




<meta charset="EUC-KR">
<title>Insert title here</title>
 <script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
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
		
		
		<!-- 상단배너 -->

		<section class="bg-img1 txt-center p-lr-15 p-tb-92" style="background-image: url('images/bg-04.jpg');">
			<h2 class="ltext-105 cl0 txt-center">
				<!-- text -->
			</h2>
		</section>	
		
		<!-- 페이지위치 -->
		
		<div class="container"  >
			<div class="bread-crumb flex-w p-l-25 p-r-15 p-t-30 p-lr-0-lg">
				<a href="${pageContext.request.contextPath}/Home" class="stext-109 cl8 hov-cl1 trans-04">
					Home
					<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
				</a>
	
				<a href="${pageContext.request.contextPath}/" class="stext-109 cl8 hov-cl1 trans-04">
					Admin
					<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
				</a>
				<a href="${pageContext.request.contextPath}/GoodsList" class="stext-109 cl8 hov-cl1 trans-04">
					Goods list
					<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
				</a>
	
				<span class="stext-109 cl4">
					Add goods
				</span>
			</div>
		</div>

		
		<div class="container"  >
		
			
			
			<div class="row">
			
				<!-- side menu -->
				
				
				<div class="col-md-3 col-lg-3 p-b-80">
					<div class="side-menu">
						<div class="p-t-55">
							<h4 class="mtext-112 cl2 p-b-9">
								Categories
							</h4>
		
							<ul>
								<li class="bor18">									
									<a href="${pageContext.request.contextPath}/OrderList" class="dis-block stext-115 cl6 hov-cl1 trans-04 p-tb-8 p-lr-4" style="font-size:20pt">
										주문목록
									</a>
								</li>
		
								<li class="bor18">
									<a href="${pageContext.request.contextPath}/ReviewList" class="dis-block stext-115 cl6 hov-cl1 trans-04 p-tb-8 p-lr-4" style="font-size:20pt">
										리뷰목록
									</a>
								</li>
		
								<li class="bor18">
									<a href="${pageContext.request.contextPath}/QuestionList" class="dis-block stext-115 cl6 hov-cl1 trans-04 p-tb-8 p-lr-4" style="font-size:20pt">
										문의사항
									</a>
								</li>
		
								<li class="bor18">
									<a href="${pageContext.request.contextPath}/ConfirmMember" class="dis-block stext-115 cl6 hov-cl1 trans-04 p-tb-8 p-lr-4" style="font-size:20pt">
										정보변경
									</a>
								</li>
		
								<li class="bor18">
									<a href="${pageContext.request.contextPath}/AddressList" class="dis-block stext-115 cl6 hov-cl1 trans-04 p-tb-8 p-lr-4" style="font-size:20pt">
										배송지변경
									</a>
								</li>
								
								<li class="bor18">
									<a href="${pageContext.request.contextPath}/RemoveMember" class="dis-block stext-115 cl6 hov-cl1 trans-04 p-tb-8 p-lr-4" style="font-size:20pt"	>
										회원탈퇴
									</a>
								</li>
							</ul>
						</div>
						
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
											<td>${sg.goodsPrice}원</td>
										</span>
									</div>
								</li>
								</c:forEach>
							</ul>
						</div>	
					</div>
				</div>
				
				<!-- class="col-lg-7 col-lg-3 m-lr-auto p-t-40" -->
				<!-- table -->
				<div class="sec-product-detail  col-lg-8 bg0 p-t-40 p-b-60">
				<form enctype="multipart/form-data" action="${pageContext.request.contextPath}/AddGoods" method="post">
					<table class="table-shopping-cart">
						
						<tr class="table_head">
							<th class="column-1">상품명</th>
						
							<td class="column-4"><input type="text" name="goodsName" id = "goodsName" placeholder="Goods name"></td>
						</tr>
						<tr class="table_head">
							<th class="column-1">판매가격</th>
							<td class="column-4"><input type="number" name="goodsPrice" id = "goodsPrice"></td>
						</tr>
						<tr class="table_head">
							<th class="column-1">솔드아웃</th>
							<td class="column-3">
								<input type="radio" name="soldout" id = "soldout" value="Y">판매중 <input type="radio" name="soldout" id = "soldout" value="N">★솔드아웃★
							</td>
						</tr>
						<tr class="table_head">
							<th class="column-1">카테고리</th>
							<td class="column-2">
								<select name = "goodsCategory" id = "goodsCategory">
									<option value=''>------선택------</option>
									<option value='육류'>육류</option>
									<option value='육가공류'>육가공류</option>
									<option value='과일'>과일</option>
									<option value='기름'>기름</option>
									<option value='건강식품'>건강식품</option>
									
								</select>
							</td>
						</tr>
						<tr class="table_head">
							<th class="column-1">사진등록</th>
							<td class="column-2">
								<div>
									<label for = "image">Image:
										<div  id="image_preview">
			                        	 	<img  src="${pageContext.request.contextPath}/images/img-upload.png" style = "width=150px; height=150px; object-fit:cover;" >
			                       
			                     		</div>
									
									</label>
									<input type="file" name="goodsImg" id="image" accept="image/jpeg, image/png">
								</div>
								
							
								
                            </td>
						</tr>
						<tr class="table_head">
							<th class="column-1">관리자</th>
							<td class="column-2"><input type="text" name="empId" id = "empId" value="${loginMember.empId}" readonly="readonly"></td>
						</tr>
					</table>
					<button type="submit">상품등록</button>
				</form>
				
					
				
				 			
			</div>	
		</div>
		</div>

		

		
<!--===============================================================================================-->	
	<script src="${pageContext.request.contextPath}/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/vendor/bootstrap/js/popper.js"></script>
	<script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/vendor/select2/select2.min.js"></script>
	<script>
		$(".js-select2").each(function(){
			$(this).select2({
				minimumResultsForSearch: 20,
				dropdownParent: $(this).next('.dropDownSelect2')
			});
		})
	</script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/vendor/daterangepicker/moment.min.js"></script>
	<script src="${pageContext.request.contextPath}/vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/vendor/slick/slick.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/slick-custom.js"></script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/vendor/parallax100/parallax100.js"></script>
	<script>
        $('.parallax100').parallax100();
	</script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/vendor/MagnificPopup/jquery.magnific-popup.min.js"></script>
	<script>
		$('.gallery-lb').each(function() { // the containers for all your galleries
			$(this).magnificPopup({
		        delegate: 'a', // the selector for gallery item
		        type: 'image',
		        gallery: {
		        	enabled:true
		        },
		        mainClass: 'mfp-fade'
		    });
		});
	</script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/vendor/isotope/isotope.pkgd.min.js"></script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/vendor/sweetalert/sweetalert.min.js"></script>
	<script>
		$('.js-addwish-b2').on('click', function(e){
			e.preventDefault();
		});

		$('.js-addwish-b2').each(function(){
			var nameProduct = $(this).parent().parent().find('.js-name-b2').html();
			$(this).on('click', function(){
				swal(nameProduct, "is added to wishlist !", "success");

				$(this).addClass('js-addedwish-b2');
				$(this).off('click');
			});
		});

		$('.js-addwish-detail').each(function(){
			var nameProduct = $(this).parent().parent().parent().find('.js-name-detail').html();

			$(this).on('click', function(){
				swal(nameProduct, "is added to wishlist !", "success");

				$(this).addClass('js-addedwish-detail');
				$(this).off('click');
			});
		});

		/*---------------------------------------------*/

		$('.js-addcart-detail').each(function(){
			var nameProduct = $(this).parent().parent().parent().parent().find('.js-name-detail').html();
			$(this).on('click', function(){
				swal(nameProduct, "is added to cart !", "success");
			});
		});
	
	</script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/vendor/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	<script>
		$('.js-pscroll').each(function(){
			$(this).css('position','relative');
			$(this).css('overflow','hidden');
			var ps = new PerfectScrollbar(this, {
				wheelSpeed: 1,
				scrollingThreshold: 1000,
				wheelPropagation: false,
			});

			$(window).on('resize', function(){
				ps.update();
			})
		});
	</script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/js/main.js"></script>
	
<!--===============================================================================================-->	
	<script type="text/javascript">
				 
				  $('#image').on('change', function() {
				        
				        ext = $(this).val().split('.').pop().toLowerCase(); //확장자
				        
				        //배열에 추출한 확장자가 존재하는지 체크
				        if($.inArray(ext, ['png', 'jpg', 'jpeg']) == -1) {
				            resetFormElement($(this)); //폼 초기화
				            window.alert('이미지 파일이 아닙니다! ( png, jpg, jpeg 만 업로드 가능)');
				        } else {
				            file = $('#image').prop("files")[0];
				            blobURL = window.URL.createObjectURL(file);
				            $('#image_preview img').attr('src', blobURL);
				            $('#image_preview').slideDown(); //업로드한 이미지 미리보기 
				            $(this).slideUp(); //파일 양식 감춤
				        }
				    });	
				  	
				  $('#image_preview a').bind('click', function() {
				        resetFormElement($('#image')); //전달한 양식 초기화
				        $('#image').slideDown(); //파일 양식 보여줌
				        $(this).parent().slideUp(); //미리 보기 영역 감춤
				        return false; //기본 이벤트 막음
				    });
				  function resetFormElement(e) {
				        e.wrap('<form>').closest('form').get(0).reset(); 
				        //리셋하려는 폼양식 요소를 폼(<form>) 으로 감싸고 (wrap()) , 
				        //요소를 감싸고 있는 가장 가까운 폼( closest('form')) 에서 Dom요소를 반환받고 ( get(0) ),
				        //DOM에서 제공하는 초기화 메서드 reset()을 호출
				        e.unwrap(); //감싼 <form> 태그를 제거
				    }
				  
				
	</script>
</body>
</html>