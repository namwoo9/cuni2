<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sejong.namu.dto.Member"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<!-- 모바일에서 디바이스의 해상도가 아닌 디바이스의 실제 크기를 기준으로 너비/높이를 잡는다. -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
<title>채팅방</title>
<link rel="stylesheet" href="/css/chat/main.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
var chatWriter = '${loginedMember.getName()}';
//var chatWriter = '${loginedMemberName}';

</script>

<script src="/js/chat/main.js"></script>
<script>
<%-- 	alert(<%=loginedMemberId%>); --%>
	function goTop() {
		// 		$(window).scrollTop(0);
		// 		$('html, body').scrollTop(0);
		// 		$('#chat-room').scrollTop(0);
		$('.message-box').scrollTop(0);
// 		alert('${loginedMember.name}');
	}

	function homeAsk() {
		if (confirm("메인 게시판으로 이동하시겠습니까?") == true) { //확인
			location.href = "/";
		} else { //취소
			return false;
		}

	}
</script>
</head>
<body>

	<div id="chat-room">
		<div class="message-box" id="style-1">
			<div class="message-group" data-date-str="${loginedMember.name}님"></div>
		</div>
		<div class="input-box">
			<input type="text" id="text-input">
			<div class="btn-plus">
				<button type="button" onclick="goTop()">Top</button>
				<button type="button" class="home" onclick="homeAsk();">Home</button>
				<i class="fa fa-plus" aria-hidden="true"></i>
			</div>
			<div class="btn-emo">
				<i class="fa fa-smile-o" aria-hidden="true"></i>
			</div>
			<div class="btn-submit">
				<span>전송</span>
			</div>
		</div>
	</div>

</body>
</html>