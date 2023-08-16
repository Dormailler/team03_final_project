<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/js/jquery-3.6.4.min.js"></script>
<link rel="stylesheet" href="/css/free_detail.css">
<script>
$(document).ready(function(){
	
});
</script>
<style type="text/css">
#top{
	margin-top:50px;
}
#full_wrap{
	width:1440px;
	margin:0 auto;
}
#contents_wrap{
	width:90%;
	margin:0 auto;
	margin-top: 100px;
	height:1000px;
}

#detail_wrap{
	width : 52%;
	float : left;
}
#location,#img{
	width:305px;
	height:400px;
	position: relative;
    float: left;
}
img{
	width:305px;
	height:340px;
}
td:first-child{
	width:160px;
}
#content_box{
	padding-top:50px;
	width:1300px;
	height:400px;
	border:1px solid #000D84;
	margin: 0 auto;
	clear:both;
	white-space: pre-line;
	text-align:center;
}
</style>
</head>
<body>
<div id="full_wrap">
<%@ include file="../header.jsp" %>
<h1 id="top">무료나눔</h1>
<div id="contents_wrap">
	<div id="detail_wrap">
		<table>
			<tr>
				<td><h4 id="user">작성자</h4></td>
				<td><h4>${dto.user_id }</h4></td>
			</tr>
			<tr>
				<td><h4>작성일</h4></td>
				<td><h4>${dto.date }</h4></td>
			</tr>
			<tr>
				<td><h4>분류</h4></td>
				<td><h4>${dto.category }</h4></td>
			</tr>
			<tr>
				<td><h4>거래여부</h4></td>
				<td><h4>${dto.is_shared}</h4></td>
			</tr>
		</table>
	</div>
	<div id="location"><h3>위치 </h3><h3>${dto.location }</h3> </div>
	<div id="img"><h3>사진 <img referrerpolicy="no-referrer" src="${dto.img }"/></h3></div>
	<div id="content_box">${dto.content }</div>
</div>



<%@ include file="../footer.jsp" %>
</div>
</body>
</html>