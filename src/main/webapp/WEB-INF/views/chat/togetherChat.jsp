<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<style>
/* 부트스트랩 기본 border 제거  */
.table tbody th, td{
	border: none;
}  
/* 대화방 기본 테이블  */
.chat-tbl {
	border-collapse: collapse;
	min-height: 80%;
	border: 1px solid black;
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





</body>
</html>