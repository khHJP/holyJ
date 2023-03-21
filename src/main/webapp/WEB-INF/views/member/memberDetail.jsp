<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="마이페이지" name="subtitle"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/memberdetail.css" />

</head>
<body>
<br />
<br />
	<table>
		<th>
			<div class="avatar-upload">
			       <div class="avatar-edit">
			           <input type='file' id="imageUpload" accept=".png, .jpg, .jpeg" />
			           <label for="imageUpload">
			           	<img src="${pageContext.request.contextPath}/resources/images/pick.png" alt="imageupload" id="imgupload">
			           </label>
			       </div>
			       <div class="avatar-preview">
			       	<div>
			           	<img src="${pageContext.request.contextPath}/resources/images/oee.png" alt="임시이미지" id="imagePreview">
			           </div>
			       </div>
			   </div>
			
				<td>
					<input type="text" class="form-con" name="memberId" id="memberId" value="${loginMember.memberId}" readonly required/>
				</td>
		</th>
	</table>
	<br /><br />
	<%-- <sec:authentication property="principal" var="loginMember"/> --%>
	<div id="update-container">
		<form:form name="memberUpdateFrm" action="${pageContext.request.contextPath}/member/memberUpdate.do" method="post">
			<div class="detail">
				<label for="" id="update">닉네임</label>
				<input type="text" class="form-control" name="nickname" id="nickname" <%-- value='<sec:authentication property="principal.name"/>' --%> required/>
			</div>
				<p id="comment">한글 2~8자의 닉네임을 입력해주세요.</p>
			<div class="detail">
				<label for="" id="update">비밀번호</label>
				<input type="text" class="form-control" name="password" id="password" <%-- value='<sec:authentication property="principal.password"/>' --%> required/>
			</div>
				<p id="comment">영문, 숫자를 포함한 8자 이상의 비밀번호를 입력해주세요.</p>
			<div class="detail">
				<label for="" id="update">휴대폰 번호</label>
				<input type="tel" class="form-control" name="phone" id="phone" maxlength="11" value="${loginMember.phone}" required/>
			</div>
				<p id="comment">-를 제외한 휴대폰번호를 입력해주세요.</p>
			<div class="detail">
				<label for="" id="update">지역</label>
				<input type="text" class="form-control" name="dongno" id="dongno" <%-- value='<sec:authentication property="principal.password"/>' --%> required/>
			</div>
				<p id="comment"></p>
			<br />
			<div id="update-btn">
			<input type="submit" class="btn btn-outline-success" value="수정" >&nbsp;
			<input type="button" class="btn btn-outline-success" onclick="deleteMember()" value="탈퇴">
			</div>
		</form:form>
	</div>
<form:form name="memberDeleteFrm" action="${pageContext.request.contextPath}/member/memberDelete.do" method="POST"></form:form>
<script>
	const deleteMember = () => {
		if(confirm('정말 회원탈퇴하시겠습니까?')){
			document.memberDeleteFrm.submit();
		}
	};
	document.memberUpdateFrm.onsubmit = (e) => {
		const nickname = document.querySelector("#nickname");
		const password = document.querySelector("#password");
		const phone = document.querySelector("#phone");
		const dongNo = document.querySelector("#dongNO");
		
		// 닉네임 - 한글 2~8자 이상
		if(!/^[가-힣]{2,8}$/.test(nickname.value)){
			alert("한글 2~8자의 닉네임을 입력해주세요");
			nickname.select();
			return false;
		}
		
		// 비밀번호는 영문자, 숫자를 포함한 8자 이상
		if(!/^[a-zA-Z][0-9]{8,}$/.test(password.value)){
			alert("비밀번호는 영문자, 숫자를 포함한 8자 이상을 입력해주세요");
			password.select();
			return false;
		}
		
		// 전화번호는 숫자 01012345678 형식
		if(!/^010[0-9]{8}$/.test(phone.value)){
			alert("-를 제외한 휴대폰 번호를 입력해주세요.");
			phone.select();
			return false;
		}
	};
	
	//-------------------------------------------------------------------------------------------------
	function readURL(input) {
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function(e) {
	            $('#imagePreview').css('background-image', 'url('+e.target.result +')');
	            $('#imagePreview').hide();
	            $('#imagePreview').fadeIn(650);
	        }
	        reader.readAsDataURL(input.files[0]);
	    }
	}
	$("#imageUpload").change(function() {
	    readURL(this);
	});
	
	</script>
	
</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>