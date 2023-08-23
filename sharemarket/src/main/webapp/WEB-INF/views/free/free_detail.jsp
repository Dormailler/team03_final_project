<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/js/jquery-3.6.4.min.js"></script>
<link rel="stylesheet" href="/css/free_detail.css">
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=a860b9470c235ea7b99c9c4e99ca3f14&libraries=services"></script>
<script>
$(document).ready(function(){

	if("${session_id}" != "${dto.user_id }"){
		$('#btn_wrap').hide();
	}else{
		$('#message').hide();
	}
	var markers = [];

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  

	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 

	// 장소 검색 객체를 생성합니다
	var ps = new kakao.maps.services.Places();  

	// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({zIndex:1});

	// 키워드로 장소를 검색합니다
	searchPlaces("${dto.location}");

	// 키워드 검색을 요청하는 함수입니다
	function searchPlaces(keyword) {
	    ps.keywordSearch( keyword, placesSearchCB); 
	    
	}

	// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
	function placesSearchCB(data, status, pagination) {
	    if (status === kakao.maps.services.Status.OK) {

	        // 정상적으로 검색이 완료됐으면
	        // 검색 목록과 마커를 표출합니다
	        displayPlaces(data);

	        // 페이지 번호를 표출합니다
	        displayPagination(pagination);

	    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
	        alert('검색 결과가 존재하지 않습니다.');
	        return;
	    } else if (status === kakao.maps.services.Status.ERROR) {

	        alert('검색 결과 중 오류가 발생했습니다.');
	        return;
	    }
	    map.setLevel(3);
	}

	// 검색 결과 목록과 마커를 표출하는 함수입니다
	function displayPlaces(places) {

	    var listEl = document.getElementById('placesList'), 
	    menuEl = document.getElementById('menu_wrap'),
	    fragment = document.createDocumentFragment(), 
	    bounds = new kakao.maps.LatLngBounds(), 
	    listStr = '';
	    
	    
	    // 검색 결과 목록에 추가된 항목들을 제거합니다
	    removeAllChildNods(listEl);

	    // 지도에 표시되고 있는 마커를 제거합니다
	    removeMarker();
	    
	    for ( let i=0; i<1; i++ ) {

	        // 마커를 생성하고 지도에 표시합니다
	        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
	            marker = addMarker(placePosition, i), 
	            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
				
	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
	        // LatLngBounds 객체에 좌표를 추가합니다
	        bounds.extend(placePosition);

	        // 마커와 검색결과 항목에 mouseover 했을때
	        // 해당 장소에 인포윈도우에 장소명을 표시합니다
	        // mouseout 했을 때는 인포윈도우를 닫습니다
	        (function(marker, title) {
	            kakao.maps.event.addListener(marker, 'mouseover', function() {
	                displayInfowindow(marker, title, places[i].address_name);
	            });

	            kakao.maps.event.addListener(marker, 'mouseout', function() {
	                infowindow.close();
	            });
	            
	            itemEl.onclick =  function () {
	            	var spanElement = this.querySelector('div > span');
	            	var address = spanElement.innerHTML;	
	            	map.setLevel(3);
	            	map.setCenter(marker.getPosition());	
	                displayInfowindow(marker, title);
	            }; 

	            itemEl.onmouseout =  function () {
	                infowindow.close();
	            };
	        })(marker, places[i].place_name,itemEl);

	        fragment.appendChild(itemEl);
	    }

	    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
	    listEl.appendChild(fragment);
	    menuEl.scrollTop = 0;

	    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	    map.setBounds(bounds);
	}	

	// 검색결과 항목을 Element로 반환하는 함수입니다
	function getListItem(index, places) {

	    var el = document.createElement('li'),
	    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
	                '<div class="info">' +
	                '   <h5>' + places.place_name + '</h5>';

	    if (places.road_address_name) {
	        itemStr += '    <span>' + places.road_address_name + '</span>' +
	                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
	    } else {
	        itemStr += '    <span>' +  places.address_name  + '</span>'; 
	    }
	                 
	      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
	                '</div>';           

	    el.innerHTML = itemStr;
	    el.className = 'item';

	    return el;
	}

	// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
	function addMarker(position, idx, title) {
	    var /* imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png' */
	    	imageSrc = '/img/marker.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
	        imageSize = new kakao.maps.Size(42, 44),  // 마커 이미지의 크기
	        imgOptions =  {
	            spriteSize : new kakao.maps.Size(38, 720), // 스프라이트 이미지의 크기
	            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
	            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
	        },
	        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
	            marker = new kakao.maps.Marker({
	            position: position, // 마커의 위치
	            image: markerImage 
	        });
	    marker.setMap(map); // 지도 위에 마커를 표출합니다
	    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

	    return marker;
	}
	// 지도 위에 표시되고 있는 마커를 모두 제거합니다
	function removeMarker() {
	    for ( var i = 0; i < markers.length; i++ ) {
	        markers[i].setMap(null);
	    }   
	    markers = [];
	}

	// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
	function displayPagination(pagination) {
	    var paginationEl = document.getElementById('pagination'),
	        fragment = document.createDocumentFragment(),
	        i; 

	    // 기존에 추가된 페이지번호를 삭제합니다
	    while (paginationEl.hasChildNodes()) {
	        paginationEl.removeChild (paginationEl.lastChild);
	    }

	    for (i=1; i<=pagination.last; i++) {
	        var el = document.createElement('a');
	        el.href = "#";
	        el.innerHTML = i;

	        if (i===pagination.current) {
	            el.className = 'on';
	        } else {
	            el.onclick = (function(i) {
	                return function() {
	                    pagination.gotoPage(i);
	                }
	            })(i);
	        }
			
	        fragment.appendChild(el);
	    }
	    paginationEl.appendChild(fragment);
	}

	// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
	// 인포윈도우에 장소명을 표시합니다
	function displayInfowindow(marker, title , place) {
		
		if(place.length > 13){
			place_text = '<div>' + place.substr(0, 13) + '</div>' +'<div>' + place.substr(13) + '</div>';
		}else{
			place_text = '<div style="font-size:12px;>' + place + '</div>';
		}
	    var content = '<div style="padding:5px;z-index:1;text-align:center;">' + '<div style="color:#000D84">' + title + '</div>' + place_text ;
		
	    infowindow.setContent(content);
	    infowindow.open(map, marker);
	    
	    
	}

	 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
	function removeAllChildNods(el) {   
	    while (el.hasChildNodes()) {
	        el.removeChild (el.lastChild);
	    }
	}	
	$('#delete_btn').on('click',function(){
		if(window.confirm("게시글을 삭제합니다") == true){
			$.ajax({
			      url: '/delete_free', 
			      method: 'POST', 
			      data: {
			    	share_id:"${dto.share_id}",
			      },
			      success: function(response) {
			        console.log(response);
			        alert("삭제되었습니다.");
			        location.href = "/free";
			      },
			      error: function(xhr, status, error) {
			        console.log(error);
			      }
			});
		}else{ return; }
	})
	$('#update_btn').on('click',function(){
		location.href = "/freew/${dto.share_id}"
	});
	var category_text = $('.category').text()
	if(category_text == "fashion"){
		$('.category').text('패션');
	}else if(category_text == "beauty"){
		$('.category').text('뷰티');
	}else if(category_text == "child"){
		$('.category').text('아동');
	}else if(category_text == "life"){
		$('.category').text('생활');
	}else if(category_text == "electron"){
		$('.category').text('전자');
	}else if(category_text == "others"){
		$('.category').text('기타');
	}
	$('#complete_btn').on('click',function(){
		if(window.confirm("거래를 완료하셨습니까?") == true){
			$.ajax({
			      url: '/shared_ok', 
			      method: 'POST', 
			      data: {
			    	share_id:"${dto.share_id}"
			      },
			      success: function(response) {
			        console.log(response);
			        alert("거래 완료 처리되었습니다.");
			        location.href = "/free";
			      },
			      error: function(xhr, status, error) {
			        console.log(error);
			      }
			});
		}else{ return; }
	});
	$('h1 span').on('click',function(){
		location.reload();
	});
	
});
</script>

