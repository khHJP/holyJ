<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css">
<!-- 글꼴 Noto Sans Korean-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원관리" name="title"/>
</jsp:include>

  <section id="admin-container">
    <div class="row">
      <nav class="sidebar">
        <div class="sidebarMenu">
          <ul class="nav-column">
            <li class="nav-item">
              <img src="${pageContext.request.contextPath}/resources/images/oee.png" style="height:150px;">
            </li>
            <li class="nav-item">
              <a class="nav-link" href="">
                <span></span>
                회원 목록
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/admin/adminReportList.jsp">
                <span></span>
                신고 목록
              </a>
            </li>
          </ul>
        </div>
      </nav>
    </div>
    <div class="content">
	    <header class="navbar-top">
	      <input class="search" type="text" placeholder="Search...">
	    </header>
	    <div class="table-member">
	      <h2>회원 목록 조회</h2>
	      <hr>
	      <table>
	        <thead>
	          <tr>
	          	<th><input type="checkbox" value=" "></th>
	            <th>No</th>
	            <th>ID</th>
	            <th>Nickname</th>
	            <th>Phone</th>
	            <th>Manner</th>
	            <th>Dong_No</th>
	            <th>Dong_Range<th>
	            <th>Report</th>
	            <th>EnrollDate</th>
	            <th>DeleteDate</th>
	          </tr>
	        </thead>
	        <tbody>
	        <c:if test="${not empty adminMemberList}">
	        	<c:forEach items="${adminMemberList}" var="adminMember" varStatus="vs">
		        	<tr>
		        		<td><input type="checkbox" value="${adminMember.memberId}"></td>
			        	<td>${vs.count}</td>
			            <td>${adminMember.memberId}</td>
			            <td>${adminMember.nickname}</td>
			            <td>${adminMember.phone}</td>
			            <td>${adminMember.manner}</td>
			            <td>${adminMember.dongNo}</td>
			            <td>${adminMember.dongRange}</td>
			            <td>${adminMember.reportCnt}</td>
			            <td>${adminMember.enrollDate}</td>
						<td>${adminMember.deleteDate}</td>
		            </tr>
	            </c:forEach>
	        </c:if>
	        <c:if test="${empty adminMemberList}">
	        	<tr>
	        		<td colspan="11">조회된 데이터가 없습니다.</td>
	        	</tr>
	        </c:if>
	        </tbody>
	      </table>
	    </div>
    </div>
  </section>
  <script></script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>