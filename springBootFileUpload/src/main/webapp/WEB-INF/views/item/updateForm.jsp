<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품정보</title>

<style>
:root {
	--t1-red: #E2012D;
	--t1-black: #0f0f0f;
	--t1-gray: #1a1a1a;
	--t1-gold: #C69C6D;
}

body {
	background-color: var(--t1-black);
	font-family: 'Pretendard', sans-serif;
	color: #ffffff;
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
	margin: 0;
	padding: 50px 0;
}

.write-container {
	width: 100%;
	max-width: 700px;
	background: var(--t1-gray);
	padding: 40px;
	border-radius: 15px;
	border: 2px solid var(--t1-red);
	box-shadow: 0 0 30px rgba(226, 1, 45, 0.2);
}

.header {
	text-align: center;
	margin-bottom: 40px;
}

.header h1 {
	font-size: 2rem;
	font-weight: 900;
}

.header span {
	color: var(--t1-red);
}

.form-group {
	margin-bottom: 25px;
}

.form-group label {
	display: block;
	font-size: 0.9rem;
	color: var(--t1-gold);
	margin-bottom: 8px;
	font-weight: bold;
}

input[type="text"], input[type="number"], textarea {
	width: 100%;
	padding: 12px 15px;
	background: #0b0b0b;
	border: 1px solid #333;
	border-radius: 5px;
	color: #fff;
	font-size: 1rem;
	transition: 0.3s;
}

textarea {
	height: 120px;
	resize: none;
}

input:focus, textarea:focus {
	border-color: var(--t1-red);
	outline: none;
	box-shadow: 0 0 10px rgba(226, 1, 45, 0.3);
}

/* 파일 업로드 */
/* 파일 업로드 래퍼 */
.file-upload-wrapper {
	width: 100%;
}

/* 숨겨진 실제 input */
.file-input {
	display: none;
}

/* 전체 파일 선택 박스 */
.file-label {
	display: flex;
	align-items: center;
	height: 48px; /* 높이 고정 */
	background: #0b0b0b;
	border: 1px solid #333;
	border-radius: 5px;
	cursor: pointer;
	overflow: hidden;
	transition: 0.3s;
}

.file-label:hover {
	border-color: var(--t1-red);
}

/* 왼쪽 버튼 영역 */
.file-btn {
	display: flex;
	align-items: center;
	justify-content: center;
	min-width: 110px; /* 너비 고정 */
	height: 100%; /* 부모 높이 꽉 채움 */
	background: #222;
	color: var(--t1-gold);
	font-size: 0.85rem;
	font-weight: bold;
	border-right: 1px solid #333;
}

/* 오른쪽 파일명 표시 영역 */
.file-name-text {
	display: flex;
	align-items: center;
	padding: 0 15px;
	height: 100%;
	color: #666;
	font-size: 0.9rem;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

/* 버튼 영역 */
.btn-area {
	display: flex;
	gap: 15px;
	margin-top: 30px;
}

.btn {
	flex: 1;
	padding: 15px;
	font-size: 1rem;
	font-weight: bold;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: 0.3s;
	text-align: center;
	text-decoration: none;
}

/* 리스트 버튼 */
.btn-list {
	background: #333;
	color: #fff;
}

.btn-list:hover {
	background: #444;
	transform: translateY(-3px);
}

/* 수정 버튼 */
.btn-submit {
	background: var(--t1-red);
	color: #fff;
}

.btn-submit:hover {
	background: #ffffff;
	color: var(--t1-red);
	transform: translateY(-3px);
	box-shadow: 0 5px 15px rgba(226, 1, 45, 0.5);
}

/* 초기화 버튼 */
.btn-reset {
	background: var(--t1-red);
	color: #fff;
}

.btn-reset:hover {
	background: #ffffff;
	color: var(--t1-red);
	transform: translateY(-3px);
	box-shadow: 0 5px 15px rgba(226, 1, 45, 0.5);
}

.btn-reset:hover {
	background: #ffffff;
	color: var(--t1-red);
	transform: translateY(-3px);
	box-shadow: 0 5px 15px rgba(226, 1, 45, 0.5);
}

/* 삭제 버튼 */
.btn-cancel {
	background: #222;
	color: #fff;
}

.btn-cancel:hover {
	background: #ff1a4a;
	color: #fff;
	transform: translateY(-3px);
	box-shadow: 0 5px 15px rgba(255, 26, 74, 0.5);
}
</style>
</head>

<body>

	<div class="write-container">

		<div class="header">
			<h1>
				상품정보<br> <span>${item.name} 상품 정보 수정</span>
			</h1>
		</div>

		<form:form modelAttribute="item" action="/item/update" method="post"
			enctype="multipart/form-data">

			<!-- 상품 ID -->
			<div class="form-group">
				<label>상품ID</label> <input type="text" name="id" value="${item.id}"
					readonly style="color: #999;">
			</div>

			<!-- 상품명 -->
			<div class="form-group">
				<label>상품명</label> <input type="text" name="name"
					value="${item.name}" required>
			</div>

			<!-- 가격 -->
			<div class="form-group">
				<label>상품가격</label> <input type="number" name="price"
					value="${item.price}" required>
			</div>

			<!-- 기존 이미지 -->
			<div class="form-group">
				<label>기존 상품 이미지</label><br> <img
					src="/item/display?id=${item.id}" width="300">
			</div>

			<!-- 수정 이미지 -->
			<div class="form-group">
				<label>상품 수정 이미지</label>

				<div class="file-upload-wrapper">
					<input type="file" id="picture" name="picture" class="file-input"
						onchange="updateFileName(this)"> <label for="picture"
						class="file-label"> <span class="file-btn">파일 선택</span> <span
						id="file-name" class="file-name-text">선택된 파일 없음</span>
					</label>
				</div>
			</div>

			<!-- 설명 -->
			<div class="form-group">
				<label>상품 상세 설명</label>
				<textarea name="description" required>${item.description}</textarea>
			</div>

			<!-- 버튼 영역 -->
			<div class="btn-area">

				<!-- 리스트 -->
				<a href="/item/list" class="btn btn-list">상품리스트</a>

				<!-- 수정 -->
				<button type="submit" class="btn btn-submit">상품수정</button>

				<!-- 초기화 -->
				<button type="reset" class="btn btn-reset">다시작성</button>

				<!-- 삭제 -->
				<a href="/item/delete?id=${item.id}" class="btn btn-cancel"
					onclick="return confirm('정말 삭제하시겠습니까?');"> 상품삭제 </a>

			</div>

		</form:form>

	</div>

	<script>
		function updateFileName(input) {

			const fileNameDisplay = document.getElementById('file-name');

			if (input.files && input.files.length > 0) {
				fileNameDisplay.innerText = input.files[0].name;
				fileNameDisplay.style.color = "#ffffff";
			} else {
				fileNameDisplay.innerText = "선택된 파일 없음";
				fileNameDisplay.style.color = "#666";
			}
		}
	</script>

</body>
</html>
