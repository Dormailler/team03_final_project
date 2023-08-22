<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>쪽지 내용</title>
</head>
<body>
    <h1>쪽지 내용</h1>
    
    <c:forEach items="${clist}" var="message">
        <div>
            <p><strong>메세지 ID:</strong> ${message.no}</p>
            <p><strong>보낸 사람:</strong> ${message.send_nick}</p>
            <p><strong>받는 사람:</strong> ${message.recv_nick}</p>
            <p><strong>내용:</strong> ${message.content}</p>
            <p><strong>전송 시간:</strong> ${message.send_time}</p>
        </div>
    </c:forEach>
</body>
</html>