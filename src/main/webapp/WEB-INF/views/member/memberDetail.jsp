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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/memberdetail.css" />

</head>
<body>
<br />
<br />

	<form:form name="memberUpdateFrm" action="${pageContext.request.contextPath}/member/memberUpdate.do?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
	<table>
		<th>
			<div class="avatar-upload">
			       <div class="avatar-edit">
			           <input type='file' id="imageUpload" name="upFile" accept=".png, .jpg, .jpeg" />
			           <label for="imageUpload">
			           	<img src="${pageContext.request.contextPath}/resources/images/pick.png" alt="imageupload" id="imgupload" name="profileImg">
			           </label>
			       </div>
			       <div class="avatar-preview">
			       	<div id="imageP">
			           	<img src="${pageContext.request.contextPath}/resources/upload/profile/<sec:authentication property="principal.profileImg"/>"  alt="프로필" name="profileImg" class="imagePreview">
			           </div>
			       </div>
			   </div>
			
				<td>
					<input type="text" class="form-con" name="memberId" id="memberId" value='<sec:authentication property="principal.memberId"/>' readonly required/>
				</td>
		</th>
	</table>
	<br /><br />
	<sec:authentication property="principal" var="loginMember"/>
	<div id="update-container">
		<!-- form:form 태그는 유효 아이디값 하나가 hidden 으로 생성된다. -->
			<div class="detail">
				<label for="" id="update">닉네임</label>
				<input type="text" class="form-control" name="nickname" id="nickname" value='<sec:authentication property="principal.nickname"/>' required/>
			</div>
				<p id="comment">한글 2~8자의 닉네임을 입력해주세요.</p>
			<div class="detail">
				<label for="" id="update">비밀번호</label>
				<input type="text" class="form-control" name="password" id="password" required/>
			</div>
				<p id="comment">영문, 숫자를 포함한 8자 이상의 비밀번호를 입력해주세요.</p>
			<div class="detail">
				<label for="" id="update">휴대폰 번호</label>
				<input type="tel" class="form-control" name="phone" id="phone" maxlength="11" value='<sec:authentication property="principal.phone"/>' required/>
			</div>
				<p id="comment">-를 제외한 휴대폰번호를 입력해주세요.</p>
			<br />
			<div id="update-btn">
			<input type="submit" class="btn btn-outline-success" value="수정" >&nbsp;
			<input type="button" class="btn btn-outline-success" onclick="deleteMember()" value="탈퇴">
			</div>
	</div>
		</form:form>
<form:form name="memberDeleteFrm" action="${pageContext.request.contextPath}/member/memberDelete.do" method="POST"></form:form>

</body>
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
		
		// 닉네임 - 한글 2~8자 이상
		if(!/^[가-힣]{2,8}$/.test(nickname.value)){
			alert("한글 2~8자의 닉네임을 입력해주세요");
			nickname.select();
			return false;
		}
		
		// 비밀번호는 영문자, 숫자를 포함한 8자 이상
		if(!/^[A-Za-z0-9]{8,}$/.test(password.value)){
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
	
	/* 프로필 미리보기 */
	document.querySelector("#imageUpload").addEventListener('change', (e) => {
	    const img = e.target;
	    const div = document.querySelector("#imageP")
	    const preview = document.createElement("img");
	    preview.classList.add("imagePreview");
	    
	    if(img.files[0]){
	        // 파일 선택한 경우
	        const fr = new FileReader(); // html5 api
	        fr.readAsDataURL(img.files[0]); // 비동기처리 - 언제끝날지 몰라 백그라운드에서 작업함
	        fr.onload = (e) => {
	            // 읽기 작업 완료시 호출될 load이벤트핸들러
	        	  $('#imageP').empty();
	              preview.src = e.target.result; // result속성은 dataUrl임
	              div.append(preview);
	          };
	      }
	      
	  });
	
/* 	function readURL(input) {
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function(e) {
	            $('#imageP').empty();
	            preview.src = e.target.result; // result속성은 dataUrl임
	            div.append(preview);
	        };
	    }

	    
	});
	
	}
	$("#imageUpload").change(function() {
	    readURL(t);
	}); */
	 
	/*  document.profileUpdateFrm.addEventListener("submit", (e) => {
			e.preventDefault(); // 폼제출 방지
			
			// FormData객체 생성
			const frmData = new FormData(e.target);
			
			// 등록 POST 
			$.ajax({
				url : "${pageContext.request.contextPath}/member/updateProfile.do",
				method : "POST",
				data : frmData,
				dataType : "json",
				contentType : false,
				processData : false,
				success(data){
					console.log(data);
					alert(data.result);
				},
				error : console.log,
				complete(){
					e.target.reset();
				}
			});
		}); */
	</script>
	
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>