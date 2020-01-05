<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sejong.namu.dto.Member"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="pageTitle" value="회원가입" />
<%@ include file="../part/head.jspf"%>


<script type="text/javascript">

var allClear = {
	loginId: false,
	loginPw: false,
	loginPwConfirm: false,
	name: false,
	email: false
};

function update_reg_submit_disabled() {
	$('#reg_submit').prop('disabled', true);
	
	for ( var key in allClear ) {
		if ( allClear[key] == false ) {
			return false;
		}
	}

	$('#reg_submit').prop('disabled', false);
}

$(function(){
	update_reg_submit_disabled();
	
	$("#loginId").blur(function() {
		allClear['loginId'] = false;
		update_reg_submit_disabled();
		
		// id = "id_reg" / name = "userId"
		var loginId = $('#loginId').val();

		loginId = loginId.trim();

		if ( loginId.length > 0 ) 
		{
			var loginIdCheck = RegExp(/^[A-Za-z0-9_\-]{5,20}$/);

			$('#reg_submit').prop('disabled', true);

			$.ajax({	
				url : '${pageContext.request.contextPath}/user/idCheck?loginId='+ loginId,
				type : 'get',
				success : function(data) {
					console.log("1 = 중복o / 0 = 중복x : "+ data);							
					if (data == 1) {
						// 1 : 아이디가 중복되는 문구
// 						$('#loginId').focus();
						$("#id_check").text("사용중인 아이디입니다");
						$("#id_check").css("color", "red");
					} else {
						$("#id_check").text("");
					}

					if (!loginIdCheck.test($('#loginId').val())) {
						
// 						$('#loginId').focus();		
						$("#id_check").text("영문·숫자만 입력 해주세요.");
						$("#id_check").css("color", "red");
					} 
					if (data == 0 && loginIdCheck.test($('#loginId').val())) {
						$("#id_check").text("사용 가능한 아이디입니다.");
						$("#id_check").css("color", "blue");
						allClear['loginId'] = true;
						update_reg_submit_disabled();
					}
					if(loginId == ""){
						$('#loginId').val('');
// 						$('#loginId').focus();		
						$('#id_check').text('아이디를 입력해주세요');
						$('#id_check').css('color', 'red');
										
					}
				},
				error : function() {
					console.log("실패");
				}
			});
		}
	});
		

	$("#name").blur(function() {
		allClear['name'] = false;
		update_reg_submit_disabled();
		
		// id = "id_reg" / name = "userId"
		var name = $('#name').val();

		name = name.trim();

		if ( name.length > 0 ) {
			var loginNameCheck = RegExp(/^[가-힣|a-z|A-Z|0-9|\*]+$/);
			$.ajax({	
				url : '${pageContext.request.contextPath}/user/nameCheck?name='+ name,
				type : 'get',
				success : function(data) {
					console.log("1 = 중복o / 0 = 중복x : "+ data);							
					if (data == 1) {
						// 1 : 아이디가 중복되는 문구
// 						$('#name').focus();
						$("#name_check").text("사용중인 닉네임입니다");
						$("#name_check").css("color", "red");
						
					}
					
	 				if (!loginNameCheck.test($('#name').val())) {
// 						$('#name').focus();		
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

	$("#loginPw").blur(function() {
		allClear['loginPw'] = false;
		update_reg_submit_disabled();
		
		var loginPw = $(this).val();
		var loginId = $('#loginId').val();

		if(loginPw != ""){
			if (loginPw.length <= 3) {
				$('#loginPw').val('');
				$('#loginPw').focus();
				$('#Pw_check').text('최소 4자리 입력해주세요');
				$('#Pw_check').css('color', 'red');
				
			} else {
				$('#Pw_check').text('');	
					
				allClear['loginPw'] = true;
				update_reg_submit_disabled();
			}

			if (loginId == loginPw) {
				$('#loginPw').val('');
				$('#loginPw').focus();
				$('#Pw_check').text('아이디와 비밀번호를 다르게 입력해주세요');
				$('#Pw_check').css('color', 'red');
				
			}
		}

		// id = "id_reg" / name = "userId"
	});

	$("#loginPwConfirm").blur(function() {
		allClear['loginPwConfirm'] = false;
		update_reg_submit_disabled();
		
		var loginPwConfirm = $("#loginPwConfirm").val();
		var loginPw = $("#loginPw").val();

		if ( loginPwConfirm.length > 0 ) {
			
			if(loginPw != loginPwConfirm){
				$('#loginPw').val('');
				$('#loginPwConfirm').val('');
				$('#loginPw').focus();
				$('#Pwcf_check').text('비밀번호와 일치하지 않습니다.');
				$('#Pwcf_check').css('color', 'red');
				
			} else {
				$('#Pwcf_check').text('');

				allClear['loginPwConfirm'] = true;
				update_reg_submit_disabled();
			}
		}
	});

	$("#email").blur(function() {
		allClear['email'] = false;
		update_reg_submit_disabled();
		
		var email = $("#email").val();

		if ( email.length > 0 ) {
			allClear['email'] = true;
			update_reg_submit_disabled();
			
			if(email == ''){
				$('#email').focus();
				$('#email_check').text('이메일을 정확히 입력하세요');
				$('#email_check').css('color', 'red');				
			}
		}
	});
});
<!--유효성 검사-->


</script>

<div class="login-box con table-common">
	<form action="./doJoin" method="POST">
		<!-- " -->
		<table>
			<colgroup>
				<col width="150">
			</colgroup>
			<tbody>
				<tr>
					<th>아이디</th>
					<td><input type="text" id="loginId" name="loginId"
						autocomplete="off" autofocus="autofocus"
						placeholder="아이디를 입력해주세요." maxlength="12" required>
						<div class="check_font" id="id_check"></div></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" id="loginPw" name="loginPw"
						placeholder="비밀번호를 입력해주세요." maxlength="12" required>
						<div class="check_font" id="Pw_check"></div></td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td><input type="password" id="loginPwConfirm"
						name="loginPwConfirm" placeholder="비밀번호 확인을 입력해주세요."
						maxlength="12" required>
						<div class="check_font" id="Pwcf_check"></div></td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td><input type="text" id="name" name="name"
						autocomplete="off" placeholder="닉네임을 입력해주세요." maxlength="10"
						required><div class="check_font" id="name_check"></div></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="email" id="email" name="email" autocomplete="off"
						placeHolder="이메일 인증을 받으셔야 로그인 하실 수 있습니다." maxlength="20" required>
						<div class="check_font" id="email_check"></div>
						</td>
				</tr>
				<tr>
					<th>가입</th>
					<td><input class="btn-a" id="reg_submit" type="submit"
						value="가입"> <input class="btn-a" type="reset" value="취소"
						onclick="location.href = '/';"></td>
				</tr>
			</tbody>
		</table>
	</form>
</div>
<%@ include file="../part/foot.jspf"%>