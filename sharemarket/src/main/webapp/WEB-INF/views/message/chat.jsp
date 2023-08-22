<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>WebSocket Chat</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
</head>
<body>
<%@ include file="../header.jsp" %>
    <div id="chat"></div>
    <input id="message" type="text" placeholder="Enter your message">
    <button onclick="sendMessage()">Send</button>
    <%@ include file="../footer.jsp" %>

    <script>
        const socket = new SockJS('/chat');
        const stompClient = Stomp.over(socket);

        stompClient.connect({}, () => {
            console.log('Connected to server');

            stompClient.subscribe('/topic/messages', (message) => {
                const chatDiv = document.getElementById('chat');
                const chatMessage = JSON.parse(message.body);
                chatDiv.innerHTML += `<p>${chatMessage.content}</p>`;
            });
        });

        function sendMessage() {
            const messageInput = document.getElementById('message');
            const message = messageInput.value;
            stompClient.send('/app/chat', {}, JSON.stringify({ content: message }));
            messageInput.value = '';
        }
    </script>
</body>
</html>