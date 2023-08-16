<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="js/jquery-3.6.4.min.js"></script>
<link rel="stylesheet" href="/css/free.css">
<script src='js/free.js'></script>
<script>
$(document).ready(function(){
	var page = "#page" + "${page}";
	$(page).css("color","#1B5DDE");
	var category = "${category}";
	
});
</script>

</head>
<body>
<%@ include file="../header.jsp" %>
<h1 class="top">무료나눔</h1>
<div id="search_wrap">
	<input type = "text" id="search" placeholder= "검색어를 입력해주세요.">
</div>
<div id="nav_wrap">
	<ul id="nav_ul">
		<a href="free?category=패션" class=""><li class="nav active">패션</li></a>
		<a href="free?category=뷰티" class=""><li class="nav">뷰티</li></a>
		<a href="free?category=아동" class=""><li class="nav">아동</li></a>
		<a href="free?category=생활" class=""><li class="nav">생활</li></a>
		<a href="free?category=전자" class=""><li class="nav">전자</li></a>
		<a href="free?category=도서" class=""><li class="nav">도서</li></a>
		<a href="free?category=취미" class=""><li class="nav">취미</li></a>
	</ul>
</div>
<div id="content_wrap">
	<table>
		<tr>
			<c:forEach items="${freelist}" var="dto" begin="0" end="3">
				<td>
					<a href="free/${dto.share_id}"><img referrerpolicy="no-referrer" src="${dto.img}" alt="상품이미지" class="img"></a>
					<div class="detail_wrap">
						<h4 class="title"><a href="free/${dto.share_id}">${dto.title}</a></h4>
	                    <h6><a href="" class="user">${dto.user_id}</a> ${dto.location}</h6>
	                    <h6 class="content">댓글 ${dto.comment}</h6>
                    </div>
				</td>
			</c:forEach>
		</tr>
		<tr>
			<c:forEach items="${freelist}" var="dto" begin="4" end="7">
				<td>
					<a href="free/${dto.share_id}"><img referrerpolicy="no-referrer" src="${dto.img}" alt="상품이미지" class="img"></a>
					<div class="detail_wrap">
						<h4 class="title"><a href="free/${dto.share_id}">${dto.title}</a></h4>
	                    <h6><a href="" class="user">${dto.user_id}</a> ${dto.location}</h6>
	                    <h6 class="content">댓글 ${dto.comment }</h6>
                    </div>	
				</td>
			</c:forEach>
		</tr>
	</table>
</div>

<div id="page_wrap">
	
	<%
	  
	  int totalBoard = (Integer)request.getAttribute("totalBoard");
	  int totalPage = 0;
	  if(totalBoard % 8 == 0){
		  totalPage = totalBoard / 8;
	  }
	  else{
		  totalPage = totalBoard / 8 + 1;
	  }
	
	  for(int i = 1; i <= totalPage; i++){
		  %>
		<span class="page"><a href="free?page=<%=i %>" id="page<%=i%>"> <%=i %>  </a></span>
	<%  }
	%>
</div>
<%@ include file="../footer.jsp" %>
</body>
</html>