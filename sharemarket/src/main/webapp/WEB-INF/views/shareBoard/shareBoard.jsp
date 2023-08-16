<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/shareBoard.css" />
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<jsp:include page="../header.jsp"/>
	
	<div id="layout">
		<div class="list">
			<main>
			<p id="boardName">빌려주세요</p>
			
			<div class="btnWrap">
				<button>전체</button>
				<button>뷰티</button>
				<button>아동</button>
				<button>생활</button>
				<button>전자</button>
				<button>기타</button>
			</div>
			
			<div class="listWrap">
				<table class="boardList">
					<tr>
						<td>번호</td>
						<td>작성자</td>
						<td>분류</td>
						<td>상품명</td>
						<td>거래여부</td>
						<td>작성일</td>
						<td>금액</td>
						<td>위치</td>
						<td>조회수</td>
						<td>좋아요</td>
					</tr>
					<c:forEach var="boardList" items="${boardList}" begin="0" end="9">
						<tr>
							<td>${boardList.share_id}</td>
							<td>${boardList.user_id}</td>
							<td>${boardList.category}</td>
							<td>${boardList.item}</td>
							<td>${boardList.is_shared}</td>
							<td>${boardList.date}</td>
							<td>${boardList.price}원</td>
							<td>${boardList.location}</td>
							<td>${boardList.likes}</td>
							<td>5</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			
			<div id="pagenation">
			
			</div>
			</main>
		</div>
	
	
	</div>

<jsp:include page="../footer.jsp"/>
</body>
</html>