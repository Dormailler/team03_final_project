<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<script>
$(document).ready(function() {
    // 유저 아이콘
    <%-- 세션에 session_id가 null이 아닌 경우 (로그인된 상태) --%>
    <c:if test="${session_id != null}">
        $("#user_profile").show();
        $("#logout_btn").show();
    </c:if>
    <c:if test="${session_id == null}">
        $("#user_profile").hide();
        $("#logout_btn").hide();
    </c:if>
})
</script>
    <meta charset="UTF-8">
    <title>Title</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
<div class="container">
  <header class="d-flex flex-wrap align-items-center justify-content-center justify-content-md-between py-3 mb-4 border-bottom">
    <div class="col-md-3 mb-2 mb-md-0">
      <a href="/" class="d-inline-flex link-body-emphasis text-decoration-none">
        <svg class="bi" width="40" height="32" role="img" aria-label="Bootstrap"><use xlink:href="#bootstrap"/></svg>
      </a>
    </div>

    <ul class="nav col-12 col-md-auto mb-2 justify-content-center mb-md-0">
      <li><a href="#" class="nav-link px-2 link-secondary">Home</a></li>
      <li><a href="#" class="nav-link px-2">빌려주세요</a></li>
      <li><a href="#" class="nav-link px-2">빌려줍니다</a></li>
      <li><a href="/free" class="nav-link px-2">무료나눔</a></li>
      <li><a href="#" class="nav-link px-2">커뮤니티</a></li>
      <li><a href="#" class="nav-link px-2">문의사항</a></li>
    </ul>

    <div class="col-md-3 text-end">
    <c:choose>
        <c:when test="${empty sessionScope.session_id}">
            <a href="/login" class="btn btn-outline-primary me-2">로그인</a>
            <a href="/join" class="btn btn-primary">회원가입</a>
        </c:when>
        <c:otherwise>
            <a href="/message" class="btn btn-outline-primary me-2">메시지</a>
            <a href="/boardlogout" class="btn btn-outline-primary me-2">로그아웃</a>
        </c:otherwise>
    </c:choose>
</div>
</header>
</body>
</html>
