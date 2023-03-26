<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="같이해요" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/together/togetherEnroll.css" />
<script>
window.addEventListener('load', (e) => {
 	const today = new Date();
    const nextMonth = today.getMonth() + 2; // 다음 달
    const daysLater = 28; // 31일 후

    // 이번 달의 마지막 날짜 객체 생성
    const lastDay = new Date(today.getFullYear(), today.getMonth() + 1, 0); 
    // 현재 시간을 기반으로 새로운 Date 객체 생성
    const futureDate = new Date(today.getTime());
    // 오늘 날짜에 daysLater를 더하여 설정
    futureDate.setDate(today.getDate() + daysLater); 

    const days = [];
    const months = [];

    months.push(today.getMonth() + 1);
    for(let i = today.getDate(); i <= lastDay.getDate(); i++){
        days.push(i);
    }
    
    // 다음 달의 마지막 날짜 객체 생성
    const nextMonthLastDay = new Date(today.getFullYear(), today.getMonth() + 2, 0); 
    
    if(futureDate.getMonth() == nextMonth){
        months.push(nextMonth);
        for(let i = 1; i < nextMonthLastDay.getDate(); i++){
            days.push(i);
        }
    }
    else {
        months.push(futureDate.getMonth() + 1);
        for(let i = 1; i < futureDate.getDate(); i++){
            days.push(i);
        }
    }

    const month = document.querySelector(".month");
    const date = document.querySelector(".date");

    // 월별 option에 담기
    for(let i = 0; i < months.length; i++){
        const option = document.createElement("option");
        option.value = months[i];
        option.innerText = months[i];
        month.append(option);
    }

    // 일별 option에 담기
    for(let i = 0; i < days.length; i++){
        const option = document.createElement("option");
        option.value = days[i];
        option.innerText = days[i];
        date.append(option);
    }

});
</script>
<div class="enroll-container">
	<div class="enroll-wrap">
		<form:form name="togetherEnrollFrm">
			<div class="page-title">
				<h2>무엇을 같이할까요?</h2>
			</div>
			<div class="content-box">
				<div class="sub-box">
					<i class="bi bi-blockquote-left"></i>
					<label class="to-title">제목</label>
				</div>
				<input type="text" name="title" class="to-input" id="title" placeholder="제목을 입력해주세요">
			</div>
			<div class="content-box">
				<div class="sub-box">
					<i class="bi bi-signpost"></i>
					<h6 class="to-title">카테고리 선택</h6>
				</div>
				<div class="data-box">
					<c:forEach items="${categorys}" var="category" varStatus="vs">
						<input class="category" type="radio" name="category" id="category${vs.count}" value="${category.CATEGORY_NO}">
						<label class="category-label" for="category${vs.count}">
							${category.CATEGORY_NAME}
						</label>
					</c:forEach>
				</div>
			</div>
			<div>
				<div>
					<div class="content-box">
						<i class="bi bi-diagram-2"></i>
						<label for="joinCnt" class="to-title">인원</label>
						<i class="bi bi-dash-circle minus"></i>
						<input type="number" class="join-cnt" value="3" name="joinCnt" readonly/>
						<i class="bi bi-plus-circle plus"></i>
					</div>
					<div class="content-box">
						<div class="sub-box">
							<i class="bi bi-people-fill"></i>
							<label for="age_100" class="to-title">나이</label>
						</div>
						<div class="data-box">
							<input type="radio" name="age" id="age_100" checked>
							<label for="age_100">누구나</label>
							<input type="radio" name="age" id="age_20">
							<label for="age_20">20대</label>
							<input type="radio" name="age" id="age_30">
							<label for="age_30">30대</label>
							<input type="radio" name="age" id="age_40">
							<label for="age_40">40대</label>
							<input type="radio" name="age" id="age_50">
							<label for="age_50">50대</label>
						</div>
					</div>
					<div class="content-box">
						<div class="sub-box">
							<i class="bi bi-gender-ambiguous"></i>
							<label for="gender_A" class="to-title">성별</label>
						</div>
						<div class="data-box">
							<input type="radio" class="gender" name="gender" id="gender_A" value="A" checked>
							<label for="gender_A">누구나</label>
							<input type="radio" class="gender" name="gender" id="gender_F" value="F">
							<label for="gender_F">여자만</label>
							<input type="radio" class="gender" name="gender" id="gender_M" value="M">
							<label for="gender_M">남자만</label>
						</div>
					</div>
				</div>
				<div>
					<div class="content-box date-container">
						<div class="date-box">
							<i class="bi bi-calendar4-week"></i>
							<label class="to-title">날짜</label>
							<div class="data-box">
								<select id="date-select" class="month select" name="month" required></select>
								<select id="date-select" class="date select" name="date" required></select>
							</div>
						</div>
						<div class="time-box">
							<div class="sub-box">
								<i class="bi bi-clock"></i>
								<label class="to-title">시간</label>	
							</div>
							<div class="time-wrap">					
								<div class="time-radio data-box">
									<input type="radio" name="meridiem" value="am" id="am" checked/>
									<label for="am">오전</label>
									<input type="radio" name="meridiem" value="pm" id="pm"/>
									<label for="pm">오후</label>
								</div>
								<div class="time-select data-box">
									<select id="date-select" class="hour select" name="hour" required>
										<c:forEach begin="1" end="12" var="hour">
											<option value="${hour}" ${hour eq 7 ? 'selected' : ''}>${hour}</option>
										</c:forEach>
									</select>
									<select id="date-select" class="minute select" name="minute" required>
										<option value="00">00</option>
										<c:forEach begin="10" end="50" var="minute">
											<c:if test="${minute % 10 == 0}">
												<option value="${minute}">${minute}</option>
											</c:if>
										</c:forEach>
									</select>
								</div>
							</div><!-- end time-wrap -->
						</div><!-- end time-box -->
					</div><!-- end date-container -->
				</div>
				<div class="content-box">
					<i class="bi bi-geo-alt"></i>
					<label class="to-title">장소</label>
					<input type="text" name="place" class="to-input place">
				</div>
			</div>
			<div class="content-box">
				<i class="bi bi-pencil-square"></i>
				<label class="to-title">모임 내용</label>
				<textarea rows="10" cols="65" class="content" style="resize: none;"></textarea>
			</div>
			<sec:authentication property="principal" var="loginMember"/>
			<input type="hidden" name="writer" value="${loginMember.memberId}">
			<div class="btn-box">
				<input type="submit" value="등록하기" class="to-submit">
			</div>
		</form:form>
	</div>
