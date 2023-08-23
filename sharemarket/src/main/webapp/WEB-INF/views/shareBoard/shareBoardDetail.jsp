<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/shareBoard/shareBoardDetail.css" />
<title>${boardDetail.title}</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9d51e14efdcd5a00f3175eb08d5e4a2a&libraries=services"></script>
</head>
<script>
const queryString = window.location.search;
const urlParams = new URLSearchParams(queryString);
const share_id = urlParams.get('share_id');


</script>
<body>
<jsp:include page="../header.jsp"/>

	<div id="layout">
		<div class="boardDetail">
			<main>
			<div id="header">
				<p id="boardName">${boardDetail.type}</p>
				<p id="boardTitle">제목 : ${boardDetail.title}</p>
			</div>
			
			<div class="contents">
				<div class="userInfoAside">
					<p>이름</p>
					<p>날짜</p>
					<p>분류</p>
					<p>종류</p>
					<p>공유</p>
				</div>
				<div class="userInfo">
					<p>${boardDetail.user_id}</p>
					<p>${boardDetail.date}</p>
					<p>${boardDetail.category}</p>
					<p>${boardDetail.item}</p>
					<p>
					    <c:choose>
					        <c:when test="${boardDetail.is_shared eq false}">
					            거래중
					        </c:when>
					        <c:when test="${boardDetail.is_shared eq true}">
					            거래완료
					        </c:when>
					    </c:choose>					
					</p>
				</div>
				<div class="locationAside">
					<p>위치</p>
				</div>
				<div class="location">
					<div id="map" style="width:200px;height:200px;"></div>
				</div>
				<div class="imgAside">
					<p>사진</p>
				</div>
				<div class="img">
					<p><img src="${boardDetail.img}" style="max-width:200px;max-height:200px;" /></p>
				</div>
				<div class="text">
					<div>${boardDetail.content}</div>
				</div>
				<div class="btnWrap">
					<button id="shared">거래완료</button>
					<button id="contact">연락하기</button>
					<button id="delete">삭제하기</button>
					<button id="edit">수정하기</button>
				</div>
				<div class="commentWrap">
					<div>
						<c:forEach var="commentList" items="${commentList}" begin="0" end="9">
							<div>
								<p>${commentList.share_id}</p>
								<p>${commentList.name}</p>
								<p>${commentList.date}</p>
								<p>${commentList.comment}</p>
							</div>
						</c:forEach>
					</div>
				</div>				
			</div>
			</main>
		</div>
	</div>

<script>
//마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places(); 

// 키워드로 장소를 검색합니다
ps.keywordSearch('${boardDetail.location}', placesSearchCB); 

// 키워드 검색 완료 시 호출되는 콜백함수 입니다
function placesSearchCB (data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        var bounds = new kakao.maps.LatLngBounds();

        for (var i=0; i<data.length; i++) {
            displayMarker(data[i]);    
            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
        }       

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map.setBounds(bounds);
    } 
}

// 지도에 마커를 표시하는 함수입니다
function displayMarker(place) {
    
    // 마커를 생성하고 지도에 표시합니다
    var marker = new kakao.maps.Marker({
        map: map,
        position: new kakao.maps.LatLng(place.y, place.x) 
    });

    // 마커에 클릭이벤트를 등록합니다
    kakao.maps.event.addListener(marker, 'click', function() {
        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
        infowindow.open(map, marker);
    });
}


$(document).ready(function() {
	
    var sessionUserId = '${sessionScope.user_id}';
    var buttonUserId = '${boardDetail.user_id}';

    // user_id가 일치할 경우 delete 버튼을 보이게 함
    if (sessionUserId === buttonUserId) {
        $("#delete").show();
        $("#shared").show();
        $("#edit").show();
    } else {
        $("#delete").hide();
        $("#shared").hide();
        $("#edit").hide();
    }
	
	
    $("#delete").on('click', function() {

        $.ajax({
            url: "/deleteshareboard",
            type: "POST",
            dataType: "json",
            data: {
                share_id: share_id
            },
            success: function(response) {
				location.href = "/shareboardlist";
            },
            error: function(xhr, status, error) {
                alert("오류 발생: " + error);
            }
        });
    });
    
    $("#shared").on('click', function() {

        $.ajax({
            url: "/sharedconfirm",
            type: "POST",
            dataType: "json",
            data: {
                share_id: share_id
            },
            success: function(response) {
				location.href = "/sharedetail?share_id=${boardDetail.share_id}";
            },
            error: function(xhr, status, error) {
                alert("오류 발생: " + error);
            }
        });
    });
});
</script>

<jsp:include page="../footer.jsp"/>
</body>
</html>