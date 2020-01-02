package com.sejong.namu.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sejong.namu.dto.ChatMessage;
import com.sejong.namu.dto.Member;

@Controller
public class ChatController {
	private List<ChatMessage> messages;

	ChatController() {
		messages = new ArrayList<>();
	}

	@RequestMapping("/chat/main")
	public String showMain(HttpServletRequest req, Model model) {
		Member loginedMember = (Member)req.getAttribute("loginedMember");
		
		model.addAttribute("loginedMemberName", loginedMember.getName());
		
		return "chat/main";
	}

	@RequestMapping("/chat/addMessage")
	@ResponseBody
	public String addMessage(String writer, String body) {
		// 3가지
		// 번호
		// 작성자
		// 내용
		StringBuilder sb = new StringBuilder();
		writer = writer.trim();
		body = body.trim();
		if (writer.length() == 0) {
			sb.append("<script>");
			sb.append(" alert('닉네임을 입력하세요.');");
			sb.append(" location.href='/chat/main';");
			sb.append("</script>");
			return sb.toString();
		} else if (body.length() == 0) {
			sb.append("<script>");
			sb.append(" alert('내용을 입력하세요.');");
			sb.append(" location.href='/chat/main';");
			sb.append("</script>");
			return sb.toString();
		}
		long id = messages.size();
		ChatMessage newChatMessage = new ChatMessage(id, writer, body);
		messages.add(newChatMessage);

		return sb.toString();
	}

	@RequestMapping("/chat/getAllMessages")
	@ResponseBody
	public List<ChatMessage> getAllMessages() {
		return messages;
	}

	@RequestMapping("/chat/getMessages")
	@ResponseBody
	public List<ChatMessage> getAllMessages(int from) {
		return messages.subList(from, messages.size());
	}

	@RequestMapping("/chat/clearMessages")
	@ResponseBody
	public Map clearMessages() {
		messages.clear();

		Map rs = new HashMap<String, Object>();
		rs.put("msg", "모든 메세지가 삭제되었습니다.");
		rs.put("resultCode", "S-1");

		return rs;
	}
}