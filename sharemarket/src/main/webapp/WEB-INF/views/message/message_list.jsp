<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>빌려줄래 - 메세지 목록</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }
        #header {
            background-color: #333;
            color: white;
            padding: 10px;
            text-align: center;
        }
        h1 {
            margin: 20px;
        }
        table {
            width: 80%;
            margin: 30px auto;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #333;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        
        .message-list-title {
            float: left;
        }

        .new-message-button {
            background-color: #3498db;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block; /* 변경된 부분 */
           
        }
        
        .new-message-button:hover {
            background-color: #2980b9;
        }
        
        .message {
            margin-left: 10px;
        }
        
         .modal {
        display: flex;
        justify-content: center;
        align-items: center;
        position: fixed;
        z-index: 1;
        background-color: rgba(0, 0, 0, 0.4);
        width:400px;
        height:400px;
    }

    .modal-content {
    position: relative;
    display: flex;
    flex-direction: column;
    width: 50%;
    height: 50%;
    align-items: center;
    margin-top: 10%;
    margin-left: 30%;
    max-width : 400px;
    text-align:center;
}

    .close {
        float: right;
        cursor: pointer;
    }
    
    #message-content-text {
    text-algin:center;
    }
</style>
</head>
<body>
    <%@ include file="../header.jsp" %>

    <h1 class="message-list-title">메세지 목록</h1>
    <a href="<c:url value="/sendMessage"/>" class="new-message-button">새 메세지</a>

    <table border="1">
        <thead>
            <tr>
                <th class="message">메세지 ID</th>
                <th>보낸 사람</th>
                <th>받는 사람</th>
                <th>내용</th>
                <th>전송 시간</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${list}" var="message">
                <tr>
                    <td>${message.no}</td>
                    <td>${message.send_nick}</td>
                    <td>${message.recv_nick}</td>
                    <td><a href="#" class="message-content-link" data-content="${message.content}">${message.content}</a></td>
                    <td>${message.send_time}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div id="message-content-modal" class="modal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">메세지</h5>
                    <button type="button" class="close" id="close-modal">&times;</button>
                </div>
                <div class="modal-body">
                    <p id="message-content-text" class="text-center"></p>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="../footer.jsp" %>


<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
    var messageLinks = document.querySelectorAll('.message-content-link');
    var modal = document.getElementById('message-content-modal');
    var modalContent = document.getElementById('message-content-text');
    var closeBtn = document.getElementById('close-modal');

    messageLinks.forEach(function(link) {
        link.addEventListener('click', function() {
            modal.style.display = 'block';
            modalContent.innerText = link.getAttribute('data-content');
        });

        // Truncate text if it exceeds 12 characters
        var content = link.getAttribute('data-content');
        if (content.length > 12) {
            var truncatedContent = content.substring(0, 12) + '...';
            link.innerText = truncatedContent;
        }
    });

    closeBtn.addEventListener('click', function() {
        modal.style.display = 'none';
    });

    modal.addEventListener('click', function(event) {
        if (event.target === modal) {
            modal.style.display = 'none';
        }
    });
</script>
</body>
</html>