package com.spring.mb2replay.comment;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.mapper.CommentMapper;

@Service("mCommentService")
public class CommentServiceImp implements CommentService {
	
	CommentMapper mapper = null;
	
	@Autowired
	public CommentServiceImp(SqlSession sqlSession) {
	     this.mapper = sqlSession.getMapper(CommentMapper.class);
	}
	
	@Override
	public int commentCount() throws Exception {
		return mapper.commentCount();
	}

	@Override
	public List<CommentVO> commentList(int bno) throws Exception {
		return mapper.commentList(bno);
	}

	@Override
	public int commentInsert(CommentVO comment) throws Exception {
		
		return mapper.commentInsert(comment);
	}

	@Override
	public int commentUpdate(CommentVO comment) throws Exception {
		
		return mapper.commentUpdate(comment);
	}

	@Override
	public int commentDelete(int cno) throws Exception {

		return mapper.commentDelete(cno);
	}

}
