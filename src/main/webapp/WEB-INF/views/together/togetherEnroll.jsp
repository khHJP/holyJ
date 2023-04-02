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
/* 현재 날짜와 20일 이후 날짜 사이 구하기 */
window.addEventListener('load', (e) => {
 	const today = new Date();
    const nextMonth = today.getMonth() + 2; // 다음 달
    const daysLater = 20; // 20일 후

    // 이번 달의 마지막 날짜 객체 생성
    const lastDay = new Date(today.getFullYear(), today.getMonth() + 1, 0); 
    // 현재 시간을 기반으로 새로운 Date 객체 생성
    const futureDate = new Date(today.getTime());
    // 오늘 날짜에 daysLater를 더하여 설정
    futureDate.setDate(today.getDate() + daysLater); 
    
    const months = [];
    months.push(today.getMonth() + 1);
    // 20일 후가 이번달이 아닐 경우
    if((futureDate.getMonth() + 1) != (today.getMonth() + 1)){
    	months.push(nextMonth);
    }
    
    // 달별 option
    const month = document.querySelector(".month");
    for(let i = 0; i < months.length; i++){
        const option = document.createElement("option");
        option.value = months[i];
        option.innerText = months[i];
        month.append(option);
    }
    
    // 일별 option 
    const date = document.querySelector(".date");
    // 다음달로 넘어가지 않을겨우
    if(months.length == 1){
	   	for(let i = today.getDate(); i <= today.getDate() + daysLater; i++){
	   		const option = document.createElement("option");
	           option.value = i;
	           option.innerText = i;
	           option.classList.add(today.getMonth() + 1);
	           option.style.display='none';
	           date.append(option);
	    }
    }
    
   	// 다음달로 넘어갈 경우
    if(months.length > 1){
    	// 이번달
    	for(let i = today.getDate(); i <= lastDay.getDate(); i++){
       		const option = document.createElement("option");
               option.value = i;
               option.innerText = i;
               option.classList.add(today.getMonth() + 1);
               option.style.display='none';
               date.append(option);
        }
    	// 다음달
	   	for(let i = 1; i < futureDate.getDate(); i++) {
	   		const option = document.createElement("option");
	   	        option.value = i;
	   	        option.innerText = i;
	   	        option.classList.add(futureDate.getMonth() + 1);
	   	     	option.style.display='none';
	   	        date.append(option);
   	    }
   	} 
    
});
</script>
<div class="enroll-container">
	<div class="enroll-wrap">
		<div class="page-title">
			<h2>무엇을 같이할까요?</h2>
			<p>이웃과 함께 잊지 못할 추억을 만들어봐요!</p>
		</div>
		<div class="today">
			<fmt:formatDate value="${today}" pattern="yyyy-MM-dd E요일"/>
		</div>
		<form:form name="togetherEnrollFrm">
			<div class="together-wrap">
				<p class="notice-text">* 모든 내용을 작성해주세요!</p>
				<div class="content-box flex">
					<div class="sub-box">
						<i class="bi bi-blockquote-left"></i>
						<label class="to-title">글 제목</label>
					</div>
					<div>
						<input type="text" name="title" class="to-input" id="title" placeholder="제목을 입력해주세요!">
						<p class="error-msg title-error">제목을 입력해주세요.(3글자 이상)</p>
					</div>
				</div>
				<div class="content-box flex">
					<div class="sub-box">
						<i class="bi bi-signpost"></i>
						<label class="to-title">카테고리</label>
					</div>
					<div class="data-box">
						<c:forEach items="${categorys}" var="category" varStatus="vs">
							<input class="category" type="radio" name="categoryNo" id="category${vs.count}" value="${category.CATEGORY_NO}">
							<label class="category-label" for="category${vs.count}">
								${category.CATEGORY_NAME}
							</label>
						</c:forEach>
						<p class="error-msg category-error">카테고리를 선택해주세요.</p>
					</div>
				</div>
				<div>
					<div>
						<div class="content-box flex">
							<div class="sub-box">
								<i class="bi bi-diagram-2"></i>
								<label for="joinCnt" class="to-title">인원</label>
							</div>
							<i class="bi bi-dash-circle minus"></i>
							<input type="number" class="join-cnt" value="3" name="joinCnt" readonly/>
							<i class="bi bi-plus-circle plus"></i>
						</div>
						<div class="content-box flex">
							<div class="sub-box">
								<i class="bi bi-people-fill"></i>
								<label for="age_100" class="to-title">나이</label>
							</div>
							<div class="data-box">
								<input type="radio" name="age" id="age_100" value="100" checked>
								<label for="age_100">누구나</label>
								<input type="radio" name="age" id="age_20" value="20">
								<label for="age_20">20대</label>
								<input type="radio" name="age" id="age_30" value="30">
								<label for="age_30">30대</label>
								<input type="radio" name="age" id="age_40" value="40">
								<label for="age_40">40대</label>
								<input type="radio" name="age" id="age_50" value="50">
								<label for="age_50">50대</label>
							</div>
						</div>
						<div class="content-box flex">
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
						<div class="date-container">
							<div class="date-box">
								<div class="sub-box">
									<i class="bi bi-calendar4-week"></i>
									<label class="to-title">날짜</label>
									<p class="error-msg date-error">날짜를 선택해주세요.</p>
								</div>
								<div class="data-box">
									<select id="date-select" class="month select" name="month" required>
										<option value="none" selected>월</option>
									</select>
									<select id="date-select" class="date select" name="date" required>
										<option value="none" selected>일</option>
									</select>
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
					<div class="content-box flex">
						<div class="sub-box">
							<i class="bi bi-geo-alt"></i>
							<label class="to-title">장소</label>
						</div>
						<div>
							<input type="text" name="place" class="to-input place" style="display: block;" placeholder="장소를 직접 입력해주세요!">
							<p class="error-msg place-error">장소를 입력해주세요.(3글자 이상)</p>
						</div>
					</div>
				</div>
				<div class="content-box">
					<div class="sub-box">
						<i class="bi bi-pencil-square"></i>
						<label class="to-title">모임 내용</label>
					</div>
					<textarea rows="10" cols="65" class="content" name="content" style="resize: none;" placeholder="내용을 작성해주세요!"></textarea>
					<p class="error-msg content-error">내용을 입력해주세요.(5글자 이상)</p>
				</div>
			</div>
			<sec:authentication property="principal" var="loginMember"/>
			<input type="hidden" name="writer" value="${loginMember.memberId}">
			<div class="btn-box">
				<input class="btn btn-cancel" type="button" value="취소" onclick="history.go(-1)" >
				<input type="submit" value="등록하기" class="to-submit">
			</div>
		</form:form>
	</div>
