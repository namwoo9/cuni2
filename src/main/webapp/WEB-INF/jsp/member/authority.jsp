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
</script>
<div class="con">
	<c:forEach items="${list}" var="member">
		<div>번호 : ${member.id}</div>
		<div>이름 : ${member.name}</div>
		<div>가입날짜 : ${member.regDate}</div>
		<div>아이디 : ${member.loginId}</div>
		<div>비번 : ${member.loginPw}</div>
		<div>이메일 : ${member.email}</div>
		<div>emailAuthKey : ${member.emailAuthKey}</div>
		<div>emailAuthStatus : ${member.emailAuthStatus}</div>
		<div>delStatus : ${member.delStatus}</div>
		<div>permissionLevel : ${member.permissionLevel}</div>
		<div>stop : ${member.stop}</div>
		<div>
			<a href="/member/idStop?id=${member.id}"><button>정지</button></a> <a
				href="/member/idStopCancel?id=${member.id}"><button>해제</button></a>
		</div>
		<hr>
	</c:forEach>
</div>
<%@ include file="../part/foot.jspf"%>