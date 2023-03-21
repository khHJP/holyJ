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
			<h3 class="input-title">아이디</h3>
			<p>영문, 숫자를 포함한 3~15자의 아이디를 입력해주세요.</p>
			<input type="text" name="memberId" id="memberId" class="sign-up-input"/>
			<button class="dupl-btn">중복확인</button>
			<span class="dupl-msg ok">사용 가능한 아이디입니다.</span>
			<span class="dupl-msg error">이미 사용중인 아이디입니다. 새로운 아이디를 입력해주세요.</span>
			<input type="hidden" id="idValid" value="0"/>
		</div>
		<div class="sign-up-box">
			<h3 class="input-title">비밀번호</h3>
			<p>영문, 숫자를 포함한 8자 이상의 비밀번호를 입력해주세요.</p>
			<input type="password" name="password" id="pwd" class="sign-up-input">
		</div>
		<div class="sign-up-box">
			<h3 class="input-title">비밀번호 확인</h3>
			<input type="password" id="pwdCheck" class="sign-up-input">
		</div>
		<div class="sign-up-box">
			<h3 class="input-title">닉네임</h3>
			<p>한글 2~8자의 닉네임을 입력해주세요.</p>
			<input type="text" name="nickname" id="nickname" class="sign-up-input">
		</div>
		<div class="sign-up-box">
			<h3 class="input-title">휴대폰번호</h3>
			<p>-를 제외한 휴대폰번호를 입력해주세요.</p>
			<input type="tel" name="phone" id="phone" class="sign-up-input">
		</div>
		<div class="sign-up-box">
			<h3 class="input-title">주소</h3>
			<p class="error-msg">모두 선택해주세요.</p>
			<select class="form-select" id="gu-select" name="gu" aria-label="Default select example">
				<option selected>구 선택</option>
					<c:forEach items="${guList}" var="gu">
	            		<option value="${gu.guNo}">${gu.guName}</option>
			  		</c:forEach> 
			</select>
			<select class="form-select" id="dong-select" name="dong" aria-label="Default select example">
				<option selected>동 선택</option>
				<c:forEach items="${dongList}" var="dong">
					<option value="${dong.dongNo}" class="dong-option ${dong.guNo}">${dong.dongName}</option>
				</c:forEach>
			</select>
			<select class="form-select" id="dong-range-select" name="dongRange" aria-label="Default select example">
				<option selected>범위 선택</option>
				<option value="N">근처동네 3개</option>
				<option value="F">근처동네 5개</option>
			</select>
		</div>
		<div class="sign-up-btn">
			<input type="submit" value="회원가입">
		</div>
	</form:form>
</div>
<script>
/* 선택한 구에 따른 동 변화 */
document.querySelector("#gu-select").addEventListener('change', (e) => {
	const dong = document.querySelector("#dong-select");
	dong.selectedIndex = 0; // 선택된 동 초기화
	
	const options = dong.getElementsByTagName("option");
	
	for (let i = 0; i < options.length; i++) {
		const option = options[i];
		// 해당 태그에 타겟과 일치하는 guNo의 존재유무에 따른 분기처리
		if (option.classList.contains(e.target.value))
			option.style.display = "unset"; 
		else
			option.style.display = "none";
	}
	
});

/* 아이디 중복검사 */
document.querySelector(".dupl-btn").addEventListener('click', (e) => {
	const memberId = document.querySelector("#memberId");
	const ok = document.querySelector(".ok");
	const error = document.querySelector(".error");
	const idValid = document.querySelector("#idValid");
	console.log(memberId.value);
	
	$.ajax({
		url : "${pageContext.request.contextPath}/member/checkIdDuplicate.do",
		data : {memberId : memberId.value},
		method : "GET",
		dataType : "json",
		success(data){
			console.log(data);
		},
		error : console.log
	});
});
 

/* 유효성 검사 */ 
document.memberEnrollFrm.addEventListener('submit', (e) => {
	e.preventDefault(); // 폼 제출 방지
	
});

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>