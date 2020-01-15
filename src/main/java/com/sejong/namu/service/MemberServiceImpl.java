package com.sejong.namu.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.groovy.util.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.sejong.namu.dao.MemberDao;
import com.sejong.namu.dto.Member;
import com.sejong.namu.handler.MailHandler;
import com.sejong.namu.util.CUtil;

@Service
public class MemberServiceImpl implements MemberService {
	@Value("${custom.emailSender}")
	private String emailSender;
	@Value("${custom.emailSenderName}")
	private String emailSenderName;

	@Autowired
	private MemberDao memberDao;
	@Autowired
	private JavaMailSender sender;

	public HttpSession session;

	@Override
	public Map<String, Object> login(Map<String, Object> param) {
		Member loginedMember = (Member) memberDao.getMatchedOne(param);

		String msg = null;
		String resultCode = null;

		long loginedMemberId = 0;

		if (loginedMember == null) {
			resultCode = "F-1";
			msg = "아이디와 비밀번호를 다시 입력해주세요.";

			return Maps.of("resultCode", resultCode, "msg", msg);
		}

		if (loginedMember.isEmailAuthStatus() == false) {
			resultCode = "F-2";
			msg = "이메일 인증을 진행해주세요";

			return Maps.of("resultCode", resultCode, "msg", msg);
		}
		String loginedMemberName = "";
		loginedMemberId = loginedMember.getId();
		loginedMemberName = loginedMember.getName();

		if (loginedMember.getStop() == 1) {
			resultCode = "F-3";
			msg = "접근이 불가한 계정입니다.";

			return Maps.of("resultCode", resultCode, "msg", msg);
		}

		if (loginedMember.getPermissionLevel() != 1) {
			resultCode = "S-1";
			msg = loginedMemberName + "님 안녕하세요";

		} else {
			resultCode = "S-2";
			msg = "관리자 접속";

		}
		return Maps.of("resultCode", resultCode, "msg", msg, "loginedMemberId", loginedMemberId, "loginedMemberName",
				loginedMemberName);
	}

	@Override
	public Member getOne(long loginedMemberId) {
		return memberDao.getOne(loginedMemberId);
	}

	public Map<String, Object> doubleCheck(Map<String, Object> param) {
		int count = memberDao.doubleCheck(param);

		String msg = null;
		String resultCode = null;

		if (count <= 0) {
			param.put("authKey", CUtil.getTempKey());
			memberDao.addMember(param);
			MailHandler mail;
			try {
				mail = new MailHandler(sender);
				mail.setFrom(emailSender, emailSenderName);
				mail.setTo((String) param.get("email"));
				mail.setSubject("회원가입 이메일인증");
				mail.setText(new StringBuffer().append("<h1>이메일인증 메일</h1>")
						.append("<a href='http://localhost:8083/member/confirm?email=")
						.append((String) param.get("email")).append("&authKey=").append((String) param.get("authKey"))
						.append("' target='_blank'> 누르시면 메일 인증 페이지로 이동됩니다. </a>").toString());
				mail.send();
				msg = "회원가입이 완료 되었습니다.";
				resultCode = "S-2";
			} catch (Exception e) {
				msg = "회원가입에 실패했습니다.";
				resultCode = "F-2";
				e.printStackTrace();
			}
		} else {
			msg = "회원가입에 실패했습니다.";
			resultCode = "F-2";
		}

		return Maps.of("msg", msg, "resultCode", resultCode);
	}

	public Map<String, Object> searchId(Map<String, Object> param) {
		Member member = memberDao.searchId(param);
		System.out.println("member.getLoginId() : " + member.getLoginId());
		String msg = null;
		String resultCode = null;
		MailHandler mail;
		try {
			mail = new MailHandler(sender);
			mail.setFrom(emailSender, emailSenderName);
			mail.setTo((String) param.get("email"));
			mail.setSubject("회원님의 아이디가 발송되었습니다.");
			mail.setText(new StringBuffer().append("<h1>아이디는 " + member.getLoginId() + " 입니다.</h1>").toString());
			mail.send();
			msg = "메일이 발송되었습니다.";
			resultCode = "S-2";
		} catch (Exception e) {
			msg = "메일 발송에 실패했습니다.";
			resultCode = "F-2";
			e.printStackTrace();
		}
		return Maps.of("msg", msg, "resultCode", resultCode);
	}

	public Map<String, Object> searchPw(Map<String, Object> param) {
		Member member = memberDao.searchPw(param);
		String msg = null;
		String resultCode = null;
		MailHandler mail;
		int loginedMemberId = member.getId();
		String temporaryPassword = CUtil.getTempKey();
		param.put("temporaryPassword", temporaryPassword);
		param.put("id", loginedMemberId);
		try {
			memberDao.update(param);
			mail = new MailHandler(sender);
			mail.setFrom(emailSender, emailSenderName);
			mail.setTo((String) param.get("email"));
			mail.setSubject("회원님의 임시 비밀번호가 발송되었습니다");
			mail.setText(new StringBuffer().append("<h1>비밀번호는 " + temporaryPassword + " 입니다.</h1>").toString());
			mail.send();
			msg = "메일이 발송되었습니다.";
			resultCode = "S-2";
		} catch (Exception e) {
			msg = "메일 발송에 실패했습니다.";
			resultCode = "F-2";
			e.printStackTrace();
		}
		return Maps.of("msg", msg, "resultCode", resultCode);
	}

	public Map<String, Object> update(Map<String, Object> args) {

		Map<String, Object> rs = new HashMap<String, Object>();

		memberDao.update(args);

		rs.put("resultCode", "S-1");

		rs.put("msg", "회원정보가 수정되었습니다.");

		return rs;
	}

	public Map<String, Object> updateAuthStatus(Map<String, Object> param) {
		Member member = memberDao.getEmailMember(param);
		String msg = "";
		String resultCode = "";
		if (member == null) {
			msg = "업데이트에 실패했습니다.";
			resultCode = "F-5";
		} else {
			memberDao.updateAuthStatus(param);
			msg = "업데이트에 성공했습니다.";
			resultCode = "S-5";
		}

		return Maps.of("msg", msg, "resultCode", resultCode);
	}

	public Map<String, Object> updateDelStatus(Map<String, Object> param) {

		Map<String, Object> rs = new HashMap<String, Object>();

//		memberDao.updateDelStatus(param);

		rs.put("resultCode", "S-1");
		rs.put("msg", "관리자에게 문의하세요.");

		return rs;
	}

	@Override
	public boolean isMasterMember(long loginedMemberId) {
		Member member = memberDao.getOne(loginedMemberId);
		return member.getPermissionLevel() > 1;
	}

	@Override
	public Map<String, Object> login(Map<String, Object> param, HttpServletRequest request) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int userIdCheck(String loginId) {
		// TODO Auto-generated method stub
		return memberDao.checkOverId(loginId);
	}

	@Override
	public int userNameCheck(String name) {
		// TODO Auto-generated method stub
		return memberDao.checkOverName(name);
	}

	@Override
	public List<Member> getList(Map<String, Object> param) {
		return memberDao.getList(param);
	}

	@Override
	public void stop(int id) {
		memberDao.stop(id);
	}

	@Override
	public void stopCancel(int id) {
		memberDao.stopCancel(id);		
	}

	@Override
	public int userbeforePwCheck(String beforePw) {
		return memberDao.checkOverbeforePw(beforePw);
	}
}