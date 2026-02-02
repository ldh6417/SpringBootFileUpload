<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>T1 Community | Write</title>
<style>
/* T1 Official Theme */
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
	letter-spacing: -1px;
}

.header span {
	color: var(--t1-red);
}

/* Form Styles */
.form-group {
	margin-bottom: 25px;
}

.form-group label {
	display: block;
	font-size: 0.9rem;
	color: var(--t1-gold);
	margin-bottom: 8px;
	text-transform: uppercase;
	font-weight: bold;
}

input[type="text"], input[type="password"] {
	width: 100%;
	padding: 12px 15px;
	background: #0b0b0b;
	border: 1px solid #333;
	border-radius: 5px;
	color: #fff;
	font-size: 1rem;
	box-sizing: border-box;
	transition: 0.3s;
}

input[type="text"]:focus, input[type="password"]:focus {
	border-color: var(--t1-red);
	outline: none;
	box-shadow: 0 0 10px rgba(226, 1, 45, 0.3);
}

/* Buttons */
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
	text-transform: uppercase;
}

.btn-submit {
	background: var(--t1-red);
	color: #fff;
}

.btn-submit:hover {
	background: #ff1a4a;
	transform: translateY(-3px);
	box-shadow: 0 5px 15px rgba(226, 1, 45, 0.5);
}

.btn-reset {
	background: #333;
	color: #fff;
}

.btn-reset:hover {
	background: #fff;
	color: #ff1a4a;
	transform: translateY(-3px);
	box-shadow: 0 5px 15px rgba(226, 1, 45, 0.5);
}

.btn-cancel {
	background: #333;
	color: #bbb;
}

.btn-cancel:hover {
	background: #444;
	color: #fff;
}

/* 권한 선택 영역 스타일 */
.btn-form {
	padding-top: 20px;
	background: #1a1a1a;
	border-top: 1px solid #333;
	display: flex;
	flex-direction: column;
	gap: 15px;
	background: #1a1a1a;
}

.btn-form select {
	width: 100%;
	padding: 12px 15px;
	background: #0f0f0f;
	border: 1px solid #444;
	border-radius: 5px;
	color: #ccc;
	font-size: 0.9rem;
	font-family: 'Pretendard', sans-serif;
	appearance: none; /* 기본 화살표 제거 (선택사항) */
	cursor: default;
	transition: 0.3s;
}

/* disabled 상태일 때의 스타일 강조 */
.btn-form select:disabled {
	background: #111;
	color: var(--t1-gold); /* 읽기 전용일 때 골드 포인트 */
	border-color: #333;
	opacity: 0.8;
}

/* select 박스 사이의 간격 및 라벨 느낌의 효과 */
.btn-form select:focus {
	outline: none;
	border-color: var(--t1-red);
	box-shadow: 0 0 10px rgba(226, 1, 45, 0.2);
}

/* 폼 내부 레이아웃 정렬 */
.btn-form form {
	display: flex;
	flex-direction: column;
	gap: 10px;
}

/* Decoration */
.bottom-deco {
	margin-top: 30px;
	font-size: 12px;
	color: #444;
	text-align: center;
	font-family: monospace;
}

.btn-list {
	display: inline-block;
	padding: 15px 40px;
	background: var(--t1-red);
	color: white;
	text-decoration: none;
	font-weight: bold;
	border-radius: 5px;
	transition: 0.3s;
	border: none;
	cursor: pointer;
}

.btn-list:hover {
	background: #ffffff;
	color: var(--t1-red);
	box-shadow: 0 0 20px rgba(255, 255, 255, 0.4);
}
</style>
</head>
<body>

	<div class="write-container">
		<div class="header">
			<h1>
				회원정보<br> <span>${member.id}님의 회원 정보 수정</span>
			</h1>
		</div>
		<form:form modelAttribute="member" action="/member/update"
			method="post">
			<div class="form-group">
				<label for="no">회원번호</label> <input type="text" id="no" name="no"
					value="${member.no}" style="color: #989898" readonly>
			</div>
			<div class="form-group">
				<label for="id">회원ID</label> <input type="text" id="id" name="id"
					value="${member.id}" style="color: #989898" readonly>
			</div>

			<div class="form-group">
				<label for="name">회원NAME</label> <input type="text" id="name"
					name="name" value="${member.name}" required>
			</div>

			<div class="form-group">
				<label for="pw">회원PW</label> <input type="password" id="pw"
					name="pw" value="${member.pw}" required>
			</div>
			<div class="btn-form">

				<form:hidden path="no" />
				<form:select path="authList[0].auth" disabled="">
					<form:option value="" label="=== 부여된 권한이 없습니다 ===" />
					<form:option value="ROLE_USER" label="사용자" />
					<form:option value="ROLE_MEMBER" label="회원" />
					<form:option value="ROLE_ADMIN" label="관리자" />
				</form:select>
				<form:select path="authList[1].auth" disabled="">
					<form:option value="" label="=== 부여된 권한이 없습니다 ===" />
					<form:option value="ROLE_USER" label="사용자" />
					<form:option value="ROLE_MEMBER" label="회원" />
					<form:option value="ROLE_ADMIN" label="관리자" />
				</form:select>
				<form:select path="authList[2].auth" disabled="">
					<form:option value="" label="=== 부여된 권한이 없습니다 ===" />
					<form:option value="ROLE_USER" label="사용자" />
					<form:option value="ROLE_MEMBER" label="회원" />
					<form:option value="ROLE_ADMIN" label="관리자" />
				</form:select>
			</div>

			<div class="btn-area">
				<a href="/member/memberList" class="btn-list">회원리스트</a>
				<button type="submit" class="btn btn-submit">회원수정</button>
				<button type="reset" class="btn btn-reset">수정취소</button>
			</div>
		</form:form>

		<div class="bottom-deco">[ SYSTEM: READY TO TRANSMIT DATA TO
			JDBCBOARD ]</div>
	</div>

</body>
</html>