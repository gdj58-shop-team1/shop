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




		<!-- ?????? ???????????? ?????? ?????? -->
		<c:if test="${loginMember == null}"> <!-- ???????????? -->
			<jsp:include page="/inc/menu.jsp"></jsp:include>	
		</c:if>
		<c:if test="${loginMember.level == 0}"> <!-- ?????????(??????) -->
			<jsp:include page="/inc/menuForCustomer.jsp"></jsp:include>	
		</c:if>
		<c:if test="${loginMember.level == 1}"> <!-- ?????????(??????) -->
			<jsp:include page="/inc/menuForEmp.jsp"></jsp:include>	
		</c:if>
		
		
		<!-- ???????????? -->
		<section class="bg-img1 txt-center p-lr-15 p-tb-92" style="background-image: url('images/bg-06.jpg');" >
			<h2 class="ltext-105 cl0 txt-center">
				<!-- text -->
			</h2>
		</section>
		
		<!-- ??????????????? -->
		
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
										????????????
									</a>
								</li>
		
								<li class="bor18">
									<a href="${pageContext.request.contextPath}/ReviewList" class="dis-block stext-115 cl6 hov-cl1 trans-04 p-tb-8 p-lr-4" style="font-size:20pt">
										????????????
									</a>
								</li>
		
								<li class="bor18">
									<a href="${pageContext.request.contextPath}/QuestionList" class="dis-block stext-115 cl6 hov-cl1 trans-04 p-tb-8 p-lr-4" style="font-size:20pt">
										????????????
									</a>
								</li>
		
								<li class="bor18">
									<a href="${pageContext.request.contextPath}/ConfirmMember" class="dis-block stext-115 cl6 hov-cl1 trans-04 p-tb-8 p-lr-4" style="font-size:20pt">
										????????????
									</a>
								</li>
		
								<li class="bor18">
									<a href="${pageContext.request.contextPath}/AddressList" class="dis-block stext-115 cl6 hov-cl1 trans-04 p-tb-8 p-lr-4" style="font-size:20pt">
										???????????????
									</a>
								</li>
								
								<li class="bor18">
									<a href="${pageContext.request.contextPath}/RemoveMember" class="dis-block stext-115 cl6 hov-cl1 trans-04 p-tb-8 p-lr-4" style="font-size:20pt"	>
										????????????
									</a>
								</li>
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
							<th class="column-1">?????????</th>
							<td class="column-4">
								<div class="bor13 of-hidden pos-relative col-lg-6" >
								<input class="stext-103 cl2 plh3 size-105 p-l-10 p-r-25 "  
									type="text" name="goodsName" id = "goodsName" placeholder="Goods name">
								</div>
							</td>
						</tr>
						<tr class="table_head">
							<th class="column-1">????????????</th>
							<td >
								<div class="bor13 of-hidden pos-relative col-lg-6" >
									<input class="stext-103 cl2 plh3 size-105 p-l-10 p-r-25 "
										type="text" name="goodsPrice" id = "goodsPrice"  placeholder="Goods price"onkeyup="inputNumberFormat(this)"/>
								</div>
							</td>
						</tr>
						<tr class="table_head">
							<th class="column-1">????????????</th>
							<td >
								<input 
								 type="radio" name="soldout" id = "soldout" value="Y">????????? <input type="radio" name="soldout" id = "soldout" value="N">sold out
							</td>
						</tr>
						<tr class="table_head">
							<th class="column-1">????????????</th>
							<td class="column-2">
								<select name = "goodsCategory" id = "goodsCategory">
									<option value=''>------??????------</option>
									<option value='??????'>??????</option>
									<option value='????????????'>????????????</option>
									<option value='??????'>??????</option>
									<option value='??????'>??????</option>
									<option value='????????????'>????????????</option>
									
								</select>
							</td>
						</tr>
						<tr class="table_head">
							<th class="column-1">????????????</th>
							<td class="column-2">
								<div>
									<div  id="image_preview" >
										<label for = "image">
			                        	 	<img  src="${pageContext.request.contextPath}/images/img-upload.png"  width="150px" height="150px"  >
			      
			                       			<input type="file" name="goodsImg" id="image" accept="image/jpeg, image/png"  width="150px" height="150px">		
				                     	</label>
			                     	</div>
							
								</div>
								
							
								
                            </td>
						</tr>
						<tr class="table_head">
							<th class="column-1">?????????</th>
							<td class="column-2"><input type="text" name="empId" id = "empId" value="${loginMember.empId}" readonly="readonly"></td>
						</tr>
					</table>
					<div class="col-sm-10 col-lg-7 col-xl-5 m-lr-auto m-b-50 p-t-27" style="float:right">
					<button 
						class="flex-c-m stext-101 cl0 size-116 bg3 bor14 hov-btn3 p-lr-15 trans-04 pointer"
						type="submit">????????????</button>
					</div>
				</form>
				
					
				
				 			
			</div>	
		</div>
		</div>

		<!-- footer -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>

		
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
				        
				        ext = $(this).val().split('.').pop().toLowerCase(); //?????????
				        
				        //????????? ????????? ???????????? ??????????????? ??????
				        if($.inArray(ext, ['png', 'jpg', 'jpeg']) == -1) {
				            resetFormElement($(this)); //??? ?????????
				            window.alert('????????? ????????? ????????????! ( png, jpg, jpeg ??? ????????? ??????)');
				        } else {
				            file = $('#image').prop("files")[0];
				            blobURL = window.URL.createObjectURL(file);
				            $('#image_preview img').attr('src', blobURL);
				            $('#image_preview').slideDown(); //???????????? ????????? ???????????? 
				            $(this).slideUp(); //?????? ?????? ??????
				        }
				    });	
				  	
				  $('#image_preview a').bind('click', function() {
				        resetFormElement($('#image')); //????????? ?????? ?????????
				        $('#image').slideDown(); //?????? ?????? ?????????
				        $(this).parent().slideUp(); //?????? ?????? ?????? ??????
				        return false; //?????? ????????? ??????
				    });
				  function resetFormElement(e) {
				        e.wrap('<form>').closest('form').get(0).reset(); 
				        //??????????????? ????????? ????????? ???(<form>) ?????? ????????? (wrap()) , 
				        //????????? ????????? ?????? ?????? ????????? ???( closest('form')) ?????? Dom????????? ???????????? ( get(0) ),
				        //DOM?????? ???????????? ????????? ????????? reset()??? ??????
				        e.unwrap(); //?????? <form> ????????? ??????
				    }
				  
				
	</script>
<!--===============================================================================================-->	
	
	<!--  
	<script>
		 function inputNumberFormat(obj) {
		     obj.value = comma(uncomma(obj.value));
		 }
	
		 function comma(str) {
		     str = String(str);
		     return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
		 }
	
		 function uncomma(str) {
		     str = String(str);
		     return str.replace(/[^\d]+/g, '');
		 }
	
	
	
	
	</script>
	-->
</body>
</html>