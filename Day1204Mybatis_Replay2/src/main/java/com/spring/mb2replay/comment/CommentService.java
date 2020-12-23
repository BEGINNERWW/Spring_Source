package com.spring.mb2replay.comment;

import java.util.List;

public interface CommentService {

	public int commentCount() throws Exception; // ´ñ±Û°³¼ö
	public List<CommentVO> commentList(int bno) throws Exception;
	public int commentInsert(CommentVO comment) throws Exception;
	public int commentUpdate(CommentVO comment) throws Exception;
	public int commentDelete(int cno) throws Exception;
}
