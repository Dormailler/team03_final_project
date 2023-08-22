<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/commList.css">
<link rel="stylesheet" href="/css/bootsrtap.min.css">
<title>게시글 조회</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    //로그인 정보 없으면 글쓰기 X
    $('.form-btn').click(function() {
        var isLoggedIn = <%= session.getAttribute("session_id") != null %>;
        
        if (isLoggedIn) {
            // 로그인 상태인 경우, /help 페이지로 이동
            window.location.href = '/commWrite';
        } else {
            // 로그인 상태가 아닌 경우, 얼럿 메시지 표시
            alert('로그인 후에 글쓰기가 가능합니다.');
            window.location.href = '/login';
        }
    });
});
</script>
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
							<div class="serch-box">
								<form action="/commList${CommPagination.criteria.pageUri(criteria.page, criteria.keyword) }">
									<select name="option" class="form-select">
										<option value="all"<c:out value="${ CommPagination.criteria.option eq 'all' ? 'selected' : '' }"/>>전체</option>
										<option value="title"<c:out value="${ CommPagination.criteria.option eq 'title' ? 'selected' : '' }"/>>제목</option>
										<option value="content"<c:out value="${ CommPagination.criteria.option eq 'content' ? 'selected' : '' }"/>>내용</option>
										<option value="writer"<c:out value="${ CommPagination.criteria.option eq 'writer' ? 'selected' : '' }"/>>작성자</option>
									</select>
									<input type="text" name="keyword" class="input-text" value="<c:out value="${CommPagination.criteria.keyword }"/>">
									<input type="submit" value="검색" class="form-btn custom-btn">
								</form>
							</div>
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
								<c:forEach items="${commList }" var="list">
									<li class="list-body">
										<p class="no">${list.no }</p>
										<p class="title text-ellipsis"><a href="/commView?no=${list.no }">${list.title }</a></p>
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
								<input type="button" value="글쓰기" class="form-btn"></a>
							</div>
							<div class="page-box">
								<ul class="page">
									<c:if test="${CommPagination.prev }">
									<li class="privious page-btn">
										<a href="/commList${CommPagination.criteria.pageUri(CommPagination.start-1) }" class="page-link">이전</a>
									</li>
									</c:if>
									<c:forEach var="i" begin="${CommPagination.start }" end="${CommPagination.end }">
										<li class="page-btn ${CommPagination.criteria.page == i ? 'active' : '' }">
											<c:choose>
												<c:when test="${CommPagination.criteria.keyword == null }">
													<a href="<c:url value='/commList${CommPagination.criteria.pageUri(i) }'/>" class="page-link">${i }</a>
												</c:when>
												<c:otherwise>
													<a href="<c:url value='/commList${CommPagination.criteria.pageUri(i, CommPagination.criteria.keyword) }'/>" class="page-link">${i }</a>
												</c:otherwise>
											</c:choose>
										</li>
									</c:forEach>
									<c:if test="${CommPagination.next }">
									<li class="next page-btn">
										<a href="/commList${CommPagination.criteria.pageUri(CommPagination.end+1) }" class="page-link">다음</a>
									</li>
									</c:if>
								</ul>
								<form action="/commList" id="page-form">
									<input type="hidden" name="page" value="${CommPagination.criteria.page }">
									<input type="hidden" name="amount" value="${CommPagination.criteria.amount }">
									<input type="hidden" name="option" value="<c:out value='${CommPagination.criteria.option }'/>">
									<input type="hidden" name="keyword" value="<c:out value='${CommPagination.criteria.keyword }'/>">
								</form>
							</div>
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