</div>
<script>
/* 참가인원 제어 */
const joinCnt = document.querySelector(".join-cnt");
let cnt = Number(joinCnt.value);
document.querySelector(".minus").addEventListener("click", (e) => {
	if (cnt > 3) {
	    cnt--;
	    joinCnt.value = cnt;
  	} else {
    	alert("참가인원은 3명부터 가능합니다.");
  	}
});
document.querySelector(".plus").addEventListener("click", (e) => {
	console.log("더하기");
	if (cnt < 6) {
		cnt++;
  		joinCnt.value = cnt;
	} else {
  		alert("참가인원은 6명까지 가능합니다.");
	}
});

/* 유효성검사 */
document.togetherEnrollFrm.addEventListener('submit', (e) => {
	e.preventDefault();
	
	const title = document.querySelector("#title");
	const categorys = document.querySelectorAll(".category");
	const content = document.querySelector(".content");
	const place = document.querySelector(".place");

	
	/* 제목 */
	if(!/^.$/.test(title.value)){
		alert("제목을 작성해주세요!");
		title.select();
		return false;
	}
	
	/* 카테고리 선택  */
	let checked = 0;
	categorys.forEach((category) => {
		if(category.contains('checked')){
			checked = 1;
		} 
	});
	if(checked === 0){
		alert("카테고리를 선택해주세요");
		return false;
	}
	
	
	
});


</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>