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

	function idDel() {
		$.ajax({
			url : "./idDel",
			type : "POST",
			data : {
				name : "${isLogined}"
			},
			success : function(data) {

			},
			error : function(error) {
				alert('에러가 발생했습니다.')
			}
		});
	}
</script>
<style>
table {
	text-align: center;
}

.button {
	
	background-color: #ededed;
	color: #777777;
	padding: 4px 10px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 4px 2px;
	cursor: pointer;
}

.button:hover {
	box-shadow: 0 12px 16px 0 rgba(0, 0, 0, 0.24), 0 17px 50px 0
		rgba(0, 0, 0, 0.19);
}
</style>
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
				<th>계정삭제</th>
				<th>계정레벨</th>
				<th>계정상태</th>
				<th>벤</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="memberList">
				<tr>
					<td><a class="button"
						onclick="if ( confirm('이 계정을 삭제 하시겠습니까?') == false ) return false;"
						href="/member/idDel?id=${memberList.id}"
						style="text-decoration: none;">${memberList.id}</a></td>
					<td>${memberList.name}</td>
					<td>${memberList.regDate}</td>
					<td>${memberList.loginId}</td>
					<td>${memberList.loginPw}</td>
					<td>${memberList.email}</td>
					<td>${memberList.emailAuthKey}</td>
					<td>${memberList.emailAuthStatus}</td>
					<td>${memberList.delStatus}</td>
					<td>${memberList.permissionLevel}</td>
					<td>${memberList.stop}</td>
					<td><a
						onclick="if ( confirm('이 계정을 정지 하시겠습니까?') == false ) return false;"
						href="/member/idStop?id=${memberList.id}"><button>정지</button></a>
						<a
						onclick="if ( confirm('계정 정지를 해제 하시겠습니까?') == false ) return false;"
						href="/member/idStopCancel?id=${memberList.id}"><button>해제</button></a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<%-- ${loginedMemberLoginName} --%>
<%@ include file="../part/foot.jspf"%>