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
				<p id="boardName">빌려주세요</p>
				<p>조회수 ${boardDetail.view_cnt}</p>
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
				<div class="imgAside">
					<p>사진</p>
				</div>
				<div class="img">
					<p><img src="${boardDetail.img}" /></p>
				</div>
				<div class="text">
					<div>${boardDetail.content}</div>
				</div>
				<div class="btnWrap">
					<button>연락하기</button>
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

<jsp:include page="../footer.jsp"/>
</body>
</html>