<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="sign-up-container">
	<form:form name="memberEnrollFrm" id="sign-up-form">
		<div class="sign-up-title">
			<h2>회원가입</h2>
		</div>
		<div class="sign-up-box">
			<h3>아이디</h3>
			<p>영문, 숫자를 포함한 3~15자의 아이디를 입력해주세요.</p>
			<input type="text" name="memberId" id="memberId" class="sign-up-input"/>
			<p class="dupl-msg">존재하는 아이디입니다. 새로운 아이디를 입력해주세요.</p>
			<button class="dupl-btn">중복확인</button>
		</div>
		<div class="sign-up-box">
			<h3>비밀번호</h3>
			<p>영문, 숫자를 포함한 8자 이상의 비밀번호를 입력해주세요.</p>
			<input type="password" name="password" id="pwd" class="sign-up-input">
		</div>
		<div class="sign-up-box">
			<h3>비밀번호 확인</h3>
			<input type="password" id="pwdCheck" class="sign-up-input">
		</div>
		<div class="sign-up-box">
			<h3>닉네임</h3>
			<p>한글 2~8자의 닉네임을 입력해주세요.</p>
			<input type="text" name="nickname" id="nickname" class="sign-up-input">
		</div>
		<div class="sign-up-box">
			<h3>휴대폰번호</h3>
			<p>-를 제외한 휴대폰번호를 입력해주세요.</p>
			<input type="tel" name="phone" id="phone" class="sign-up-input">
		</div>
		<div class="sign-up-box"></div>
		<div class="sign-up-btn">
			<input type="submit" value="회원가입">
		</div>
	</form:form>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>