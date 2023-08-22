<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>메세지 실</title>
    <style>
       body {
    display: flex;
    flex-direction: column; /* 본문을 세로 방향으로 배치 */
    justify-content: space-between; /* 본문 내용을 위 아래에 공간을 분배하여 배치 */
    align-items: center;
    min-height: 100vh; /* 최소 높이를 100vh로 설정하여 헤더와 푸터 사이의 공간을 확보 */
    font-family: Arial, sans-serif;
		}

.success-message {
    text-align: center;
    padding: 20px;
    background-color: #e6f7ff;
    border: 1px solid #b3e5fc;
    border-radius: 5px;
    margin-top: 20px;
    margin-bottom: 20px;
}
    </style>
</head>
<body>
<%@ include file="../header.jsp" %>
    <div class="success-message">
        <h2>메세지 전송에 실패하였습니다.</h2>
        <h2>정보를 다시 확인해주세요.</h2>
    </div>
<%@ include file="../footer.jsp" %>
</body>
</html>
