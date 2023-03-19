<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="중고거래" name="title"/>
</jsp:include>

<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<!--<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
 bootstrap css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/craig2.css" />
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fa0f4a31c85566db414a70bc9044491b"></script>


<h2> 내 물건 팔기  </h2>
<div id="craigBoardContainer">
	<form id="craigEnrollFrm" name="craigEnrollFrm"  enctype ="multipart/form-data"  method="post">
		<input type="hidden" class="form-control" name="memberId" required>
		
		<!-- ●  첨부파일 ● -->	
		<div style="display: flex; margin:10px 0px 10px 0px">
			<div id="col_img"  style="margin-top : 0px" >
				<img id="col_img_viewer"  style="width : 200px; height : 170px; padding-right: 20px">
			</div>
			<div id="col_img"  style="margin-top : 0px" >
				<img id="col_img_viewer2"  style="width : 200px; height : 170px; padding-right: 20px">
			</div>	
			<div id="col_img"  style="margin-top : 0px" >
				<img id="col_img_viewer3"  style="width : 200px; height : 170px;">
			</div>		
		</div>
		<div class="input-group mb-3" style="padding:0px;">
		  <div class="custom-file" >
		    <input type="file" class="custom-file-input" name="upFile" id="upFile1" multiple >
		    <label class="custom-file-label" for="upFile1" >파일을 선택하세요(최대3개까지 가능)</label>
		  </div>
  		  <div class="input-group-prepend" style="padding:0px;">

		    <p class="input-group-text"> ※ 여러장을 올리고 싶으시면 shift+이미지 선택을 해보세요!</p>
		  </div>
		</div><br><br>

		
	
		<table>
			<tr>
				<th style="width : 80px"><label for="title"> 글 제목  </label></th>
				<td><input type="text" class="formtext" placeholder=" 제목을 입력해주세요 " name="title" id="title" required></td>
			</tr>
			
			<tr>
				<th style="width : 80px"><label for="category"> 카테고리 </label></th>
				<td>
				<c:forEach items="${craigCategory}" var="category"> 	
					<input type="radio"  name="category" value="${category.no}" style="margin-left: 12px"> ${category.CATEGORY_NAME}
				</c:forEach>
				</td>
			</tr>	
	
			<tr>
				<th style="width : 80px"><label for="price"> ￦ 가격 </label></th>
				<td><input type="number"  class="formtext" name="price" id="price" placeholder="숫자만 입력해주세요" style="width: 300px; margin-right: 200px"/>      <input type="checkbox" name="share" id="share" onclick="sharecheck(this)">나눔 </td>
			</tr>	

			<tr>
				<th colspan="2" >내용</th>
			</tr>

			<tr>
				<th colspan="2" >
			    	<textarea class="formtext" name="content" placeholder="내용을 작성해주세요 ✍️"  style="width:650px; height: 90px"  required="required"></textarea><br>
			    </th>
		    </tr>
		    
		    <tr>
				<th style="width : 100px"  >거래희망장소</th>
				<td> <button id="pickPlace"> 장소선택 > </button><br>
			</tr>	
			<tr>
				<th colspan="2" >	
					<input class="formtext"  type="text" name="placeDetail" id="placeDetail" readonly="readonly" />
					<input class="formtext"  type="hidden" name="latitude" id="latitude" readonly="readonly" />
					<input class="formtext"  type="hidden" name="longitude" id="longitude" readonly="readonly" />
				</th>
			</tr>
	    </table></br>
	    	<p id="mapP">🥒 장소를 등록하시면 해당 위치가 나타납니다 </p>
	    	<div id="map" style="width:650px;height:300px; border: 1px solid green;"></div> 	

		<br />
		<input type="text" class="btn btn-outline-success" value="취소" >
		<input type="submit" class="btn btn-outline-success" value="글쓰기" >
	</form><br><br>
</div>





<script>
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
</script>



<script>
	//	장소고르기
	document.querySelector("#pickPlace").addEventListener('click', (e) => {
		const url = `${pageContext.request.contextPath}/craig/craigPickPlace.do`;
		const name = "pickPlace"; // popup의 window이름. 브라우져가 탭,팝업윈도우를 관리하는 이름
		const spec = "width=500px, height=550px";
		open(url, name, spec);
	});
</script>	

<script>
const latitude = document.querySelector("#latitude");
const longitude = document.querySelector("#longitude");


var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
   mapOption = { 
       center: new kakao.maps.LatLng(latitude, longitude), // 지도의 중심좌표
       level: 3 // 지도의 확대 레벨
   };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

// 마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng(latitude, longitude); 

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: markerPosition
});

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
// marker.setMap(null);    
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
			document.querySelector("#upload-name1").value = document.querySelector("#upFile1").value;
		};
	}
	if(img.files[1]){
		// 파일 선택한 경우
		const fr = new FileReader(); 
		fr.readAsDataURL(img.files[1]); 
		fr.onload = (e) => {
			// 읽기 작업 완료시 호출될 load이벤트핸들러
			document.querySelector("#col_img_viewer2").src = e.target.result; 
			document.querySelector("#upload-name1").value = document.querySelector("#upFile1").value;
		};
	}	
	if(img.files[2]){
		// 파일 선택한 경우
		const fr = new FileReader(); 
		fr.readAsDataURL(img.files[2]); 
		fr.onload = (e) => {
			// 읽기 작업 완료시 호출될 load이벤트핸들러
			document.querySelector("#col_img_viewer3").src = e.target.result; 
			document.querySelector("#upload-name1").value = document.querySelector("#upFile1").value;
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