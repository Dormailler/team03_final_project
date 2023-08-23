<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/js/jquery-3.6.4.min.js"></script>
<script src="/smarteditor/js/HuskyEZCreator.js"></script>
<script src="/js/free_write.js"></script>
<link rel="stylesheet" href="/css/free_write.css">
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=a860b9470c235ea7b99c9c4e99ca3f14&libraries=services"></script>

<script>
$(document).ready(function(){

	let Editors = []
	
	smartEditor = function(){
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: Editors,
			elPlaceHolder : "editorText",
			sSkinURI : "/smarteditor/SmartEditor2Skin2.html",
			fCreator: "createSEditor2"
		})
	}
	
	smartEditor();

	var markers = [];

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
	        level: 5 // 지도의 확대 레벨
	    };  

	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 

	// 장소 검색 객체를 생성합니다
	var ps = new kakao.maps.services.Places();  

	// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({zIndex:1});

	// 키워드로 장소를 검색합니다
	searchPlaces();

	// 키워드 검색을 요청하는 함수입니다
	function searchPlaces() {

	    var keyword = document.getElementById('keyword').value;

	    /* if (!keyword.replace(/^\s+|\s+$/g, '')) {
	        alert('키워드를 입력해주세요!');
	        return false;
	    } */

	    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
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
	    
	    for ( let i=0; i<places.length; i++ ) {

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
	                displayInfowindow(marker, title);
	            });

	            kakao.maps.event.addListener(marker, 'mouseout', function() {
	                infowindow.close();
	            });
	            kakao.maps.event.addListener(marker, 'click', function() {
	            	$('.location_text').html(places[i].place_name);
	            	$("#modal_wrap").hide();
	            	map.setLevel(3);
	            	map.setCenter(marker.getPosition());
	            	displayInfowindow(marker, title);
					
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
	    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
	        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
	        imgOptions =  {
	            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
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
	function displayInfowindow(marker, title) {
		
	    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
		
	    infowindow.setContent(content);
	    infowindow.open(map, marker);
	    
	    
	}

	 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
	function removeAllChildNods(el) {   
	    while (el.hasChildNodes()) {
	        el.removeChild (el.lastChild);
	    }
	}	
	
	$('.location').on('click',function(){
	    setTimeout(function() {
	    	searchPlaces();	
		    map.relayout();
	    }, 0); 
	    
	});
	$('#submit_form').on('submit',function(e){
		searchPlaces();
		if($('#keyword').val() == ""){
			e.preventDefault();
			alert("키워드를 입력해주세요!")
		}
		return false;
	});
	
	$('#register_btn').on('click',function(e){

		var address = $('.location_text').html();
		var category = $('#category').val();
		var title = $('#title').val();
        var fileInput = $(".real-upload");
        var files = fileInput[0].files;
        

       	Editors.getById["editorText"].exec("UPDATE_CONTENTS_FIELD", []);
       
       	var content = $('#editorText').val();
       	var fileNamesArray = [];
        for (var i = 0; i < files.length; i++) {
            var fileName = files[i].name;
            fileNamesArray.push(fileName);
        }

        var fileNames = fileNamesArray.join(",");
       
		if(category == null){
			alert("카테고리를 선택해주세요");
			return;
		}
		if(title == ""){
			alert("제목을 입력해주세요");
			return;
		}
		if ($('.image-preview li').length == 0){
			alert("사진을 등록해주세요");
			return;
		}
		if(address == ""){
			alert("위치를 입력해주세요");
			return;
		}
		if(content == "<p>&nbsp;</p>"){
   			alert("내용을 입력해주세요");
   			return;
   		}
		if(address == undefined){
			alert("장소를 선택해주세요.");
			return;
		}
		
        if (files.length > 0) {
            var formData = new FormData();
            
            for (var i = 0; i < files.length; i++) {
                formData.append("files", files[i]);
            }
           
            fetch("/upload", {
                method: "POST",
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                console.log(data.message);
                
            })
            .catch(error => {
                console.error("Error:", error);
            });
        }
		
		if(files.length == 0 && $('.image-preview li').length != 0){
			fileNames = "${dto.img}";
		}
		$.ajax({
			url: '/get_name', 
		      method: 'POST', 
		      data: {
		    	user_id:"${session_id}"
		      },
		      success: function(response) {
		        let name = response;
		        $.ajax({
				      url: '/register_free', 
				      method: 'POST', 
				      data: {
				    	user_id:"${session_id}",
				    	name: name,
				    	title: title,
				    	category: category,
				        location: address,
				        content: content,
				        img: fileNames
				      },
				      success: function(response) {
				        console.log(response);
				      },
				      error: function(xhr, status, error) {
				        console.log(error);
				      }
				});
		      },
		      error: function(xhr, status, error) {
		        console.log(error);
		      }
		});
		
		alert("등록되었습니다.");
		location.href = "/free";
	});
	
	if('${dto.img}'){
		const imagePreview = document.querySelector('.image-preview');
		const li = document.createElement('li');
	    const img = document.createElement('img');
	    img.setAttribute('referrerpolicy', "no-referrer");
	    img.setAttribute('src', "/Users/kdt/upload/" + "${dto.img}");
	    img.setAttribute('onerror',"this.src='${dto.img}';");
	    li.appendChild(img);
	    imagePreview.appendChild(li);
	}
	let selectElement = document.getElementById('category');
	var dto_category = "${dto.category}";
    let options = selectElement.options;
    for (let i = 0; i < options.length; i++) {
        if (options[i].value == dto_category) {
            selectElement.selectedIndex = i;
            break;
        }
    }
    
   	$('#editorText').html(`${dto.content}`.replace(/\n/g, '<br>'));

    
    
    $('#update_btn').on('click',function(e){

		var address = $('.location_text').html();
		var category = $('#category').val();
		var title = $('#title').val();
        var fileInput = $(".real-upload");
        var files = fileInput[0].files;
        

       	Editors.getById["editorText"].exec("UPDATE_CONTENTS_FIELD", []);
       
       	var content = $('#editorText').val();
       	var fileNamesArray = [];
        for (var i = 0; i < files.length; i++) {
            var fileName = files[i].name;
            fileNamesArray.push(fileName);
        }

        var fileNames = fileNamesArray.join(",");
       
		if(category == null){
			alert("카테고리를 선택해주세요");
			return;
		}
		if(title == ""){
			alert("제목을 입력해주세요");
			return;
		}
		if ($('.image-preview li').length == 0){
			alert("사진을 등록해주세요");
			return;
		}
		if(address == ""){
			alert("위치를 입력해주세요");
			return;
		}
		if(content == "<p>&nbsp;</p>"){
   			alert("내용을 입력해주세요");
   			return;
   		}
		if(address == undefined){
			alert("장소를 선택해주세요.");
			return;
		}
		
        if (files.length > 0) {
            var formData = new FormData();
            
            for (var i = 0; i < files.length; i++) {
                formData.append("files", files[i]);
            }
           
            fetch("/upload", {
                method: "POST",
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                console.log(data.message);
                
            })
            .catch(error => {
                console.error("Error:", error);
            });
        }

		if(files.length == 0 && $('.image-preview li').length != 0){
			fileNames = "${dto.img}";
		}
		
		$.ajax({
		      url: '/update_free', 
		      method: 'POST', 
		      data: {
		    	share_id:"${dto.share_id}",
		    	title: title,
		    	category: category,
		        location: address,
		        content: content,
		        img: fileNames
		      },
		      success: function(response) {
		        console.log(response);
		        alert("수정되었습니다.");
		      },
		      error: function(xhr, status, error) {
		        console.log(error);
		      }
		});
		
		location.href = "/free";
		setTimeout(() => {
			location.reload();
		}, 100);
	});
	
});
</script>
</head>
<body>

<%@ include file="../header.jsp" %>

 

<section class="board">
	<h1 id="top"><span>무료나눔</span></h1>
	
	<div class="border-content">
		<div class="board-box">

				<select id="category" value="${dto.category }">
					<option disabled selected>카테코리를 설정해주세요.</option>
					<option value="fashion">패션</option>
					<option value="beauty">뷰티</option>
					<option value="child">아동</option>
					<option value="life">생활</option>
					<option value="electron">전자</option>
					<option value="others">기타</option>
				</select>

				<div class="form-group">
					<label for="title" class="form-label">제목</label>
					<input type="text" id="title" class="input-text" value="${dto.title }"/>
				</div>
				
				<div id ="location_wrap" style="display:flex;">
					<div class="location"><button>위치 설정하기</button></div>
					<div class="location_text">${dto.location }</div>
				</div>
				<input type="file" class="real-upload" accept="image/*" required multiple>
				<div id="upload_wrap">
					<div class="upload"><button>사진 올리기</button></div>
										<div id="modal_wrap">
						<div class = "modal_location">
							<div class="map_wrap" style="width:60%;">
							
						    	<div id="map" style="width:100%;height:700px;position:relative;overflow:hidden;"></div>
						    	<div class="close">X</div>
						    	<div id="menu_wrap" class="bg_white">
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
					</div>
				</div>
				<input id="location_input">
				<ul class="image-preview"></ul>
				<div class="form-group">
					<label for="content" class="form-label">내용</label>
					<textarea id="editorText" rows="20" cols ="10" placeholder="내용을 입력해주세요"></textarea>
				</div>
				<div class="btn-box">
					<button id="register_btn">등록</button>
					<button id="update_btn">수정</button>	
					<button id="cancel_btn">취소</button>						
				</div>
		</div>
	</div>
</section>


<%@ include file="../footer.jsp" %>

</body>
</html>