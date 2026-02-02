<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>T1 Community | Mission Detail</title>
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
	margin: 0;
	padding: 50px 0;
}

.detail-container {
	max-width: 800px;
	margin: 0 auto;
	background: var(--t1-gray);
	border: 2px solid var(--t1-red);
	border-radius: 15px;
	box-shadow: 0 0 30px rgba(226, 1, 45, 0.2);
	overflow: hidden;
}

/* 상단 헤더 영역 */
.detail-header {
	background: #222;
	padding: 30px;
	border-bottom: 1px solid #333;
}

.detail-header .post-no {
	color: var(--t1-red);
	font-weight: bold;
	font-size: 0.9rem;
	margin-bottom: 10px;
	display: block;
}

.detail-header h1 {
	margin: 0;
	font-size: 1.8rem;
	letter-spacing: -1px;
}

.post-info {
	margin-top: 15px;
	font-size: 0.9rem;
	color: #888;
	display: flex;
	gap: 20px;
}

.post-info span b {
	color: var(--t1-gold);
}

/* 본문 영역 */
.detail-content {
	padding: 40px 30px;
	min-height: 100px;
	line-height: 1.8;
	font-size: 1.1rem;
	white-space: pre-wrap; /* 줄바꿈 유지 */
	border-bottom: 1px solid #333;
}

/* 하단 버튼 영역 */
.btn-area {
	padding: 20px 30px;
	background: #151515;
	display: flex;
	justify-content: space-between;
}

.btn {
	padding: 10px 25px;
	font-weight: bold;
	border-radius: 5px;
	text-decoration: none;
	transition: 0.3s;
	cursor: pointer;
	border: none;
	font-size: 0.9rem;
}

.btn-list {
	background: #333;
	color: #fff;
}

.btn-list:hover {
	background: #444;
}

.btn-group {
	display: flex;
	gap: 10px;
}

.btn-edit {
	background: var(--t1-gold);
	color: #000;
}

.btn-delete {
	background: var(--t1-red);
	color: #fff;
}

.btn:hover {
	transform: translateY(-2px);
	opacity: 0.9;
}
/* 권한 선택 영역 스타일 */
.btn-form {
	padding: 20px 30px;
	background: #1a1a1a;
	border-top: 1px solid #333;
	display: flex;
	flex-direction: column;
	gap: 15px;
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

/* 데코레이션 */
.footer-deco {
	padding: 15px;
	text-align: center;
	font-size: 0.75rem;
	color: #444;
	background: #0f0f0f;
}
</style>
</head>
<body>

	<div class="detail-container">
		<div class="detail-header">
			<span class="post-no">MEMBER NO. ${member.no}</span>
			<h1>${member.id}</h1>
			<div class="post-info">
				<span>NAME: <b>${member.name}</b></span> <span>DATE: <b><fmt:formatDate
							value="${member.regDate}" pattern="yyyy.MM.dd HH:mm" /></b></span>
			</div>
		</div>

		<div class="btn-form">
			<form:form modelAttribute="member">
				<form:hidden path="no" />
				<form:select path="authList[0].auth" disabled="true">
					<form:option value="" label="=== 선택해 주세요 ===" />
					<form:option value="ROLE_USER" label="사용자" />
					<form:option value="ROLE_MEMBER" label="회원" />
					<form:option value="ROLE_ADMIN" label="관리자" />
				</form:select>
				<form:select path="authList[1].auth" disabled="true">
					<form:option value="" label="=== 선택해 주세요 ===" />
					<form:option value="ROLE_USER" label="사용자" />
					<form:option value="ROLE_MEMBER" label="회원" />
					<form:option value="ROLE_ADMIN" label="관리자" />
				</form:select>
				<form:select path="authList[2].auth" disabled="true">
					<form:option value="" label="=== 선택해 주세요 ===" />
					<form:option value="ROLE_USER" label="사용자" />
					<form:option value="ROLE_MEMBER" label="회원" />
					<form:option value="ROLE_ADMIN" label="관리자" />
				</form:select>
			</form:form>
		</div>

		<div class="btn-area">
			<a href="/member/memberList" class="btn btn-list">회원리스트</a>

			<div class="btn-group">
				<a href="/member/updateForm?no=${member.no}" class="btn btn-edit">글
					수정하기</a> <a href="/member/delete?no=${member.no}"
					class="btn btn-delete" onclick="return confirm('정말 삭제하시겠습니까?')">회원
					삭제하기</a>
			</div>
		</div>

		<div class="footer-deco">[ DATA ARCHIVE: T1 COMMUNITY SECURE
			TERMINAL ]</div>
	</div>

</body>
</html>