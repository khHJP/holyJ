<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> <!-- 0228 추가 -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> <!-- 0228 추가 -->

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="중고거래" name="title"/>
</jsp:include>
<style>
dl, ol, ul { text-align: center;  margin-top: 5px; margin-bottom: 0; }
a { text-decoration:none !important }
a:hover { text-decoration:none !important }
.notice-wrap, .non-login {margin-top: 5px;}
button, input, optgroup, select, textarea {
    margin: 0;   font-family: 'Arial', sans-serif;font-size: 14px;  font-weight: 600; }

#crentb{
	width: 690px; margin: auto;
}

#crentb th{
	padding-left: 30px;	max-width : 120px; min-width: 120px;
}

.custom-file-label{
	border: 1px solid gray; width:630px;font-weight: 200
}

.custom-file-input{
	border: 1px solid gray; 
}


</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/craig2.css" />
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fa0f4a31c85566db414a70bc9044491b"></script>


<h2> 내 물건 팔기  </h2>
<div id="craigBoardContainer">
	
	<form:form id="craigEnrollFrm" name="craigEnrollFrm"  enctype ="multipart/form-data"  method="post"
	 action="${pageContext.request.contextPath}/craig/craigBoardEnroll.do?${_csrf.parameterName}=${_csrf.token}"  >
	<sec:authentication property="principal" var="loginMember"/>
		<input type="hidden" class="form-control" name="writer" id="writer" value="${loginMember.memberId}" required>
		<table id="crentb" style="border: 1.5px solid lightgray; border-top:2px solid lightgray; border-bottom:2px solid lightgray; margin-bottom: 20px; padding: 30px;"  >		
		<!-- ●  첨부파일 ● -->	
		<tr>
		<th style="max-width : 100px; min-width: 100px;" colspan="2">
		<div style="display: flex; margin:20px 0px 10px 0px;">
			<div id="col_img"  style="margin-top : 0px" >
				<img id="col_img_viewer"  style="width : 210px; height : 170px; padding-right: 20px">
			</div>
			<div id="col_img"  style="margin-top : 0px" >
				<img id="col_img_viewer2"  style="width : 210px; height : 170px; padding-right: 20px">
			</div>	
			<div id="col_img"  style="margin-top : 0px" >
				<img id="col_img_viewer3"  style="width : 210px; height : 170px;">
			</div>		
		</div>
		<div class="input-group mb-3" style="padding:0px;">
		  <div class="custom-file" >
		    <input type="file" class="custom-file-input" name="upFile" id="upFile1" multiple >
		    <label class="custom-file-label" for="upFile1" >파일을 선택하세요(최대3개까지 가능)</label>
		    <br><p style="margin-top: 150px; margin-left: -200px; font-weight: 300; font-size: 14px;">※ 여러장을 올리고 싶으시면 shift+이미지를 선택해보세요!</p>
		  </div>
  		 <%--<div class="input-group-prepend" style="padding:0px;">
	  		  <br><br>
		    <p>※ 여러장을 올리고 싶으시면 shift+이미지를 선택해보세요!</p>
		  </div>--%>
		</div><br><br><br>
		</th>
		</tr>
		
	
<!-- 		<table id="crentb" style="border: 1.5px solid lightgray;border-top:2px solid lightgray; border-bottom:2px solid lightgray;padding: 10px; margin-bottom: 20px"  >-->			
			<tr>
				<th><label for="title"> 글 제목  </label></th>
				<td style="max-width:650px;"><input type="text" class="formtext" placeholder=" 제목을 입력해주세요 " name="title" id="title" required></td>
			</tr>
			
			<tr>
				<th style="max-width : 100px;" ><label for="category"> 카테고리 </label></th>
				<td style="max-width:650px; text-align: left">
				<c:forEach items="${craigCategory}" var="category"> 	
					<input type="radio" id="categoryNo" name="categoryNo" value="${category.CATEGORY_NO}" data-no="${category.CATEGORY_NO}" style="margin-left: 12px"> <label for="categoryNo">${category.CATEGORY_NAME}</label> 
				</c:forEach>
				</td>
			</tr>	
	
			<tr>
				<th style="max-width : 100px;"><label for="price"> ￦ 가격 </label></th>
					<td style="max-width:600px;"><input type="number" class="formtext" name="price" id="price" placeholder="숫자만 입력해주세요" style="width: 400px; margin-right: 90px; margin-bottom: 5px;"/>      
						<input type="checkbox" name="share" id="share" onclick="sharecheck(this)"> 나눔
						<p style="font-size: 12px; width:300px; margin-left: -20px; margin-bottom: 0">※ '삽니다'의 경우 원하시는 가격을 기재해주세요😊</p>
						<p style="font-size: 12px; width:300px; margin-left: -8px">※ '나눔' 의 경우 가격은 자동으로 0원으로 변경됩니다😍</p>						
					</td>
			</tr>	

			<tr>
				<th colspan="2" style="border: none">내용</th>
			</tr>

			<tr>
				<th colspan="2" style="padding-bottom: 20px;">
			    	<textarea class="formtext" name="content" id="content" placeholder=" &nbsp; 내용을 작성해주세요 ✍️"  style="min-width:650px; height: 90px"  required="required"></textarea></br></br>
			    </th>
		    </tr>
			
			<tr style="height: 50px;">
			</tr>			    
		    
		    <tr>
				<th style="border: none; max-width : 100px;">거래희망장소</th>
				<td style="border: none;  vertical-align: middle"> <button id="pickPlace"  class="btn btn-light"> 장소선택 </button><br>
			</tr>

			<tr>
				<th colspan="2" style="border: none; ">
				 <p id="mapP" style="margin-left: 0px">🥒 장소를 등록하시면 해당 위치가 나타납니다</p>
					<input class="formtext" style="width : 650px;"  type="text" name="placeDetail" id="placeDetail" readonly="readonly" />
					<input class="formtext"  type="hidden" name="latitude" id="latitude" readonly="readonly" />
					<input class="formtext"  type="hidden" name="longitude" id="longitude" readonly="readonly" />
				</th>
			</tr>
			<tr>
			<th colspan="2" style="border: none;" >
		    	<div id="map" style="width:600px; height:300px; border: none; margin-left: 50px"></div> 	
			</th>	    	
			</tr>
	    </table>
	    
		<input class="btn btn-cancel" type="button" value="취소" onclick="history.go(-1)" >
		<input type="submit" class="btn btn-outline-success" value="완료" >
		<hr style="border : 1px solid lightgray; margin-top: 20px; width: 700px" />
	</form:form><br><br>
