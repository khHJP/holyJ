<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
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
			location.href = "${pageContext.request.contextPath}/member/myProfile.do";
		});
});
</script>
</head>
<body>

	<!-- Modal시작 -->
	<!-- https://getbootstrap.com/docs/4.1/components/modal/#live-demo -->
	<div class="modal fade" id="loginModal" tabindex="-1" role="dialog"
		aria-labelledby="loginModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="loginModalLabel">비밀번호 확인</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<!--비밀번호폼 -->
				<!-- https://getbootstrap.com/docs/4.1/components/forms/#overview -->
				<form:form
					action="${pageContext.request.contextPath}/member/pwCheck.do"
					method="post">
					<div class="modal-body">
						<input
							type="password" class="form-control" name="password"
							placeholder="비밀번호" required>
					</div>
					<div class="modal-footer">
						<div>
							<button type="submit" class="btn btn-outline-success">확인</button>
							<button type="button" class="btn btn-outline-success" data-dismiss="modal">취소</button>
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</div>
	<!-- Modal 끝-->
</body>
</html>
<script>
    var msg = '${msg}';
    if(msg === '비밀번호를 다시 확인해 주세요.') {
        alert("비밀번호를 다시 확인해 주세요.");
    }
</script>
