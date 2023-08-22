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
<script>
$(document).ready(function(){
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
        },
        fOnAppLoad: function () {
            // 스마트 에디터가 로드되면 실행할 코드 추가
            oEditors.getById["boardContent"].exec("UPDATE_CONTENTS_FIELD", []);
        }
    });
});    
</script>

	<div id="layout">
		<div class="boardWriting">
			<main>
			<div id="header">
				<p id="boardName">빌려주세요</p>
			</div>
			
			<div class="contents">
				<div class="userInfoAside">
					<p>이름</p>
					<p>분류</p>
					<p>종류</p>
					<p>제목</p>
				</div>
				<div class="userInfo">
					<input type="text" id="userId" value="${sessionScope.user_id}" readonly />
					<input type="text" id="category" />
					<input type="text" id="item" />
					<input type="text" id="title" />
				</div>
				<div class="locationAside">
					<p>위치</p>
				</div>
				<div class="location">
					<p></p>
				</div>
				<div class="imgAside">
					<p>사진</p>
				</div>
				<div class="img">
					<p><img src="" /></p>
				</div>
				<div class="content">
					<div><textarea id="boardContent" name="boardContent"></textarea></div>
				</div>
				<div class="btnWrap">
					<button>작성하기</button>
				</div>
			</div>
		</main>
		</div>
	</div>

	<jsp:include page="../footer.jsp"/>
</body>
</html>