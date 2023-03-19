<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<!-- bootstrap js -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<!-- bootstrap css -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="중고거래대화방" name="title"/>
</jsp:include>

<style>
/* 부트스트랩 기본 border 제거  */
.table tbody th, td{
	border: none;
}  
/* 대화방 기본 테이블  */
.chat-tbl {
	border-collapse: collapse;
	min-height: 80%;
	border: 1px solid #F2F3F6;
	margin : 0 auto;
	margin-top : 10px;
}

.chat-tbl th#nickname {
	padding-top: 23px;
}

.chat-tbl th#prof {
	border-right: 1px solid #F2F3F6;
	background-color: #F2F3F6;
}

.prof-wrapper {
	width: 50px;
}

td.chatList-container {
	padding: 0;
}
.chatList:first-child {
	border-top: none;
	border-left: none;
	border-right: none;
    border-radius: 0;
}
.chatList:last-child {
	border-top: none;
	border-left: none;
	border-right: none;
    border-radius: 0;
}
.chatlist {
	border-top: none;
	border-left: none;
	border-right: none;
    border-radius: 0;
}

.attach-wrapper {
	float: right;
	width: 50px;
	height: 50px;
	background-color: #F2F3F6;
}
.chat-tbl th#chat{
	border-left: 1px solid #F2F3F6;
}
</style>

<div id="Chat-wrapper" class=container>
	<table id="craigChat" class="table chat-tbl">
		<tbody>
			<tr>
				<th rowspan="2" id="prof" style="width: 7%;">
					<img src="${pageContext.request.contextPath}/resources/images/oee.png" alt="임시이미지" style="width: 100%;">
				</th>
				<th id="nickname" style="height: 70px; width: 35%;">닉네임</th>
				<th id="chat" rowspan="2">
					<div id="msg-container">
						<ul class="list-group list-group-flush">
						</ul>
					</div>
				</th>
			</tr>
			<tr>
				<td class="chatList-container">
					<div class="chatList-container">
						<ul class="list-group">
							<li class="list-group-item chatList">
								<div class="prof-wrapper" style="float: left;">
									<img src="${pageContext.request.contextPath}/resources/images/oee.png" alt="임시이미지" style="width: 100%;">
								</div>
								<div class="nickname-wrapper">
										<span>당근당근</span>
										<span>역삼동</span>
										<span>3일전</span>
								</div>
								<span>ㅎㅎ감사합니당~~ 어쩌구저쩌구..</span>
								<div class="attach-wrapper">
									
								</div>

							</li>
						</ul>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>