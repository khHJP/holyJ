<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="login-container">
	<div class="login-wrap">
		<div class="login-header">
			<div class="img-box">
				<img src="${pageContext.request.contextPath}/resources/images/OEE-LOGO2.png">
			</div>
		</div><!-- end login-header -->
		<form:form
			action="${pageContext.request.contextPath}/member/memberLogin.do"
			method="post">
			<div class="modal-body">
				<c:if test="${param.error != null}">
					<div class="alert alert-danger alert-dismissible fade show" role="alert">
						<span class="text-danger">아이디 또는 비밀번호가 일치하지 않습니다.</span>
						<button type="button" class="close" data-dismiss="alert" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
		            </div>
				</c:if>
				<input 
					type="text" class="je-input" name="memberId"
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
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>