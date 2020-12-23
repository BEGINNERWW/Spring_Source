package com.spring.mapper;

import java.util.List;

import com.spring.mb2replay.comment.CommentVO;

public interface CommentMapper {

		public int commentCount() throws Exception; // ´ñ±Û°³¼ö
		public List<CommentVO> commentList(int bno) throws Exception;
		public int commentInsert(CommentVO comment) throws Exception;
		public int commentUpdate(CommentVO comment) throws Exception;
		public int commentDelete(int cno) throws Exception;

}
