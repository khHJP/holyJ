<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${param.pageTitle}</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/chat/chatroom.css" />

<style>

</style>

<script>
$(document).ready(function(){
	$('#action_menu_btn').click(function(){
		$('.action_menu').toggle();
	});
		});
</script>

</head>
<body>
<div class="chat h-100">
	<div class="card">
		<div class="card-header msg_head align-top">
			<div class="d-flex bd-highlight">
				<div class="user_info">
					<span class="nickname">당근당근</span>
					<span class="manner badge bg-success">36.5</span>
				</div>
				<svg id="action_menu_btn" class="bi bi-three-dots-vertical" width="24" height="24" role="img" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 16 16">
					<path d="M9.5 13a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/>
				</svg>
			</div>
			<div class="action_menu">
				<ul>
					<li>신고하기 </li>
					<li>채팅방 나가기</li>

				</ul>
			</div>
		</div>
		<div class="messages">
			<ul class="list-unstyled">
				<li class="sent">
					<img src="http://emilcarlsson.se/assets/mikeross.png" alt="">
					<p>안녕하세요?</p>
					<span class="msg_time">8:40 오후</span>				
				</li>
				
				<li class="replies">
					<img src="http://emilcarlsson.se/assets/harveyspecter.png" alt="">
					<p>하이요</p>	
					<span class="msg_time">8:40 오후</span>
				</li>
				
				<li class="replies">
					<img src="http://emilcarlsson.se/assets/harveyspecter.png" alt="">
					<p>네고가능한가요?</p>
					<span class="msg_time">8:40 오후</span>
				</li>
				
				<li class="sent">
					<img src="http://emilcarlsson.se/assets/mikeross.png" alt="">
					<p>얼마나요?</p>
					<span class="msg_time">8:40 오후</span>				
				</li>
				<li class="sent">
					<img src="http://emilcarlsson.se/assets/mikeross.png" alt="">
					<p>만원이상은 조금... </p>
					<span class="msg_time">8:40 오후</span>				
				</li>
				
				<li class="replies">
					<img src="http://emilcarlsson.se/assets/harveyspecter.png" alt="">
					<p>최근 7년동안 자바 분야의 베스트 셀러 1위를 지켜온 '자바의 정석'의 최신판. 저자가 카페에서 12년간 직접 독자들에게 답변을 해오면서 초보자가 어려워하는 부분을 잘 파악하고 쓴 책. 뿐만 아니라 기존의 경력자들을 위해 자바의 최신기능(람다와 스트림)을 자세하면서도 깊이있게 설명하고 있다. 저자가 2002년부터 꾸준히 집필해온 책으로 깊이와 세밀함 그리고 저자의 정성과 노력이 돋보이는 책이다. 12년간 저자가 카페에서 손수 답변해줬다는 사실은 이 책에 대한 신뢰를 갖게 한다.</p>
					<span class="msg_time">8:40 오후</span>
				</li>
				
				<li class="sent">
					<img src="http://emilcarlsson.se/assets/mikeross.png" alt="">
					<p>이렇게 난 또 (fiction in fiction)
잊지 못하고 (fiction in fiction)
내 가슴 속에 끝나지 않을 이야길 쓰고 있어
널 붙잡을게 (fiction in fiction)
놓지 않을게 (fiction in fiction in fiction)
끝나지 않은 너와 나의 이야기 속에서
오늘도 in fiction</p>
					<span class="msg_time">8:40 오후</span>				
				</li>
				
			</ul>
		</div>
		<div class="card-footer align-bottom">
			<div class="input-group">
				<div class="input-group-append">
					<span class="input-group-text attach_btn"><i class="fas fa-paperclip"></i></span>
				</div>
				<textarea name="" class="form-control type_msg" placeholder="Type your message..."></textarea>
				<div class="input-group-append">
					<span class="input-group-text send_btn"><i class="fas fa-location-arrow"></i></span>
				</div>
			</div>
		</div>
</div>

</body>
</html>