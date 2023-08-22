<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/shareBoard/shareBoardList.css" />
<title>빌려주세요</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<jsp:include page="../header.jsp"/>
	
	<div id="layout">
		<div class="list">
			<main>
			<p id="boardName">빌려주세요</p>
			
			<div class="categoryWrap">
		        <div class="category">
		          <a class="${param.searchType1 == '*' ? 'on' : ''}" href="shareboardlist?page=1&searchType1=*${param.keyword ? '&keyword=' + param.keyword : ''}">
		          전체</a>
		        </div>			
		        <div class="category">
		          <a class="${param.searchType1 == '뷰티' ? 'on' : ''}" href="shareboardlist?page=1&searchType1=뷰티${param.keyword ? '&keyword=' + param.keyword : ''}">
		          뷰티</a>
		        </div>
		        <div class="category">
		          <a class="${param.searchType1 == '아동' ? 'on' : ''}" href="shareboardlist?page=1&searchType1=아동${param.keyword ? '&keyword=' + param.keyword : ''}">
		          아동</a>
		        </div>
		        <div class="category">
		          <a class="${param.searchType1 == '생활' ? 'on' : ''}" href="shareboardlist?page=1&searchType1=생활${param.keyword ? '&keyword=' + param.keyword : ''}">
		          생활</a>
		        </div>
		        <div class="category">
		          <a class="${param.searchType1 == '전자' ? 'on' : ''}" href="shareboardlist?page=1&searchType1=전자${param.keyword ? '&keyword=' + param.keyword : ''}">
		          전자</a>
		        </div>
		        <div class="category">
		          <a class="${param.searchType1 == '기타' ? 'on' : ''}" href="shareboardlist?page=1&searchType1=기타${param.keyword ? '&keyword=' + param.keyword : ''}">
		          기타</a>
		        </div>
		        	        		        
				<div class="searchBox">
					<button id="searchBtn">
						<img src="/img/Vector.png" alt="검색">
					</button>
					<c:choose>
						<c:when test="${param.keyword == '' || param.keyword eq null}">
							<input type="text" id="keyword" placeholder="제목검색">
						</c:when>
						<c:otherwise>
							<input type="text" id="keyword" value="${param.keyword}" />
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			
			
			<div class="listWrap">
				<table class="boardList">
					<tr>
						<td>번호</td>
						<td>작성자</td>
						<td>분류</td>
						<td>상품명</td>
						<td>제목</td>
						<td>거래여부</td>
						<td>작성일</td>
						<td>금액</td>
						<td>위치</td>
						<td>조회수</td>
					</tr>
					
					<c:if test="${empty response.list}">
						<tr>
							<td colspan="9" class="emptyMsg">
								<div>
									검색된 결과가 없습니다.<br> 검색어를 다시 입력해 주세요.
								</div>
							</td>
						</tr>
					</c:if>
										
					<c:forEach var="boardList" items="${response.list}">
							<tr>
								<td><a href="/sharedetail?share_id=${boardList.share_id}" style="text-decoration: none; color: inherit;">${boardList.share_id}</a></td>
								<td>${boardList.user_id}</td>
								<td>${boardList.category}</td>
								<td>${boardList.item}</td>
								<td><a href="/sharedetail?share_id=${boardList.share_id}" style="text-decoration: none; color: inherit;">${boardList.title}</a></td>
								<td>
								    <c:choose>
								        <c:when test="${boardList.is_shared eq false}">
								            거래중
								        </c:when>
								        <c:when test="${boardList.is_shared eq true}">
								            거래완료
								        </c:when>
								    </c:choose>
								</td>
								<td>${boardList.date}</td>
								<td>${boardList.price}원</td>
								<td>${boardList.location}</td>
								<td>${boardList.view_cnt}</td>
							</tr>	
					</c:forEach>
				</table>
				
				<div class="writingBtnWrap">
					<button class="writingBtn">글쓰기</button>
				</div>
			</div>
			<br>

			<div id="pagination">
				<c:if test="${fn:length(response.list) != 0}">
					<div class="pagefirst"
						<c:if test="${!response.pagination.existPrevPage}"> style="visibility: hidden;" </c:if>>
						<div class="prevArrow"></div>
						<div class="prevArrow" style="margin-left: -3px"></div>
					</div>
					<div class="prev" id="${response.pagination.startPage-1}"
						<c:if test="${!response.pagination.existPrevPage}"> style="visibility: hidden;" </c:if>>
						<div class="prevArrow"></div>
					</div>
		
					<c:choose>
						<c:when test="${searchdto.page eq null}">
							<c:forEach begin="1" end="${response.pagination.endPage}"
								varStatus="vs">
								<c:if test="${vs.index == 1}">
									<div class="pageNumber active">${vs.index}</div>
								</c:if>
								<c:if test="${vs.index != 1}">
									<div class="pageNumber">${vs.index}</div>
								</c:if>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<c:forEach begin="${response.pagination.startPage}"
								end="${response.pagination.endPage}" varStatus="vs">
								<c:if test="${vs.index == searchdto.page}">
									<div class="pageNumber active">${vs.index}</div>
								</c:if>
								<c:if test="${vs.index != searchdto.page}">
									<div class="pageNumber">${vs.index}</div>
								</c:if>
							</c:forEach>
						</c:otherwise>
					</c:choose>
		
					<div class="next" id="${response.pagination.endPage+1}"
						<c:if test="${!response.pagination.existNextPage}"> style="visibility: hidden;" </c:if>>
						<div class="nextArrow"></div>
					</div>
					<div class="pagelast" id="${response.pagination.totalPageCount}"
						<c:if test="${!response.pagination.existNextPage}"> style="visibility: hidden;" </c:if>>
						<div class="nextArrow"></div>
						<div class="nextArrow" style="margin-left: -6px"></div>
					</div>
				</c:if>
			</div>
			<!-- pagination -->				
				
			</main>
		</div>
	
	</div>

