package com.sejong.namu.service;

import java.util.List;
import java.util.Map;

import com.sejong.namu.dto.Article;
import com.sejong.namu.dto.ArticleReply;
import com.sejong.namu.dto.Board;

public interface ArticleService {
	public List<Article> getList(Map<String, Object> args);

	public int getCount(Map<String, Object> args);

	public Map<String, Object> getPagedList(Map<String, Object> param);

	public List<ArticleReply> getReplies(Map<String, Object> args);

	public Article getOne(Map<String, Object> args);

	public ArticleReply getReply(Map<String, Object> args);

	public Article getBoardId(Map<String, Object> args);

	public long add(Map<String, Object> args);

	public long addReply(Map<String, Object> args);

	public Map<String, Object> modify(Map<String, Object> args);

	public Map<String, Object> updateReply(Map<String, Object> args);

	public Map<String, Object> delete(Map<String, Object> args);

	public Map<String, Object> deleteReply(Map<String, Object> args);

	public Map<String, Object> checkModifyPermmision(long id, long loginedMemberId);

	public Map<String, Object> checkDeletePermmision(long id, long loginedMemberId);

	public Board getBoard(long boardId);
}