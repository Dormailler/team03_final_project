<%@page import="ch.qos.logback.core.recovery.ResilientSyslogOutputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
	var category = ".${category}";
	$(category).addClass("active");
	$('#write_btn').on('click',function(e){
		if("${session_id}" == ""){
			e.preventDefault();
			alert("로그인 후 이용가능합니다.");
			location.href = "/login";
		}
	});
	
	function searchSubmt(){
		var category = "${category}";
		var text = $('#search').val();
		var select = $('#search_select').val();
		
		location.href="/free?category=" + category + "&text=" + text + "&select=" + select;
	}
	$('#search_btn').on('click',searchSubmt);
 	$('#search').on("keydown", function(e) {
        if (e.key === "Enter") {
        	searchSubmt();
        	
        }
 	});
 	
 	 var dateElements = document.querySelectorAll(".date");
	 dateElements.forEach(function(element) {
	     var fullDate = element.textContent;
	     var trimmedDate = fullDate.substring(0, 11);
	     element.textContent = trimmedDate;
    	});
});
</script>

</head>
<body>
<%@ include file="../header.jsp" %>
<h1 class="top">무료나눔</h1>
<div id="search_wrap" action="/free_search">
	<select id="search_select">
		<option value="title">제목</option>
		<option value="user_id">작성자</option>
		<option value="location">위치</option>
	</select>
	<input type = "text" id="search" placeholder="검색어를 입력해주세요.">
	<img id="search_btn" src="/img/search.svg" alt="search_btn">
</div>
<div id="nav_wrap">
	<ul id="nav_ul">
		<li class="fashion"><a href="free?category=fashion" class="">패션</a></li>
		<li class="beauty"><a href="free?category=beauty" class="">뷰티</a></li>
		<li class="child"><a href="free?category=child" class="">아동</a></li>
		<li class="life"><a href="free?category=life" class="">생활</a></li>
		<li class="electron"><a href="free?category=electron" class="">전자</a></li>
		<li class="book"><a href="free?category=others" class="">기타</a></li>
	</ul>
</div>
<div id="content_wrap">
	<table>
		<tr>
			<c:forEach items="${freelist}" var="dto" begin="0" end="3">
				<td>
					<a href="free/${dto.share_id}"><img referrerpolicy="no-referrer" src="/save/${dto.img}" alt="상품이미지" class="img" onerror="this.src='${dto.img}';"/></a>
					<div class="detail_wrap">
						<h4 class="title"><a href="free/${dto.share_id}">${dto.title}</a></h4>
	                    <h6><a href="" class="user">${dto.name}</a></h6>
	                    <h6>${dto.location}</h6>
	                    <h6 class="content"><span class="date">${dto.date}</span></h6> 
	                    <c:if test="${dto.is_shared}">
	                    	<div class = "shared_wrap">거래완료</div>
	                    </c:if>  
                    </div>
				</td>
			</c:forEach>
		</tr>
		<tr>
			<c:forEach items="${freelist}" var="dto" begin="4" end="7">
				<td>
					<a href="free/${dto.share_id}"><img referrerpolicy="no-referrer" src="/save/${dto.img}" alt="상품이미지" class="img" onerror="this.src='${dto.img}';" /></a>
					<div class="detail_wrap">
						<h4 class="title"><a href="free/${dto.share_id}">${dto.title}</a></h4>
	                    <h6><a href="" class="user">${dto.name}</a></h6>
	                    <h6>${dto.location}</h6>
	                    <h6 class="content"><span class="date">${dto.date}</span></h6> 
	                    <c:if test="${dto.is_shared}">
	                    	<div class = "shared_wrap">거래완료</div>
	                    </c:if> 
                    </div>
				</td>
			</c:forEach>
		</tr>
	</table>
</div>
<div id="bottom">
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
		<span class="page"><a href="/free?category=${category}&page=<%=i %>&text=${text}&select=${select}" id="page<%=i%>"> <%=i %>  </a></span>
	<%  }
	%>
</div>
<div id="write_wrap"><button id="write"><a href="/freew" id="write_btn">글쓰기</a></button></div>
</div>
<%@ include file="../footer.jsp" %>
</body>
</html>