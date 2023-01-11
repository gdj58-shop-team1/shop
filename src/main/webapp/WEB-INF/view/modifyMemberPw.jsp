<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
  
<script>
	$(document).ready(function() { // 이벤트 : <body>~</body>태그가 로드되고 나면 
		
		// customer 유효성 검사
		$('#customerBtn').click(function() {
				
			$('#newCustomerPw').focus();
			// newCustomerPw 미입력시
			if($('#newCustomerPw').val().length < 1) {
				
				alert('비밀번호를 입력해주세요');
				
				$('#newCustomerPw').focus();
				
				return false;
			}
			// newCustomerPw2 미입력시
			if($('#newCustomerPw2').val().length < 1) {
				
				alert('비밀번호를 입력해주세요');
				
				$('#newCustomerPw2').focus();
				
				return false;
			}
			
			$('#customerModifyPwForm').submit();

		
		});
	
	});
</script>

<!-- 
<script>
	$(document).ready(function() { // 이벤트 : <body>~</body>태그가 로드되고 나면 
		
		$('.customerPw').focusout(function () {
		    var newCustomerPw = $("#newCustomerPw").val();
		    var newCustomerPw2 = $("#newCustomerPw2").val();
		
		    if ( newCustomerPw != '' && newCustomerPw2 == '' ) {
		        null;
		        
		    } else if (newCustomerPw != "" || newCustomerPw2 != "") {
		        if (newCustomerPw == newCustomerPw2) {
		            $("#alert-success").css('display', 'inline-block');
		            $("#alert-danger").css('display', 'none');
		        } else {
		            alert("비밀번호가 일치하지 않습니다. 비밀번호를 재확인해주세요.");
		            $("#alert-success").css('display', 'none');
		            $("#alert-danger").css('display', 'inline-block');
		        
		            return;
		        }
		        $('#customerModifyPwForm').submit(); 
		        
		    }
		});
	
	
	
	});
</script>
-->
</head>
<body>

	<!-- 세션 정보별로 메뉴 분기 -->
	<c:if test="${loginMember == null}"> <!-- 비로그인 -->
		<jsp:include page="/inc/menu.jsp"></jsp:include>	
	</c:if>
	
	
	<c:if test="${loginMember.level == 0}"> <!-- 로그인(회원) -->
		<jsp:include page="/inc/menuForCustomer.jsp"></jsp:include>	
		
			<h1>고객 비밀번호 변경</h1>
			<form action="${pageContext.request.contextPath}/ModifyMemberPw" method="post" id = "customerModifyPwForm">
				<table>
					<tr>
						<th>ID</th>
						<td><input type="text" id="customerId" name="customerId" readonly="readonly" value="${loginMember.customerId}"></td>
					</tr>
					
					<tr>
						<th>PASSWORD</th>
						<td><input type="password" id="newCustomerPw" name="newCustomerPw" class="customerPw" placeholder ="비밀번호"></td>
					</tr>
					
					<tr>
						<th>PASSWORD 확인</th>
						<td><input type="password" id="newCustomerPw2" name="newCustomerPw2" class="customerPw" placeholder ="비밀번호 확인"></td>
					</tr>
					<span id = "alert-success" style="display:none;"> 비밀번호가 일치합니다.</span>
					<span id = "alert-danger" style="display:none; color:#d92742;"> 비밀번호가 일치하지않습니다.</span>
				</table>
				
				<button type="submit" id="customerBtn">비밀번호 변경</button>
			</form>
	
	</c:if>
	
	
	<c:if test="${loginMember.level == 1}"> <!-- 로그인(사원) -->
		<jsp:include page="/inc/menuForEmp.jsp"></jsp:include>	
		
		<h1>사원 정보 변경</h1>
		<form action="${pageContext.request.contextPath}/ModifyMemberPw" method="post" id = "empModifyPwForm">
			<table>
				<tr>
					<th>ID</th>
					<td><input type="text" id="empId" name="empId" readonly="readonly" value="${loginMember.empId}"></td>
				</tr>
				
				<tr>
					<th>PASSWORD</th>
					<td><input type="password" id="newEmpPw" name="newEmpPw" class="empPw" placeholder ="비밀번호"></td>
				</tr>
				<tr>
					<th>PASSWORD</th>
					<td><input type="password" id="newEmpPw2" name="newEmpPw2" class="empPw" placeholder ="비밀번호 확인"></td>
				</tr>
			</table>
			
			<button type="submit" id="empBtn">비밀번호 변경</button>
		</form>
	</c:if>
	

		
	
	
	

</body>
</html>