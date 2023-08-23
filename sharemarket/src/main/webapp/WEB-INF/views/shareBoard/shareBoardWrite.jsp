<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/shareBoard/shareBoardWrite.css" />
<title>글쓰기</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="/SmartEditor/js/service/HuskyEZCreator.js"></script>
</head>
<body>
<jsp:include page="../header.jsp"/>

	<div id="layout">
		<div class="boardWriting">
			<main>
			<div id="header">
				<div id="boardName">
					<p>공유 글쓰기</p>
				</div>
			</div>
			
			<div class="contents">
				<div class="userInfoAside">
					<p>이름</p>
					<p>분류</p>
					<p>종류</p>
					<p>공유</p>
					<p>가격</p>
					<p>제목</p>
				</div>
				<div class="userInfo">
					<input type="text" id="userId" name="user_id" value="${sessionScope.user_id}" readonly />
					<input type="text" id="category" name="category" />
					<label><input type="radio" name="type" value="빌려주세요">빌려주세요</label>
					<label><input type="radio" name="type" value="빌려드려요">빌려드려요</label>
					<input type="text" id="item" name="item" />
					<input type="text" id="price" name="price" />
					<input type="text" id="title" name="title" />
				</div>
				<div class="locationAside">
					<p>위치</p>
				</div>
				<div class="location">
					<input type="text" id="location" name="location" />
				</div>
<!--				
				<div class="imgAside">
					<p>사진</p>
				</div>
				<div class="img">
					<input type="file" class="real-upload" accept="image/*" name="img" >
					<div class="upload"></div>
					<ul class="image-preview"></ul>
				</div>
-->				
				<div class="content">
					<div><textarea id="boardContent"></textarea></div>
				</div>
				<div class="btnWrap">
					<button id="writeBtn">작성하기</button>
				</div>
			</div>
		</main>
		</div>
	</div>
<script>
$(document).ready(function() {
    var oEditors = [];
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "boardContent", 
        sSkinURI: "SmartEditor/SmartEditor2Skin.html", 
        fCreator: "createSEditor2",
        htParams: {
            // 툴바 사용 여부 (true: 사용 / false: 사용하지 않음)
            bUseToolbar: true,
            // 입력창 크기 조절바 사용 여부 (true: 사용 / false: 사용하지 않음)
            bUseVerticalResizer: false,
            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true: 사용 / false: 사용하지 않음)
            bUseModeChanger: false,
            // 페이지 out alert 삭제
            fOnBeforeUnload : function(){}
        }
    });
    
	$("#writeBtn").on('click', function(e) {
		oEditors.getById["boardContent"].exec("UPDATE_CONTENTS_FIELD", []);
		var formData = new FormData();
		var content = oEditors.getById["boardContent"].getIR();
		
		formData.append("user_id", '${sessionScope.user_id}');
		formData.append("category", $("#category").val());
		formData.append("item", $("#item").val());
		formData.append("price", $("#price").val());
		formData.append("title", $("#title").val());
		formData.append("location", $("#location").val());
		formData.append("content", content);
	
		// AJAX 요청 보내기
		$.ajax({
		  url: "/shareboardwrite", 
		  type: "POST",
		  data: formData, 
		  processData: false,
		  contentType: false, 
		  success: function(response) {
		    alert("작성이 완료되었습니다");
		    location.href = "/shareboardlist";
		  },
		  error: function() {
		  }
		});
	});
});
</script>
	<jsp:include page="../footer.jsp"/>
</body>
</html>