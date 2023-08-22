<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/helplist.css">
<link rel="stylesheet" href="/css/bootsrtap.min.css">
<title>1:1 문의 내역</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    // 초기에 내용 숨기기
    $('.table_hide').hide();
    
    // 테이블 제목 클릭 시 해당 내용 보여주기/숨기기
    $('.table_show').click(function() {
        var content = $(this).next("tr.table_hide");
        if (content.is(":visible")) {
            content.slideUp();
        } else {
            content.slideDown();
        }
    });
    
    //로그인 정보 없으면 글쓰기 X
    $('#helplist_Btn button').click(function() {
        var isLoggedIn = <%= session.getAttribute("session_id") != null %>;
        
        if (isLoggedIn) {
            // 로그인 상태인 경우, /help 페이지로 이동
            window.location.href = '/help';
        } else {
            // 로그인 상태가 아닌 경우, 얼럿 메시지 표시
            alert('로그인 후에 문의가 가능합니다.');
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
		<div id="content">
				<h1>1:1 문의 내역</h1>
			<div id="helplist">
				<table id="helplist_table">
					<tr>
						<th>문의 유형</th>
						<th>1:1 문의 제목</th>
						<th>답변 여부</th>
						<th>작성일</th>
					</tr>
					<c:forEach items="${helplist}" var="list">
						<tr class="table_show">
							<td class="helplist_table_td" id="h_type">${list.h_type}</td>
							<c:choose>
								<c:when test="${list.h_answer eq '0' }">
									<td class="h_title">Q. ${list.h_title }</td>
									<td class="helplist_table_td">N</td>
								</c:when>
								<c:otherwise>
									<td class="h_title">Q. $.{list.h_title} ↓ 답변 보기
									<td class="helplist_table_td">Y</td>
								</c:otherwise>
							</c:choose>
							<td class="helplist_table_td" id="h_date">
								<fmt:parseDate value="${list.h_regdate }" var="dateValue" pattern="yyyy-MM-dd HH:mm:ss" />
								<fmt:formatDate value="${dateValue }" pattern="yyyy.MM.dd" />
							</td>
						</tr>
						<tr class="table_hide">
							<c:choose>
								<c:when test="${list.h_answer eq '0' }">
									<td colspan="4" class="h_title">${list.h_content }</td>
								</c:when>
								<c:otherwise>
									<td colspan="4" class="h_title">1:1 문의내역
									<hr>
										<div class="table_answer">
											<div>A. 1:1 문의 내역 답변</div>
												<div>답변일 :
													1:1 문의 답변 날짜
												</div>
										</div>
									</td>
								</c:otherwise>
							</c:choose>
						</tr>
					</c:forEach>
				</table>
				<div id="helplist_Btn">
					<button>1:1 문의 바로가기</button>
				</div>
				<div id="paging">
				    <div>
				        <c:if test="${paging.prev }">
				            <a href="/helplist?pageNum=${paging.startPage-5 }&amount=${paging.cri.amount}">이전</a>
				        </c:if>
				        <c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="num">
				            <c:choose>
				                <c:when test="${num == paging.cri.pageNum}">
				                    <a href="/helplist?pageNum=${num }&amount=${paging.cri.amount }" class="active">${num }</a>
				                </c:when>
				                <c:otherwise>
				                    <a href="/helplist?pageNum=${num }&amount=${paging.cri.amount }">${num }</a>
				                </c:otherwise>
				            </c:choose>
				        </c:forEach>
				        <c:if test="${paging.next }">
				            <a href="/helplist?pageNum=${paging.startPage+5 }&amount=${paging.cri.amount}">다음</a>
				        </c:if>
				    </div>
				</div>
			</div>
		</div>
		<footer id="footer">
			<%@ include file="../views/footer.jsp" %>
		</footer>
	</div>
</body>
</html>