<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>회원가입</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script>
function checkId() {
  var user_id = $('#user_id').val();
  $.ajax({
    url: './idCheck',
    type: 'post',
    data: { user_id: user_id },
    success: function(cnt) {
      if (cnt == 0) {
        $('.id_ok').css("display", "inline-block");
        $('.id_already').css("display", "none");
      } else {
        $('.id_already').css("display", "inline-block");
        $('.id_ok').css("display", "none");
      }
    },
    error: function() {
      alert("에러입니다");
    }
  });
}
</script>
  <style>
  	.container {
  max-width: 600px;
}

.input-form-backgroud.row {
  max-width: 600px;
  margin: 0 auto;
}
    .input-form {
    width:400px;
        margin: 80px auto;
        padding: 32px;
        background: #fff;
        -webkit-border-radius: 10px;
        -moz-border-radius: 10px;
        border-radius: 10px;
        -webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
        -moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
        box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
    }
    
    #btnSearchAddress {
    margin: 10px;
  }
    
     #btnjoin {
    margin: 10px auto;
    display: block;
    }
    	
    .id_ok{
color:#008000;
display: none;
}

.id_already{
color:#6A82FB; 
display: none;
}

.email_ok{
	color:#008000;
display: none;
}

.email_already{
		color:#008000;
display: none;
}

  }
  </style>
</head>

<body>
<%@ include file="../header.jsp" %>
<div class="container">
  <div class="input-form-backgroud row">
    <div class="input-form col-md-12 mx-auto">
      <h4 class="mb-3" style="text-align : center;">회원가입</h4>
      <form action="/signup" method="POST">
        <div class="row">
          <div class="col-md-6 mb-3">
            <label for="id">ID</label>
            <input type="text" class="form-control" id="user_id" name="user_id" placeholder="" value="" required>
            <!-- id ajax 중복체크 -->
			<span class="id_ok">사용 가능한 아이디입니다.</span>
			<span class="id_already">누군가 이 아이디를 사용하고 있어요.</span>
          </div>
          <div class="col-md-6 mb-3">
            <label for="password">비밀번호</label>
            <input type="password" class="form-control" id="password" name="pw" placeholder="" value="" required>
            <div class="invalid-feedback">
              비밀번호를 입력해주세요.
            </div>
          </div>
        </div>

        <div class="mb-3">
          <label for="name">이름</label>
          <input type="text" class="form-control" id="name" name="name" required>
          <div class="invalid-feedback">
            이름을 입력해주세요.
          </div>
        </div>

        <div class="mb-3">
          <label for="email">이메일</label>
          <input type="email" class="form-control" id="email" name="email" placeholder="you@example.com" oninput="checkEmail()"
                 required>
        </div>

        <div class="mb-3">
          <label for="address">주소</label>
          <input type="text" class="form-control" id="address" name="address" placeholder="주소" required>
          <button class="btn btn-primary btn-lg btn-block" type="button" id="btnSearchAddress">우편번호 검색</button>
          <div class="invalid-feedback">
            주소를 입력해주세요.
          </div>
        </div>

        <div class="mb-3">
          <label for="phone">핸드폰 번호<span class="text-muted">&nbsp;</span></label>
          <input type="tel" id="phone" name="phone" class="form-control" placeholder="핸드폰 번호를 입력하세요."
                 oninput="validatePhoneNumber()" required>
          <span id="phoneError" style="color: red; display: none;">올바른 핸드폰 번호를 입력하세요.</span>
        </div>

        <hr class="mb-4">
        <div class="custom-control custom-checkbox">
          <input type="checkbox" class="custom-control-input" id="aggrement" required>
          <label class="custom-control-label" for="aggrement">개인정보 수집 및 이용에 동의합니다.</label>
        </div>
        <div class="mb-4"></div>
<button class="btn btn-primary btn-lg btn-block text-center" type="submit" id="btnjoin">가입 완료</button>
      </form>
    </div>
  </div>
  <footer class="my-3 text-center text-small">
    <p class="mb-1">&copy; 2023 빌려줄래</p>
  </footer>
</div>
<script>
  $('#btnSearchAddress').on('click', function() {
    // 다음 우편번호 팝업 열기
    new daum.Postcode({
      oncomplete: function(data) {
        // 선택한 주소를 입력 필드에 넣어주기
        $('#address').val(data.address);
      }
    }).open();
  });
</script>
<script>
function validatePhoneNumber() {
    const phoneInput = document.getElementById("phone");
    const phoneError = document.getElementById("phoneError");

    if (phoneInput.value.length !== 11) {
        phoneError.style.display = "inline";
    } else {
        phoneError.style.display = "none";
    }
}


  $(document).ready(function() {
    // user_id 입력란에서 입력이 발생하면 checkId() 함수가 호출됩니다.
    $('#user_id').on('input', checkId);

    // email 입력란에서 입력이 발생하면 checkEmail() 함수가 호출됩니다.
    $('#email').on('input', checkEmail);

    // phone 입력란에서 입력이 발생하면 checkPhone() 함수가 호출됩니다.
    $('#phone').on('input', checkPhone);

    // 페이지 로딩 시에도 checkPhone() 함수 호출하여 초기 상태를 확인합니다.
    checkPhone();
  });
</script>
</body>