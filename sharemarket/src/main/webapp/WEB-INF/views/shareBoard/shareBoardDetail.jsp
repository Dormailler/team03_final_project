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
					<p>${boardDetail.location}</p>
				</div>
				<!-- 
				<div class="imgAside">
					<p>사진</p>
				</div>
				<div class="img">
					<p><img src="${boardDetail.img}" /></p>
				</div>
				 -->
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