<script>
	//글쓰기 버튼
	$(document).ready(function() {
	    $(".writingBtn").click(function() {
	        window.location.href = "/writingform";
	    });
	});

	//검색버튼
	$("#searchBtn").on('click', function() {
		const queryparamsPage = {
			page: 1,
			keyword:$("#keyword").val()
		}
		location.href = location.pathname + '?' + new URLSearchParams(queryparamsPage).toString();
	});

	//숫자 페이징버튼 
	$(".pageNumber").on('click', function() {
		const queryparamsPage = {
			page: $(this).text(),
			keyword:$("#keyword").val()
		}
		location.href = location.pathname + '?' + new URLSearchParams(queryparamsPage).toString();
	});
	
	//첫페이지버튼 
	$(".pagefirst").on('click', function() {
		const queryparamsPage = {
			page: 1,
			keyword:$("#keyword").val()
		}
		location.href = location.pathname + '?' + new URLSearchParams(queryparamsPage).toString();
	});
	
	//이전페이지버튼
	$(".prev").on('click', function() {
		const queryparamsPage = {
	    	page: $(this).attr("id"),
			keyword:$("#keyword").val()
		}
		location.href = location.pathname + '?' + new URLSearchParams(queryparamsPage).toString();
	});
	
	//다음페이지버튼
	$(".next").on('click', function() {
		const queryparamsPage = {
			page: $(this).attr("id"),
			keyword:$("#keyword").val()
		}
		location.href = location.pathname + '?' + new URLSearchParams(queryparamsPage).toString();
	});
	
	//마지막페이지버튼
	$(".pagelast").on('click', function() {
		const queryparamsPage = {
			page: $(this).attr("id"),
			keyword:$("#keyword").val()
		}
		location.href = location.pathname + '?' + new URLSearchParams(queryparamsPage).toString();
	});
</script>	


<jsp:include page="../footer.jsp"/>
</body>
</html>