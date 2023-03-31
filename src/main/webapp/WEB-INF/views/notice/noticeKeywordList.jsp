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
			<c:if test="${fn:length(noticeKeyword) < 3}">
			<form:form action="${pageContext.request.contextPath}/notice/insertKeyword.do?${_csrf.parameterName}=${_csrf.token}" method="post">
                        <input type="text" class="keyword" id="search" name="keyword" placeholder="키워드를 입력해주세요.(예:자전거)" required/>
                    <button id="search-btn" type="submit">
                        <img src="${pageContext.request.contextPath}/resources/images/search.png" alt="" id="searchimg"/>
                    </button>
            </form:form>
            </c:if>
			<c:if test="${fn:length(noticeKeyword) >= 3}">
				<div style="font-size:18px;">키워드는 3개까지 등록가능합니다.</div>
            </c:if>
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
					<c:if test="${noticeKeyword[0] != null}">
					 <div>
						 <tr name="no"  id="tr-table">
	 					 	<c:forEach items="${noticeKeyword}" var="keyword">
						 		<td style="width: 80px;">
						 		  <button  class="cancel-btn">
						 			<li data-no="${keyword.no}"> ${keyword.keyword}&nbsp;&nbsp;&nbsp;X
									<%-- <img src="${pageContext.request.contextPath}/resources/images/cancel.png" alt="" id="cancelimg"/> --%>
									</li>	
							 	 </button>
						 		</td>
							</c:forEach>
						</tr>
					 </div>													
					</c:if>
			</table>			
		</div>
</body>

<c:if test="${noticeKeyword[0] != null}">
	<script>
     document.querySelectorAll(".cancel-btn").forEach((buttons) =>{
    	 
    	 buttons.addEventListener('click', (b) => {
    		 if(confirm("정말 삭제하시겠습니까 ?") == true){
    		        /* alert("삭제되었습니다"); */
    		    }
    		    else{
    		        return ;
    		    }
    		  console.log(   b.target  );
    		  
    		  const no =  b.target.dataset.no;
    		  console.log(   no  );
    		  const csrfHeader = "${_csrf.headerName}";
              const csrfToken = "${_csrf.token}";
              const headers = {};
              headers[csrfHeader] = csrfToken;
         	$.ajax({
         		url : `${pageContext.request.contextPath}/notice/deleteKeyword.do`,
         		method : 'POST',
         		headers,
         		data :{ keywordNo : no},
         		success(data){
         			console.log(data); 
         			if(data=1){//data =1 -> 성공했다 delete 했다 그래서 리턴값이 1이다 
         				$(b.target).remove(); //태그 자체를 없애주세요 
         			}
         		},
         		error : console.log
         	});//ajax
    	 }); 
     });// 
    	 
    </script>
</c:if>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>