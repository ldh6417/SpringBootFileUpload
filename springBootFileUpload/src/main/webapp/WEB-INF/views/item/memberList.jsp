<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>T1 Community | Member List</title>

<style>
:root {
	--t1-red: #E2012D;
	--t1-black: #0f0f0f;
	--t1-gray: #1a1a1a;
	--t1-gold: #C69C6D;
	--t1-table-hover: #252525;
}

body {
	background-color: var(--t1-black);
	font-family: 'Pretendard', sans-serif;
	color: #ffffff;
	margin: 0;
	padding: 50px 0;
}

.container {
	max-width: 1000px;
	margin: 0 auto;
	padding: 0 20px;
}

.header-box {
	display: flex;
	justify-content: space-between;
	align-items: center;
	border-bottom: 3px solid var(--t1-red);
	padding-bottom: 15px;
	margin-bottom: 30px;
}

.header-box h1 {
	font-size: 2.5rem;
	font-weight: 900;
	margin: 0;
	letter-spacing: -1.5px;
}

.header-box h1 span {
	color: var(--t1-red);
}

/* 버튼 영역 */
.btn-group {
	display: flex;
	gap: 12px;
}

.btn-main {
	background: var(--t1-red);
	color: white;
	text-decoration: none;
	padding: 12px 26px;
	font-weight: 800;
	border-radius: 6px;
	letter-spacing: 0.5px;
	transition: 0.3s;
	border: 2px solid var(--t1-red);
}

.btn-main.secondary {
	background: transparent;
	color: var(--t1-gold);
	border: 2px solid var(--t1-gold);
}

.btn-main:hover {
	background: white;
	color: var(--t1-red);
	box-shadow: 0 0 15px rgba(255, 255, 255, 0.3);
}

.btn-main.secondary:hover {
	background: var(--t1-gold);
	color: black;
	box-shadow: 0 0 15px rgba(198, 156, 109, 0.4);
}

/* Table */
.t1-table {
	width: 100%;
	border-collapse: collapse;
	background: var(--t1-gray);
	border-radius: 10px 10px 0 0;
	overflow: hidden;
}

.t1-table th {
	background: #222;
	color: var(--t1-gold);
	padding: 15px;
	text-transform: uppercase;
	border-bottom: 1px solid #333;
}

.t1-table td {
	padding: 15px;
	text-align: center;
	border-bottom: 1px solid #222;
}

.t1-table tbody tr {
	transition: 0.2s;
}

.t1-table tbody tr:hover {
	background: var(--t1-table-hover);
	color: var(--t1-red);
}

.title-cell {
	text-align: left;
	padding-left: 30px;
}

.title-cell a {
	color: inherit;
	text-decoration: none;
	font-weight: 600;
}
</style>
</head>

<body>

	<div class="container">

		<div class="header-box">
			<h1>
				MEMBER <span>LIST</span>
			</h1>

			<div class="btn-group">
				<a href="/member/memberList" class="btn-main secondary">회원리스트</a> <a
					href="/member/joinForm" class="btn-main">회원가입</a>
			</div>
		</div>

		<table class="t1-table">
			<thead>
				<tr>
					<th width="10%">No</th>
					<th width="20%">ID</th>
					<th width="20%">PW</th>
					<th width="20%">Name</th>
					<th width="30%">RegDate</th>
				</tr>
			</thead>

			<tbody>

				<!-- 검색 영역은 choose 밖으로 빼기 -->
				<div class="search-container">
					<form action="/member/search" method="get" class="search-form">
						<select name="searchType" class="search-select">
							<option value="id">id</option>
							<option value="name">name</option>
						</select> <input type="text" name="keyword" class="search-input"
							placeholder="Search member...">
						<button type="submit" class="btn-search">SEARCH</button>
					</form>
				</div>

				<c:choose>

					<c:when test="${not empty memberList}">
						<c:forEach var="member" items="${memberList}">
							<tr>
								<td>${member.no}</td>

								<td class="title-cell"><a
									href="/member/detail?no=${member.no}"> ${member.id} </a></td>

								<td>${member.pw}</td>
								<td>${member.name}</td>

								<td><fmt:formatDate value="${member.regDate}"
										pattern="yyyy.MM.dd" /></td>
							</tr>
						</c:forEach>
					</c:when>

					<c:otherwise>
						<tr>
							<td colspan="5" style="padding: 50px; color: #777;">등록된 회원이
								없습니다.</td>
						</tr>
					</c:otherwise>

				</c:choose>

			</tbody>

		</table>

	</div>

</body>
</html>
