<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/common.css" />
<script>
window.addEventListener('load', () => {
	$(loginModal)
		.modal()
		.on('hide.bs.modal', (e) => {
			// x버튼, 취소버튼, 모달외 영역을 클릭한 경우
			location.href = "${pageContext.request.contextPath}/"
		});
});
</script>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<!-- Modal시작 -->
	<div class="modal fade" id="loginModal" tabindex="-1" role="dialog"
		aria-labelledby="loginModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="login-header">
					<div class="img-box">
						<img src="${pageContext.request.contextPath}/resources/images/OEE-LOGO2.png">
					</div>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<!--로그인폼 -->
				<form:form
					action="${pageContext.request.contextPath}/member/memberLogin.do"
					method="post">
					<div class="modal-body">
						<c:if test="${param.error != null}">
							<div class="alert alert-success alert-dismissible fade show" role="alert">
								<span class="text-success">아이디 또는 비밀번호가 일치하지 않습니다.</span>
								<button type="button" class="close" data-dismiss="alert" aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
				            </div>
						</c:if>
						<input 
							type="text" class="je-input" name="username"
							placeholder="아이디" required> 
						<br /> 
						<input
							type="password" class="je-input" name="password"
							placeholder="비밀번호" required>
						<div class="login-check">
							<input type="checkbox" class="form-check-input" name="remember-me" id="remember-me"/>
							<label for="remember-me" class="form-check-label">자동로그인</label>
						</div>
					</div>
					<div class="login-footer">
						<div>
							<button type="submit" class="btn">로그인</button>
							<button type="button" class="btn" data-dismiss="modal">취소</button>
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</div>
	<!-- Modal 끝-->
</body>
</html>