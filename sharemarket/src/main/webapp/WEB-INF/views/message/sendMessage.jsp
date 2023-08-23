<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<script src="js/jquery-3.6.4.min.js"></script>
	<script>
	$(document).ready(function(){
		function getQueryParam(param) {
		    let searchParams = new URLSearchParams(window.location.search);
		    return searchParams.get(param);
		}

		let sendValue = getQueryParam("send");
		if (sendValue) {
		    $('#recv_nick').val(sendValue);
		}
	});
	</script>
    <title>Send Message</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }
        #container {
            width: 400px;
            margin: 50px auto;
            background-color: white;
            padding: 40px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        input[type="text"],
        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
            margin-bottom: 15px;
        }
        button[type="submit"] {
            background-color: #3498db;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            display: block;
            margin: 0 auto;
        }
        button[type="submit"]:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
    <%@ include file="../header.jsp" %>
    <div id="container">
        <h2>메세지</h2>
        <form action="${pageContext.request.contextPath}/sendMessage" method="post">
            <label for="recv_nick">받는 사용자:</label>
            <input type="text" id="recv_nick" name="recv_nick" required>
            <label for="content">메세지 내용:</label>
            <textarea id="content" name="content" rows="5" required></textarea>
            <button type="submit" style="margin-top : 10px;">메세지 보내기</button>
        </form>
    </div>
        <%@ include file="../footer.jsp" %>
    
</body>
</html>
