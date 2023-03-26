<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 체크</title>
<!-- 사용자작성 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css" />
<script>
window.addEventListener('load', () => {
	$(loginModal)
		.modal()
		.on('hide.bs.modal', (e) => {
			// x버튼, 취소버튼, 모달외 영역을 클릭한 경우
			location.href = "${pageContext.request.contextPath}/";
		});
});
</script>
</head>
<body>

	<!-- Modal시작 -->
	<!-- https://getbootstrap.com/docs/4.1/components/modal/#live-demo -->
	<div class="modal fade" id="pw-check Modal" tabindex="-1" role="dialog"
		aria-labelledby="loginModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="pw-check Label">패스워드 확인</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<!-- 패스워드체크 폼 -->
				<!-- https://getbootstrap.com/docs/4.1/components/forms/#overview -->
				<form:form
					action="${pageContext.request.contextPath}/member/pwCheck.do"
					method="post">
					<div class="modal-body">
						<c:if test="${param.error != null}">
							<div class="alert alert-danger alert-dismissible fade show" role="alert">
							  <span class="text-danger">비밀번호가 일치하지 않습니다.</span>
							  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							  </button>
							</div>
						</c:if>
						<input 
							type="text" class="form-control" name="password"
							placeholder="비밀번호" required> 
						<br />
					</div>
						<div>
							<button type="submit" class="btn btn-outline-success">확인</button>
							<button type="button" class="btn btn-outline-success" data-dismiss="modal">취소</button>
						</div>
				</form:form>
				</div>
			</div>
		</div>
	<!-- Modal 끝-->
</body>
</html>
