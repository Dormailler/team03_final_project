<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>메세지 내용 목록</title>
</head>
<body>
    <h1>메세지 내용 목록</h1>
    
    <table border="1">
        <thead>
            <tr>
                <th>메세지 ID</th>
                <th>보낸 사람</th>
                <th>받는 사람</th>
                <th>내용</th>
                <th>전송 시간</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${clist}" var="message">
                <tr>
                    <td>${message.no}</td>
                    <td>${message.send_nick}</td>
                    <td>${message.recv_nick}</td>
                    <td>
					<td><a href="<c:url value="/viewMessage?messageId=${message.no}"/>" target="_blank">${message.content}</a></td>
                    </td>
                    <td>${message.send_time}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <%@ include file="../footer.jsp" %>

    <script>
        function openMessagePopup(messageId) {
            var url = "/message_content_popup.do?no=" + messageId;
            var width = 500;
            var height = 400;
            var left = (window.innerWidth - width) / 2;
            var top = (window.innerHeight - height) / 2;
    
            window.open(url, "_blank", "width=" + width + ", height=" + height + ", left=" + left + ", top=" + top);
        }
    </script>
</body>
</html>