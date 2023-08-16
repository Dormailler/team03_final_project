<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
     <!-- Bootstrap CSS -->
  	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>로그인</title>
     <style>
    /* 추가한 스타일 */
    .form-signin {
      max-width: 400px;
      margin: 10px auto;
    }

    /* 입력란 간의 마진 */
    .form-floating {
      margin-bottom: 10px;
    }

  </style>
</head>
<body class="text-center">
    <%@ include file="../header.jsp" %>
    <main class="form-signin">
    	<h1 class="h3 mb-3 fw-normal">로그인</h1>
        <%-- 로그인 실패 시 오류 메시지 출력 --%>
        <% if (request.getAttribute("errorMessage") != null) { %>
            <p style="color: red;"><%= request.getAttribute("errorMessage") %></p>
        <% } %>
        <form class="form-signin" action="loginProcess" method="POST">
            <div class="form-floating">
            	<input type="text"  class="form-control" id="id" name="user_id" placeholder="ID" required>
                <label for="floatingInput">ID</label>
            </div>
            <div class="form-floating">
            	<input type="password" class="form-control" id="password" name="pw" placeholder="PASSWORD" required>
                <label for="floatingInput">PASSWORD</label>
            </div>
            <input class="w-100 btn btn-lg btn-primary" type="submit" value="로그인">
        </form>
         <p class="mt-3">아직 회원이 아니신가요? <a href="/join">회원가입</a></p>
             <p class="mt-5 mb-3 text-muted">&copy; 2023, 빌려줄래</p>
       
    <%@ include file="../footer.jsp" %>
    <script src="login_login.js"></script>
<script>
    $(document).ready(function() {
        // 유저 아이콘
        if (${not empty sessionScope.session_id}) {
            $("#user_profile").show();
            $("#login_btn").hide();
            $("#logout_btn").show();
        } else {
            $("#user_profile").hide();
            $("#login_btn").show();
            $("#logout_btn").hide();
        }

        // 로그아웃 버튼 클릭 이벤트
        $("#logout_btn").on("click", function() {
            location.href = "/boardlogout"; // 로그아웃 처리를 위해 /boardlogout 경로로 이동
        });
    });
</script>
</body>
</html>