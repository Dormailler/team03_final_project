# 💻3조 프로젝트
: 각자의 물품을 빌리고 빌려주는 플랫폼입니다.

## 🤔프로젝트 소개
### ● 기획의도(목적)
누구에게나 꼭 필요한데 구매하기에는 애매한 물건이 꼭 한 개씩은 있었을 것이다. 잠깐 사용하고, 그 후로는 필요하지 않을 것 같아 구매하기 꺼려지는 물건들이다. 이 물건을 소지한 사용자가 대여비를 받고 필요한 사람에게 잠시 빌려줌으로써 “빌려줄래”는 이러한 답답함을 해소해주는 웹 프로젝트다. 

### ● 주요분석 내용
서로 안 쓰는 어떤 물건이든 다른 사람들에게 빌려주면서 돈을 벌 수 있고 동시에 잠시 필요한 물건은 저렴하게 빌려쓸 수 있도록 중개해주는 플랫폼.

### ● 기대 효과
'빌려줄래' 사용자는 '빌려주세요' 게시판을 통해 어쩌다 한 번씩 사용해 구매하기 애매한 물건들을 빌리며 돈을 아끼고, '빌려줍니다' 게시판을 통해 본인에게 있는 물건을 필요로 하는 사용자에게 빌려주며 돈을 벌 수 있다. 결국 빌리는 사람은 구매비보다 저렴한 대여비로 물건을 사용할 수 있고, 빌려주는 사람은 원래 가지고 있던 물건을 통해 돈을 벌 수 있다.

## ⏳개발 기간
23.08.10 ~ 23.08.24

## 🧑‍🤝‍🧑 멤버 구성
팀장 : 채수원 - 로그인, 회원 정보 수정, 회원 탈퇴, 메세지
팀원1 : 서상훈 
팀원2 : 권도현 
팀원3 : 김효빈

## 💻개발 환경
### ● 데이터베이스
 MySQL
### ● 프론트엔드
 HTML / CSS / JAVASCRIPT / jQuery / JSTL
### ● 벡엔드
 STS4(Spring Boot) - MAVEN / JAVA / MyBatis
### ● api
스마트에디터 api , 카카오맵 지도 api 

## 📚주요 기능
### 멤버 관리
● 로그인
- DB 값 검증
- 로그인 시 세션 생성

● 회원 가입
- 주소 API 연동
- ID 중복체크
- 잘못된 휴대폰 번호는 가입 불가
  
● 정보 수정 및 회원 탈퇴
- 회원 가입 시 기입한 정보를 DB에서 가져와 view에 뿌려준다.
- 프로필 사진 설정 후 view에 뿌려준다.
- 정보 수정시 세션을 다시 구워서 재로그인.
- 회원 탈퇴 버튼을 통해 DB에서 회원 정보 삭제 및 이를 통한 탈퇴

### 메시지
● 메시지 리스트
- 닉네임을 통해 서로 메세지
- 보낸 시각, 텍스트 등 간단한 기능만 구현
  
● 메시지 보내기
- 상대 닉네임을 통해 메시지 보내기

### <-- 추후 추가 예정 -->
