<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/commWrite.css">
<link rel="stylesheet" href="/css/bootsrtap.min.css">
<title>게시글 작성</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
// 세션에 저장된 아이디 값을 가져와서 input 요소의 value에 설정
document.addEventListener('DOMContentLoaded', function() {
    var userIdInput = document.getElementById('user_id_input');
    var userNickInput = document.getElementById('user_nick_input');
    var sessionUserId = '<%= session.getAttribute("session_id") %>'; // JSP 코드로 세션 아이디 가져오기
    var sessionUserNick = '<%= session.getAttribute("nick") %>'; // JSP 코드로 세션 닉네임 가져오기

    userIdInput.value = sessionUserId;
    userNickInput.value = sessionUserNick;
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
								<input type="text" name="writer" class="input-text" id="user_nick_input" value="" readonly>
								<input type="hidden" name="user_id" id="user_id_input" value="">
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