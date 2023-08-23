<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>게시글 내용</title>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/commView.css">
<link rel="stylesheet" href="/css/bootsrtap.min.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
var replyService = (function() {
	function write(reply, callback, error) {
		console.log("댓글 입력");
		
		$.ajax({
			type : 'post',
			url : '/write',
			data : JSON.stringify(reply),
			contentType : "application/json; charset = utf-8",
			success : function(result, status, xhr) {
				if (callback) callback(result);
			},
			error : function(xhr, status, err) {
				if (error) error(err);
			}
		})
	}
	return {
		write : write
	}
})();

function confirmEdit(user_id) {
    var sessionUserId = "${sessionScope.session_id}"; // 세션에 저장된 사용자 아이디
    if (sessionUserId === user_id) {
        return true; // 수정 허용
    } else {
        alert("본인이 작성한 게시글만 수정이 가능합니다.");
        return false; // 수정 불허
    }
}

function confirmDelete(user_id) {
    var sessionUserId = "${sessionScope.session_id}"; // 세션에 저장된 사용자 아이디
    if (sessionUserId === user_id) {
        return confirm("정말로 삭제하시겠습니까?"); // 삭제 확인 얼럿 띄우기
    } else {
        alert("본인이 작성한 게시글만 삭제가 가능합니다.");
        return false; // 삭제 불허
    }
}

window.onload = function() {
	var replyForm = document.querySelector("#reply-form");
	var no = replyForm.querySelector("input[name='no']").value;
	var replyBtn = replyForm.querySelector("#reply-btn");
	
	replyBtn.onclick = function() {
		//event.preventDefault();
		
		var reply = replyForm.querySelector('textarea[name="reply-text"]').value;
		var replier = replyFor.querySelector('input[name="replier"]').value;
		replyService.write({
			reply : reply, replier : replier, no : no
		}, function(result) {
			console.log(result);
		});
	}
}
</script>
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
						<div class="view-box">
							<form>
								<ul>
									<li class="subject">
										<strong>${commView.title }</strong>
									</li>
									<li class="writer">
										<div class="detail-title">작성자</div>
										<div class="detail-text">${commView.writer }</div>
									</li>
									<li class="regdate">
										<div class="detail-title">작성일</div>
										<div class="detail-text">
											<!-- 날짜 yyyy.MM.dd 형식으로 포맷 -->
											<fmt:formatDate var="setRegdate" value="${commView.regdate }" pattern="yyyy.MM.dd" />
											${setRegdate }
										</div>
									</li>
									<li class="content">
										<div class="detail-content">
											${commView.content }
										</div>
									</li>
								</ul>
								<div class="btn-box right-box">
									<a href="/commModify?no=${commView.no }" onclick="return confirmEdit('${commView.user_id }');">
									<input type="button" value="수정" class="custom-btn"></a>
									<a href="/commRemove?no=${commView.no }" onclick="return confirmDelete('${commView.user_id }');">
									<input type="button" value="삭제" class="custom-btn"></a>						
								</div>
							</form>
						</div>
						<!-- <div class="reply-box">
							<h3>댓글</h3>
							<form id="reply-form">
								<input type="hidden" name="no" value="<c:out value='${commView.no }'/>">
								<label for="replier"></label>
								<input type="text" name="replier">
								<textarea name="reply-text" wrap="hard"></textarea>
								<input type="submit" value="입력" id="reply-btn">
							</form>
						</div>
						<div class="reply-list">
						    <h3>댓글 목록</h3>
						    <ul>
						        <c:forEach var="comment" items="${comments}">
						            <li>${comment.replier}님의 댓글: ${comment.replyText}</li>
						        </c:forEach>
						    </ul>
						</div> -->
						<!-- <div class="commentWrap">
						    <div>
						        <c:forEach var="comment" items="${commentList}">
						            <div>
						            	<p>${comment.cno }</p>
						                <p>${comment.name}</p>
						                <p>${comment.date}</p>
						                <p>${comment.comment}</p>
						            </div>
						        </c:forEach>
						    </div>
						</div> -->
						<div class="move-box">
							<ul>
								<c:if test="${prev != null }">
									<li class="pre">
										<strong class="privious list-title">이전글</strong>
										<a href="/commView?no=${prev.no }" class="list-text text-ellipsis">${prev.title }</a>
									</li>
								</c:if>
								<c:if test="${next != null }">
									<li>
										<strong class="next list-title">다음글</strong>
										<a href="/commView?no=${next.no }" class="list-text text-ellipsis">${next.title }</a>
									</li>
								</c:if>
							</ul>
						</div>
						<div class="btn-box right-box">
							<a href="/commList"><input type="button" value="목록으로" class="form-btn"></a>
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