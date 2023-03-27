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
/* 현재 날짜와 28일 이후 날짜 사이 구하기 */
window.addEventListener('load', (e) => {
 	const today = new Date();
    const nextMonth = today.getMonth() + 2; // 다음 달
    const daysLater = 28; // 28일 후

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
		<div class="page-title">
			<h2>[수정] 무엇을 같이할까요?</h2>
		</div>
		<form:form name="togetherUpdateFrm">
			<div class="together-wrap">
				<div class="content-box">
					<div class="sub-box">
						<i class="bi bi-blockquote-left"></i>
						<label class="to-title">제목</label>
					</div>
					<input type="text" name="title" class="to-input" id="title" placeholder="제목을 입력해주세요" value="${together.title}">
					<p class="error-msg title-error">제목을 입력해주세요.(5글자 이상)</p>
				</div>
				<div class="content-box">
					<div class="sub-box">
						<i class="bi bi-signpost"></i>
						<h6 class="to-title">카테고리 선택</h6>
					</div>
					<div class="data-box">
						<c:forEach items="${categorys}" var="category" varStatus="vs">
							<input class="category" type="radio" name="categoryNo" id="category${vs.count}" 
								   value="${category.CATEGORY_NO}" ${together.categoryNo eq category.CATEGORY_NO ? 'checked' : ''}>
							<label class="category-label" for="category${vs.count}">
								${category.CATEGORY_NAME}
							</label>
						</c:forEach>
						<p class="error-msg category-error">카테고리를 선택해주세요.</p>
					</div>
				</div>
				<div>
					<div>
						<div class="content-box">
							<i class="bi bi-diagram-2"></i>
							<label for="joinCnt" class="to-title">인원</label>
							<i class="bi bi-dash-circle minus"></i>
							<input type="number" class="join-cnt" value="${together.joinCnt}" name="joinCnt" readonly/>
							<i class="bi bi-plus-circle plus"></i>
						</div>
						<div class="content-box">
							<div class="sub-box">
								<i class="bi bi-people-fill"></i>
								<label for="age_100" class="to-title">나이</label>
							</div>
							<div class="data-box">
								<input type="radio" name="age" id="age_100" 
									   value="100" ${together.age eq age ? 'checked' : ''}>
								<label for="age_100">누구나</label>
								<c:forEach begin="20" end="50" var="age">
									<c:if test="${age % 10 == 0}">
										<input type="radio" name="age" id="age_${age}" 
											   value="${age}" ${together.age eq age ? 'checked' : ''}>								
										<label for="age_${age}">${age}대</label>
									</c:if>
								</c:forEach>
							</div>
						</div>
						<div class="content-box">
							<div class="sub-box">
								<i class="bi bi-gender-ambiguous"></i>
								<label for="gender_A" class="to-title">성별</label>
							</div>
							<div class="data-box">
								<input type="radio" class="gender" name="gender" id="gender_A" 
									   value="A" ${together.gender eq 'A' ? 'checked' : ''}>
								<label for="gender_A">누구나</label>
								<input type="radio" class="gender" name="gender" id="gender_F" 
									   value="F" ${together.gender eq 'F' ? 'checked' : ''}>
								<label for="gender_F">여자만</label>
								<input type="radio" class="gender" name="gender" id="gender_M" 
									   value="M" ${together.gender eq 'M' ? 'checked' : ''}>
								<label for="gender_M">남자만</label>
							</div>
						</div>
					</div>
					<div>
						<div class="content-box date-container">
							<div class="date-box">
								<div class="sub-box">
									<i class="bi bi-calendar4-week"></i>
									<label class="to-title">날짜</label>
								</div>
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
						<input type="text" name="place" class="to-input place" style="display: block;" placeholder="장소를 직접 입력해주세요!" value="${together.place}">
						<p class="error-msg place-error">장소를 입력해주세요.(5글자 이상)</p>
					</div>
				</div>
				<div class="content-box">
					<i class="bi bi-pencil-square"></i>
					<label class="to-title">모임 내용</label>
					<textarea rows="10" cols="65" class="content" name="content" style="resize: none;">${together.content}</textarea>
				</div>
			</div>
			<sec:authentication property="principal" var="loginMember"/>
			<input type="hidden" name="writer" value="${loginMember.memberId}">
			<div class="btn-box">
				<input class="btn btn-cancel" type="button" value="취소" onclick="history.go(-1)" >
				<input type="submit" value="수정하기" class="to-submit">
			</div>
		</form:form>
	</div>
</div>
<script>
/* 월별 일자 제어 */


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
	if (cnt < 6) {
		cnt++;
  		joinCnt.value = cnt;
	} else {
  		alert("참가인원은 6명까지 가능합니다.");
	}
});

/* 유효성검사 */
document.togetherUpdateFrm.addEventListener('submit', (e) => {
	
	const title = document.querySelector("#title");
	const categorys = document.querySelectorAll(".category");
	const content = document.querySelector(".content");
	const place = document.querySelector(".place");

	let error = 0;
	
	/* 제목 */
	const msg1 = document.querySelector(".title-error");
	if(!/^.{5,}$/.test(title.value)){
		msg1.style.display = "block";
		title.select();
		error += 1;
	}
	else{
		msg1.style.display = "none";
	}
	
	/* 카테고리 */
	let categoryChecked = 0;
	categorys.forEach((category) => {
		if(category.checked){
			categoryChecked++;
		} 
	});

	const msg2 = document.querySelector(".category-error");
	if(categoryChecked === 0){
		msg2.style.display = "block";
		error += 1;
	}
	else {
		msg2.style.display = "none";
	}
	
	/* 장소 */
	const msg3 = document.querySelector(".place-error");
	if(!/^.{5,}$/.test(place.value)){
		msg3.style.display = "block";
		place.select();
		error += 1;
	}
	else {
		msg3.style.display = "none";
	}
	
	if(error != 0 ){
		alert("게시물을 확인해주세요");
		e.preventDefault();
		return false;
	}

	/* 현재 시간보다 이전 시간의 모임 날짜를 제어 */
	const month = document.querySelector(".month").value;
	const date = document.querySelector(".date").value;
	const hour = document.querySelector(".hour").value;
	const minute = document.querySelector(".minute").value;
	const meridiem = document.querySelectorAll("[name='meridiem']");
	let amPm;
	meridiem.forEach((meri) => {
		if(meri.checked) {
			amPm = meri.value;
		}
	});
	
	const meeting = new Date();
	meeting.setMonth(month - 1);
	meeting.setDate(date);
	meeting.setHours(amPm == 'pm' ? Number(hour) + 12 : hour);
	meeting.setMinutes(minute);
	console.log(meeting);
	
	const now = new Date();
	console.log(now);
	
	if(now > meeting) {
		alert("모임 날짜는 미래만 선택할 수 있어요!");
		e.preventDefault();
	}
	
	return true;	
});


</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>