</div>




<script>

/* 
const cateno = document.querySelector("#categoryNo");
cateno.addEventListener( 'click', (e)=>{
	console.log(e.target);
	console.log(e.target.value);
	const no = e.target.dataset.no;
	console.log( no );
	
}) */
//카테고리뽑기
document.querySelectorAll("input[data-no]").forEach( (input)=>{
	
	input.addEventListener('click', (e) => {
		
		const no = input.dataset.no;
		console.log( "no", no );

		const inputValue = input.value;
		console.log( "inputValue", inputValue );

	})
})


//가격
function sharecheck(){
	const share = document.querySelector("#share");
	const price = document.querySelector("#price");
	
 	console.log( $("input:checkbox[id='share']").is(":checked")  );	
 	
 	if( $("input:checkbox[id='share']").is(":checked")  ){
 		price.value = 0;
 		$("#price").attr('readonly', true);
 	}else{
 
 		$("#price").attr('readonly', false);
 	}
 	
};

//form 유효성검사 
document.craigEnrollFrm.onsubmit = (e) =>{
	console.log ( e );

	const title = e.target.title; 
	const content  = e.target.content;
	const placeDetail  = e.target.placeDetail;

	
	
	//제목 작성하지 않은경우 
	if( !/^.+$/.test(title.value)){
		alert("제목을 작성해주세요!");
		title.select();
		return false;
	}
	
	//내용 없는경우
	if(!/^.|\n+$/.test(content.value)){
		alert("내용을 작성해주세요!");
		content.select();
		return false;
	}
	
	<%-- 음 쓰면오류^^
	//장소 없는경우
	if(!/^.|\n+$/.test(placeDetail.value)){
		alert("장소를 선택해주세요!");
		pickPlace.select();
		return false;
	}
	--%>
	
}
</script>

<script>
//	장소고르기
document.querySelector("#pickPlace").addEventListener('click', (e) => {
	e.preventDefault();
	
	const url = `${pageContext.request.contextPath}/craig/craigPickPlace.do`;
	const name = "pickPlace"; // popup의 window이름. 브라우져가 탭,팝업윈도우를 관리하는 이름
	const spec = "width=530px, height=580px";
	open(url, name, spec);
});
</script>	

<script>
const latitude = document.querySelector("#latitude");
const longitude = document.querySelector("#longitude");

var mapContainer = document.getElementById('map'), // 지도 div 
   mapOption = { 
       center: new kakao.maps.LatLng(latitude, longitude), // 중심좌표
       level: 3 
   };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도생성

var markerPosition  = new kakao.maps.LatLng(latitude, longitude); // 마커가 표시될 위치

var marker = new kakao.maps.Marker({ //마커
    position: markerPosition
});

// 마커 지도 위에 표시
marker.setMap(map);
</script>

<script>
/* 첨부파일 이미지 미리보기 */
document.querySelector("#upFile1").addEventListener('change', (e) => {
	const img = e.target;
	
	if(img.files[0]){
		// 파일 선택한 경우
		const fr = new FileReader(); 
		fr.readAsDataURL(img.files[0]); 
		fr.onload = (e) => {
			// 읽기 작업 완료시 호출될 load이벤트핸들러
			document.querySelector("#col_img_viewer").src = e.target.result; 
//			document.querySelector("#upload-name1").value = document.querySelector("#upFile1").value;
		};
	}
	if(img.files[1]){
		// 파일 선택한 경우
		const fr = new FileReader(); 
		fr.readAsDataURL(img.files[1]); 
		fr.onload = (e) => {
			// 읽기 작업 완료시 호출될 load이벤트핸들러
			document.querySelector("#col_img_viewer2").src = e.target.result; 
	//		document.querySelector("#upload-name1").value = document.querySelector("#upFile1").value;
		};
	}	
	if(img.files[2]){
		// 파일 선택한 경우
		const fr = new FileReader(); 
		fr.readAsDataURL(img.files[2]); 
		fr.onload = (e) => {
			// 읽기 작업 완료시 호출될 load이벤트핸들러
			document.querySelector("#col_img_viewer3").src = e.target.result; 
		//	document.querySelector("#upload-name1").value = document.querySelector("#upFile1").value;
		};	
	}	

	else {
		// 파일 선택 취소한 경우
		document.querySelector("#col_img_viewer").src = "";
	}
});

</script>




	
	
<br><br><br><br><br>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>