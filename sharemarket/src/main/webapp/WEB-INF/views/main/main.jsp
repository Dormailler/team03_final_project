<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="ko">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<style>
	.lead text-body-secondary {
	width:1444px;
	}
	</style>
    <title>빌려줄래</title>
</head>
<body>
    <%@ include file="../header.jsp" %>
<section class="py-5 text-center container">
    <div class="row py-lg-5">
        <div class="col-lg-6 col-md-8 mx-auto">
    <h1 class="fw-light" style="margin-bottom: 20px">빌 려 줄 래</h1>
    <div class="lead text-body-secondary">
        <p class="mb-0">빌려줄래는 안 쓰는 어떤 물건이든 다른 사람들에게 빌려주면서 돈을 벌 수 있고</p>
        <p class="mb-0">동시에 잠시 필요한 물건은 저렴하게 빌려쓸 수 있도록 중개해주는 플랫폼입니다.</p>
    </div>
            <p>
                <a href="/shareboardlist" class="btn btn-primary my-2">공유 게시판</a>
            </p>
        </div>
    </div>
</section>

<div class="album py-5 bg-body-tertiary">
    <div class="container">

        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
            <div class="col">
                <div class="card shadow-sm">
                    <svg class="bd-placeholder-img card-img-top" width="100%" height="225" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: " preserveAspectRatio="xMidYMid slice" focusable="false">
    				<title>Placeholder</title>
    <rect width="100%" height="100%" fill="#55595c"/>
    <!-- 텍스트를 가운데로 정렬 -->
    <text x="50%" y="50%" fill="#eceeef" dy=".3em" text-anchor="middle" dominant-baseline="middle">공유게시판</text>
</svg>
                    <div class="card-body">
                        <p class="card-text">공유 게시판</p>
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="btn-group">
								<button id="boardButton1" type="button" class="btn btn-sm btn-outline-secondary">게시판</button>
                                <button id="writeButton1" type="button" class="btn btn-sm btn-outline-secondary">글쓰기</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card shadow-sm">
                    <svg class="bd-placeholder-img card-img-top" width="100%" height="225" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: " preserveAspectRatio="xMidYMid slice" focusable="false">
    				<title>Placeholder</title>
    <rect width="100%" height="100%" fill="#55595c"/>
    <!-- 텍스트를 가운데로 정렬 -->
    <text x="50%" y="50%" fill="#eceeef" dy=".3em" text-anchor="middle" dominant-baseline="middle">나눔 게시판</text>
</svg>
                    <div class="card-body">
                        <p class="card-text">나눔 게시판</p>
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="btn-group">
                                <button id="boardButton2" type="button" class="btn btn-sm btn-outline-secondary">게시판</button>
                                <button id="writeButton2" type="button" class="btn btn-sm btn-outline-secondary">글쓰기</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card shadow-sm">
                    <svg class="bd-placeholder-img card-img-top" width="100%" height="225" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: " preserveAspectRatio="xMidYMid slice" focusable="false">
    				<title>Placeholder</title>
    <rect width="100%" height="100%" fill="#55595c"/>
    <!-- 텍스트를 가운데로 정렬 -->
    <text x="50%" y="50%" fill="#eceeef" dy=".3em" text-anchor="middle" dominant-baseline="middle">커뮤니티</text>
</svg>
                    <div class="card-body">
                        <p class="card-text">커뮤니티</p>
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="btn-group">
                                <button id="boardButton3" type="button" class="btn btn-sm btn-outline-secondary">게시판</button>
                                <button id="writeButton3" type="button" class="btn btn-sm btn-outline-secondary">글쓰기</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
    <%@ include file="../footer.jsp" %>

    <!-- Optional JavaScript; choose one of the two! -->

<!-- Option 1: Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Option 2: Separate Popper and Bootstrap JS -->
<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@2.10.2/dist/umd/popper.min.js"></script>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

<script>
// 버튼 클릭 이벤트 핸들러
document.getElementById("boardButton1").addEventListener("click", function() {
    // 페이지를 이동시킴
    window.location.href = "/shareboardlist";
});

document.getElementById("writeButton1").addEventListener("click", function() {
    // 페이지를 이동시킴
    window.location.href = "/writingform";
});

document.getElementById("boardButton2").addEventListener("click", function() {
    // 페이지를 이동시킴
    window.location.href = "/free";
});

document.getElementById("writeButton2").addEventListener("click", function() {
    // 페이지를 이동시킴
    window.location.href = "/freew";
});

document.getElementById("boardButton3").addEventListener("click", function() {
    // 페이지를 이동시킴
    window.location.href = "/commList";
});

document.getElementById("writeButton3").addEventListener("click", function() {
    // 페이지를 이동시킴
    window.location.href = "/commWrite";
});


</script>
</body>
</html>