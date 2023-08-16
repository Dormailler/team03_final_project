<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="stylesheet" href="/css/commWrite.css">
<title>게시글 수정</title>
</head>
<body>
	<div id="wrap">
		<header id="header">
			<%@ include file="../views/header.jsp" %>
		</header>
		<div id="container">
			<section class="board">
				<h1>게시글 내용</h1>
				<div class="border-content">
					<div class="board-box">
						<form action="/commModify" method="post" id="modify-form">
							<div class="view-box">
								<input type="hidden" name="no" value="${dto.no }">
								<ul>
									<li class="subject">
										<strong>
											<input type="text" name="title" class="modify-text" value="${dto.title }" />
										</strong>
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
									<li class="updatedate">
										<div class="detail-title">수정일</div>
										<div class="detail-text">
											<!-- 날짜 yyyy.MM.dd 형식으로 포맷 -->
											<fmt:formatDate var="setUpdatedate" value="${dto.updatedate }" pattern="yyyy.MM.dd" />
											${setUpdatedate }
										</div>
									</li>
									<li class="content">
										<div class="detail-content">
											<textarea name="content" class="modify-textarea resize"
												wrap="hard" autofocus>${dto.content }</textarea>
										</div>
									</li>
								</ul>
							</div>
							<div class="btn-box">
								<input type="submit" value="수정하기" class="form-btn">
								<input type="button" value="취소" class="form-btn cancle-btn back">							
							</div>
						</form>
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