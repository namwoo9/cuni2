<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="pageTitle" value="회원정보 수정" />
<%@ include file="../part/head.jspf"%>

<script>
var allClear = {
		name : false
};
	function update_reg_submit_disabled() {
		$('#reg_submit').prop('disabled', true);

		for ( var key in allClear) {
			if (allClear[key] == false) {
				return false;
			}
		}
	$('#reg_submit').prop('disabled', false);
}

$(function(){
	$("#name").blur(function() {
		allClear['name'] = false;
		update_reg_submit_disabled();
		
		// id = "id_reg" / name = "userId"
		var memberId = '${loginedMember.getName()}';
		var name = $('#name').val();
		name = name.trim();

		if ( name.length > 0 ) {
			var loginNameCheck = RegExp(/^[가-힣|a-z|A-Z|0-9|\*]+$/);

			$('#reg_submit').prop('disabled', true);
			
			$.ajax({	
				url : '${pageContext.request.contextPath}/user/nameCheck?name='+ name,
				type : 'get',
				name : name,
				success : function(data) {
					
					console.log("1 = 중복o / 0 = 중복x : "+ data);							
					if (data == 1 && memberId == name) {
						// 1 : 아이디가 중복되는 문구
						$("#name_check").text("사용 가능한 닉네임 입니다.");
	 					$("#name_check").css("color", "blue");
	 					allClear['name'] = true;
	 					update_reg_submit_disabled();
					} else {
						$("#name_check").text("사용중인 닉네임입니다");
						$("#name_check").css("color", "red");
					}
	 				if (!loginNameCheck.test($('#name').val())) {		
	 					$("#name_check").text("한글, 영문, 숫자만 입력 해주세요.");
	 					$("#name_check").css("color", "red");
	 				}
	 				if (data == 0 && loginNameCheck.test($('#name').val())) {
	 					$("#name_check").text("사용 가능한 닉네임 입니다.");
	 					$("#name_check").css("color", "blue");
	 					allClear['name'] = true;
	 					update_reg_submit_disabled();
	 				}
					if(name.length <= 1){
						$('#name_check').text('닉네임을 최소 2글자 이상 입력해주세요');
						$('#name_check').css('color', 'red');
					}
				},
				error : function() {
					console.log("실패");
				}
			});
		}
	});

	$('#modifyForm').keydown(function(e) {
	    // 만약 입력한 키코드가 13, 즉 엔터라면 함수를 실행한다.
	    if ( e.keyCode == 13 ) {
	    	return false;
	    }
	});
});

function modifyFormSubmited(form){
	form.name.value =  form.name.value.trim();

	if (form.name.value.length == 0) {
		alert('닉네임을 입력해주세요.');
		form.name.focus();
		return false;
	}

	form.name.value =  form.name.value.trim();

	if (form.name.value.length == 0) {
		alert('닉네임을 입력해주세요.');
		form.name.focus();
		return false;
	}

	form.afterPw.value =  form.afterPw.value.trim();

	if (form.afterPw.value.length == 0) {
		alert('변경할 비밀번호를 입력해주세요.');
		form.afterPw.focus();
		return false;
	}

	if (form.afterPw.value.length <= 3) {
		alert('비밀번호를 최소 4글자 이상 입력해주세요.');
		form.afterPw.value = '';
		form.checkPw.value = '';
		form.afterPw.focus();
		return false;
	}

	form.checkPw.value =  form.checkPw.value.trim();

	if (form.checkPw.value.length == 0) {
		alert('비밀번호 확인을 입력해주세요.');
		form.checkPw.focus();
		return false;
	}

	if (form.checkPw.value != form.afterPw.value ) {
		alert('비밀번호와 일치하지 않습니다. ');
		form.checkPw.value = '';
		form.checkPw.focus();
		return false;
	}
	form.submit();
}



	// function dd() {
	// 	$("#name").blur();
	// }

	
</script>



<div class="con table-common">
	<form action="./doModify" id="modifyForm" method="POST"
		onsubmit="modifyFormSubmited
			(this); return false; ">
		<table>
			<colgroup>
				<col width="170">
			</colgroup>
			<tbody>
				<tr>
					<th>닉네임</th>
					<td><input type="text" id="name" name="name"
						value="${loginedMember.name}" autocomplete="off" autofocus="autofocus">
					<div class="check_font" id="name_check"></div></td>
				</tr>
				<!-- 				<tr> -->
				<!-- 					<th>이메일</th> -->
				<%-- 					<td><input type="email" name="email" value="${loginedMember.email}"></td> --%>
				<!-- 				</tr> -->
				<!-- 				<tr> -->
				<!-- 					<th>기존 비밀번호</th> -->
				<!-- 					<td><input type="password" name="beforePw"></td> -->
				<!-- 				</tr> -->
				<tr>
					<th>변경할 비밀번호</th>
					<td><input type="password" name="afterPw"  id="afterPw" maxlength="10"
						placeholder="변경할 비밀번호"><div class="check_font" id="afterPw_check"></div></td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td><input type="password" name="checkPw" id="checkPw" maxlength="10"
						placeholder="변경할 비밀번호 확인"><div class="check_font" id="checkPw_check"></div></td>
				</tr>

				<tr>
					<th>수정</th>
					<td><input onclick="goData();" class="btn-a" type="submit" value="수정"
						id="reg_submit"> <input class="btn-a" type="reset"
						value="취소"
						onclick="location.href = '/member/myPage?id=${loginedMember.id}';">
						<button class="btn-a" type="button"
							onclick="if ( confirm('정말 탈퇴하시겠습니까?') ) location.href = './doSecession'">회원탈퇴</button></td>

				</tr>

			</tbody>
		</table>
	</form>


</div>
<%@ include file="../part/foot.jspf"%>