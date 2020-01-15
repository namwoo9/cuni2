<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sejong.namu.dto.Member"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="pageTitle" value="회원관리" />
<%@ include file="../part/head.jspf"%>


<script>
	var chatWriter = '${loginedMember.getName()}';

	function idStop() {
		var result = confirm("계정을 정지 하시겠습니까?");
		if (result) {

		} else {
			return;
		}
	}
</script>
<div class="list-1 table-common con">
	<table>
		<colgroup>
			<col width="30">
			<col width="100">
			<col width="130">
			<col width="50">
			<col width="50">
			<col width="130">
			<col width="100">
			<col width="100">
			<col width="100">
			<col width="50">
			<col width="50">
			<col width="50">
		</colgroup>
		<thead>
			<tr>
				<th>ID</th>
				<th>이름</th>
				<th>regDate</th>
				<th>loginId</th>
				<th>loginPw</th>
				<th>Email</th>
				<th>이메일키</th>
				<th>이메일완료</th>
				<th>delStatus</th>
				<th>계정레벨</th>
				<th>계정상태</th>
				<th>벤</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="member">
				<tr>
					<td><button
							onclick="if ( confirm('이 회원 계정을 삭제 하시겠습니까?') ) location.href = '#'">${member.id}</button></td>
					<td>${member.name}</td>
					<td>${member.regDate}</td>
					<td>${member.loginId}</td>
					<td>${member.loginPw}</td>
					<td>${member.email}</td>
					<td>${member.emailAuthKey}</td>
					<td>${member.emailAuthStatus}</td>
					<td>${member.delStatus}</td>
					<td>${member.permissionLevel}</td>
					<td>${member.stop}</td>
					<td><a href="/member/idStop?id=${member.id}"><button>정지</button></a>
						<a href="/member/idStopCancel?id=${member.id}"><button>해제</button></a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<%@ include file="../part/foot.jspf"%>