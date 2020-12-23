package com.spring.mb2replay.board;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.mapper.BoardMapper;

@Service("boardService")
public class BoardServiceImpl implements BoardService {

	BoardMapper mapper = null;
	
	@Autowired
	public BoardServiceImpl(SqlSession sqlSession) {
	     this.mapper = sqlSession.getMapper(BoardMapper.class);
	}
	   
	@Override
	public int getListCount() {
		int res= mapper.getListCount();
		return res;
	}
	@Override
	 public List<BoardVO> getBoardList(HashMap<String, Integer> hashmap) {
	  List<BoardVO> boardlist = mapper.getBoardList(hashmap);
	  
	  return boardlist;
	 }
	@Override
	public BoardVO getDetail(int num) {
		mapper.setReadCountUpdate(num);
		BoardVO board = mapper.getDetail(num);
		return board;
	}

	@Override
	 public int boardInsert(BoardVO board) {
	  int res = mapper.boardInsert(board);
	  
	  return res;
	 }

	@Override
	public int boardReply(BoardVO board) {
		mapper.boardReplyupdate(board);
		board.setRe_seq(board.getRe_seq()+1);
		board.setRe_lev(board.getRe_lev()+1);
		int res= mapper.boardReply(board);
		
		return 0;
	}
	
	@Override
	public BoardVO boardModifyForm(int num) {
		BoardVO board = mapper.getDetail(num);
		return board;
	}
	
	@Override
	public int boardModify(BoardVO modifyboard) {
		int res =  mapper.boardModify(modifyboard);
		
		return res;
		//boolean res =  boardDAO.boardModify(modifyboard);
		//return res;
	}

	@Override
	public int boardDelete(HashMap<String,String> hashmap) {
		int res =  mapper.isBoardWriter(hashmap);
		int num = Integer.parseInt(hashmap.get("num"));
		if (res == 1) {
			res =  mapper.boardDelete(num);
		}
		return res;
	}
}