</head>
<body>
<div id="full_wrap">
<%@ include file="../header.jsp" %>
<h1 id="top"><span>무료나눔</span></h1>
<div id="contents_wrap">
	<div id="detail_wrap">
		<table>
			<tr>
				
				<td><h3 style="font-weight: bold;">${dto.title }</h3></td>
			</tr>
			<tr>

				<td><h4>닉네임&nbsp;&nbsp;&nbsp; | ${dto.user_id }</h4></td>
			</tr>
			<tr>
				
				<td><h4>희망장소 | ${dto.location }</h4></td>
			</tr>
			<%-- <tr>

				<td><h4 class="category">${dto.category }</h4></td>
			</tr>  --%>
			<tr>
				<td><h4>${dto.date }</h4></td>
				
			</tr>
		</table>
	</div>
	<div id="location">
		
		<div class="map_wrap" style="width:100%;">
		    	<div id="map" style="width:100%;height:335px;position:relative;overflow:hidden;"></div>
		    	<div id="menu_wrap" class="bg_white" style="display:none;">
			        <div class="option">
			            <div>
			                <form id="submit_form" submit="searchPlaces(); return false;">
								   키워드 : <input type="text" id="keyword" size="15"> 
			                    <button type="submit" id="searchBtn">검색</button> 
			                </form>
			            </div>
			        </div>
			        <hr>
			        <ul id="placesList"></ul>
			        <div id="pagination"></div>
			    </div>
		</div>
	</div>
	<div id="img"><img referrerpolicy="no-referrer" src="/save/${dto.img }" onerror="this.src='${dto.img}';"/></div>
	<div id="content_box">${dto.content }</div>
		<div id="message"><button>메시지 보내기</button></div>
		<div id="btn_wrap">
			<button id="delete_btn">삭제</button>
			<button id="update_btn">수정</button>
			<button id="complete_btn">거래완료</button>
		</div>
</div>



<%@ include file="../footer.jsp" %>
</div>
</body>
</html>