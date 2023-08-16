<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="stylesheet" href="/css/commWrite.css">
<title>게시글 작성</title>
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
						<form action="/commWrite" method="post" id="board-form">
							<div class="form-group">
								<label for="title" class="form-label">제목</label>
								<input type="text" name="title" class="input-text">
							</div>
							<div class="form-group">
								<label for="name" class="form-label">작성자</label>
								<input type="text" name="writer" class="input-text">
							</div>
							<div class="form-group">
								<label for="content" class="form-label">내용</label>
								<textarea name="content" class="form-textarea" wrap="hard"></textarea>
							</div>
							<div class="btn-box">
								<input type="submit" value="저장" class="form-btn">
								<input type="button" value="취소" class="form-btn cancle-btn">							
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