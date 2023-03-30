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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/notice/noticekeyword.css" />


</head>
<body>
<br /><br />
	<div class="keycontainer">
		<h1 class="sub_title">알림 키워드 설정</h1>
		<br />
		<div class="search-container">
			<form:form action="${pageContext.request.contextPath}/notice/insertKeyword.do?${_csrf.parameterName}=${_csrf.token}" method="post">
                        <input type="text" class="keyword" id="search" name="keyword" placeholder="키워드를 입력해주세요.(예:자전거)" required/>
                    <button id="search-btn" type="submit">
                        <img src="${pageContext.request.contextPath}/resources/images/search.png" alt="" id="searchimg"/>
                    </button>
            </form:form>
			<%-- <form:form action="${pageContext.request.contextPath}/notice/insertKeyword.do" method="post">
						<input type="text" class="keyword" id="search" name="noticeKeyword" placeholder="키워드를 입력해주세요.(예:자전거)" required/>
					<button id="search-btn" type="submit">
						<img src="${pageContext.request.contextPath}/resources/images/search.png" alt="" id="searchimg"/>
					</button>
			</form:form> --%>
		</div>
		<br /><br />
		<span id="upkword">등록한 키워드</span>
		<br />
		<br />
			<table id="tbl-board" class="table">
					<c:forEach items="${noticeKeyword}" var="keyword">
						 <tr data-no="${keyword.no}" name="no" id="tr-table">
						 	<div class="showkword" id="noKeyword">${keyword.keyword}
								<button id="cancel-btn">
									<img src="${pageContext.request.contextPath}/resources/images/cancel.png" alt="" id="cancelimg"/>
								</button>
							</div>
						</tr>								
					</c:forEach>
			</table>			
		</div>
</body>
<script>
     document.querySelector("#cancel-btn").addEventListener('click', (e) => {
    	 const csrfHeader = "${_csrf.headerName}";
         const csrfToken = "${_csrf.token}";
         const headers = {};
         headers[csrfHeader] = csrfToken;
    	$.ajax({
    		url : `${pageContext.request.contextPath}/notice/deleteKeyword.do`,
    		method : 'POST',
    		headers,
    		data :{ no : '${keyword.no}'},
    		success(data){
    			console.log(data); 
    		},
    		error : console.log
    	})
    });
    </script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>