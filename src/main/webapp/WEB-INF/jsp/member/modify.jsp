<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="pageTitle" value="회원정보 수정" />
<%@ include file="../part/head.jspf"%>

<script>
var allClear = {
		name : false,
		afterPw : false,
		checkPw : false,
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
					if(name == ""){
						$('#name').val('');
						$('#name').focus();		
						$('#name_check').text('닉네임을 입력해주세요');
						$('#name_check').css('color', 'red');
					}
				},
				error : function() {
					console.log("실패");
				}
			});
		}
	});



	$("#afterPw").blur(function() {
		allClear['afterPw'] = false;
		update_reg_submit_disabled();
		
		var afterPw = $('#afterPw').val();
// 		var checkPw = $('#checkPw').val();

		if(afterPw.length > 0){
			if (afterPw.length <= 3) {
				$('#afterPw').val('');
				$('#afterPw_check').text('최소 4자리 입력해주세요.');
				$('#afterPw_check').css('color', 'red');	
			}
// 			if (loginId == checkPw) {
// 				$('#loginPw').val('');
// 				$('#Pw_check').text('아이디와 비밀번호를 다르게 입력해주세요.');
// 				$('#Pw_check').css('color', 'red');
// 			} 

			else {
				$('#afterPw_check').text('');		
				allClear['afterPw'] = true;
				update_reg_submit_disabled();
			}
		}

		// id = "id_reg" / name = "userId"
	});

	$("#checkPw").blur(function() {
		allClear['checkPw'] = false;
		update_reg_submit_disabled();
		
		var checkPw = $("#checkPw").val();
		var afterPw = $("#afterPw").val();

		if ( checkPw.length > 0 ) {
			
			if(afterPw != checkPw){
				$('#afterPw').val('');
				$('#checkPw').val('');
				$('#afterPw').focus();
				$('#checkPw_check').text('비밀번호와 일치하지 않습니다.');
				$('#checkPw_check').css('color', 'red');
				
			} else {
				$('#checkPw_check').text('비밀번호가 일치합니다.');
				$('#checkPw_check').css('color', 'blue');

				allClear['checkPw'] = true;
				update_reg_submit_disabled();
			}
		}
	});
});

function dd() {
	$("#name").blur();
	$("#afterPw").blur();
	$("#checkPw").blur();
}


</script>



<div class="con table-common">
	<form action="./doModify" method="POST"
		onsubmit="modifyFormSubmited
			(this); return false;">
		<table>
			<colgroup>
				<col width="170">
			</colgroup>
			<tbody>
				<tr>
					<th>닉네임</th>
					<td><input type="text" id="name" name="name"
						value="${loginedMember.name}" autocomplete="off">
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
					<td><input onclick="dd();" class="btn-a" type="submit" value="수정"
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