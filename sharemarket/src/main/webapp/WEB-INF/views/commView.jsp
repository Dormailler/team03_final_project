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
<title>게시글 내용</title>
</head>
<body>
	<div id="wrap">
		<header id="header">
			<%@ include file="../views/header.jsp" %>
		</header>
		<div id="container">
			<section class="board">
				<h1>게시글 작성</h1>
				<div class="border-content">
					<div class="board-box">
						<div class="view-box">
							<form>
								<ul>
									<li class="subject">
										<strong>${dto.title }</strong>
									</li>
									<li class="writer">
										<div class="detail-title">작성자</div>
										<div class="detail-text">${dto.writer }</div>
									</li>
									<li class="regdate">
										<div class="detail-title">작성일</div>
										<div class="detail-text">
											<!-- 날짜 yyyy.MM.dd 형식으로 포맷 -->
											<fmt:formatDate var="setRegdate" value="${dto.regdate }" pattern="yyyy.MM.dd" />
											${setRegdate }
										</div>
									</li>
									<li class="content">
										<div class="detail-content">
											${dto.content }
										</div>
									</li>
								</ul>
								<div class="btn-box right-box">
									<a href="/modify?no=${dto.no }"><input type="button" value="수정" class="custom-btn"></a>
									<input type="submit" value="삭제" class="custom-btn">							
								</div>
							</form>
						</div>
						<div class="move-box">
							<ul>
								<li>
									<strong class="privious list-title">이전글</strong>
									<a href="#" class="list-text text-ellipsis">이전글 제목</a>
								</li>
								<li>
									<strong class="next list-title">다음글</strong>
									<a href="#" class="list-text text-ellipsis">다음글 제목</a>
								</li>
							</ul>
						</div>
						<div class="btn-box right-box">
							<button class="form-btn">목록으로</button>
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