</div>
<script>
/* 월별 일자 제어 */
document.querySelector(".month").addEventListener("change", (e) => {
	const date = document.querySelector(".date");
	date.selectedIndex = 0; // 선택된 동 초기화
	
	const options = date.getElementsByTagName("option");
	
	for (let i = 0; i < options.length; i++) {
		const option = options[i];
		// 해당 태그에 타겟과 일치하는 date 분기처리
		if (option.classList.contains(e.target.value))
			option.style.display = "block"; 
		else
			option.style.display = "none";
	}
	
});

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
document.togetherEnrollFrm.addEventListener('submit', (e) => {
	
	const title = document.querySelector("#title");
	const categorys = document.querySelectorAll(".category");
	const content = document.querySelector(".content");
	const place = document.querySelector(".place");

	let error = 0;
	
	/* 제목 */
	const msg1 = document.querySelector(".title-error");
	if(!/^.{3,}$/.test(title.value)){
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
	
	// 날짜
	const month = document.querySelector(".month").value;
	const date = document.querySelector(".date").value;
	const msg5 = document.querySelector(".date-error");
	if(month == 'none' || date == 'none'){
		msg5.style.display = "block";
		error += 1;
	}
	else {
		msg5.style.display = "none";
	}
	
	/* 장소 */
	const msg3 = document.querySelector(".place-error");
	if(!/^.{3,}$/.test(place.value)){
		msg3.style.display = "block";
		place.select();
		error += 1;
	}
	else {
		msg3.style.display = "none";
	}
	
	/* 내용 */
	const msg4 = document.querySelector(".content-error");
	if(content.value.length < 4){
		msg4.style.display = "block";
		content.select();
		error += 1;
	}
	else {
		msg4.style.display = "none";
	}
	
	if(error != 0){
		alert("게시물을 확인해주세요");
		e.preventDefault();
		return false;
	}

	/* 현재 시간보다 이전 시간의 모임 날짜를 제어 */
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