<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="stylesheet" href="/css/commList.css">
<title>게시글 조회</title>
</head>
<body>
	<div id="wrap">
		<header id="header">
			<%@ include file="../views/header.jsp" %>
		</header>
		<div id="container">
			<section class="board">
				<h1>게시글 조회</h1>
				<div class="border-content">
					<div class="board-box">
						<div class="border-header">
							<div class="list-info">총 게시글 내역, 페이이지 넘버링</div>
							<div class="serch-box">검색 필터 폼 위치</div>
						</div>
						<div class="border-body">
							<ul>
								<li class="list-header">
									<strong class="no">번호</strong>
									<strong class="subject">제목</strong>
									<strong class="writer">작성자</strong>
									<strong class="regdate">작성일</strong>
								</li>
								<c:if test="${empty commList }"><div class="emptyList">게시글이 없습니다.</div></c:if>
								<c:forEach items="${commList }" var="list">>
									<li class="list-body">
										<p class="no">${list.no }</p>
										<p class="title text-ellipsis"><a href="#">${list.title }</a></p>
										<p class="writer">${list.writer }</p>
										<p class="regdate">
											<!-- 날짜 yyyy.MM.dd 형식으로 포맷 -->
											<fmt:formatDate var="setRegdate" value="${list.regdate }" pattern="yyyy.MM.dd" />
											${setRegdate }
										</p>
									</li>
								</c:forEach>
							</ul>
							<div class="btn-box">
								<a href="/commWrite"><input type="button" value="글쓰기" class="form-btn"></a>
							</div>
							<div class="page-box">페이지 위치</div>
						</div>
					</div>
				</div>
			</section>
		</div>
		<footer id="footer">
			<%@ include file="../views/footer.jsp" %>
		</footer>
	</div>
</body>
</html>