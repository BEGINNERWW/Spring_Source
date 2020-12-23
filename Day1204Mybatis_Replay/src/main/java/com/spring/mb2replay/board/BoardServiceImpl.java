package com.spring.mb2replay.board;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.mapper.Mapper;

@Service("boardService")
public class BoardServiceImpl implements BoardService {

	Mapper mapper = null;
	
	@Autowired
	public BoardServiceImpl(SqlSession sqlSession) {
	     this.mapper = sqlSession.getMapper(Mapper.class);
	}
	   
	@Override
	public int getListCount() {
		int res = 0;
		try {
		res = mapper.getListCount();
		System.out.println("count : " + res);
		
		}catch(Exception e) {
			System.out.println("에러 : " + e.getMessage());
		}
		return res;
	}

	@Override
	public ArrayList<BoardVO> getBoardList(int page, int limit) {
		BoardVO board = new BoardVO();
		board.setStartrow((page-1)*10+1);
		System.out.println("board.startrow : " + board.getStartrow());
		board.setEndrow(board.getStartrow()+limit-1);
		ArrayList<BoardVO> boardlist = new ArrayList<BoardVO>();
		
		try {
			boardlist = mapper.getBoardList(board);
			System.out.println("넘어온데이터: "+ boardlist.get(1));
		}catch(Exception e) {
			System.out.println("getBoardList 에러 : " + e.getMessage());
		}
		
		return boardlist;
	}

	@Override
	public BoardVO getDetail(int num) {
		BoardVO board = new BoardVO();
		
		try {
			mapper.setReadCountUpdate(num);
			board = mapper.selectBoard(num);
			System.out.println("num : " + num);
		}catch(Exception e) {
			System.out.println("getDetail 에러 : " + e.getMessage());
		}
		return board;
	}

	@Override
	public boolean boardInsert(BoardVO board) {
		int res = 0, result = 0; 
		
		try {
		res = mapper.boardPre();
		System.out.println("boardInser res :" + res);
		board.setNum(res + 1);
		
		result = mapper.boardInsert(board);
		if(result == 0) {
			return false;
		} 
		return true;
		} catch(Exception e) {
			System.out.println("boardInsert 에러 : "+e);
		}
		return false;
	}

	@Override
	public int boardReply(BoardVO board) {
		
		int re_ref=board.getRe_ref();
		int re_lev=board.getRe_lev();
		int re_seq=board.getRe_seq();
		
		try {
			if(mapper.boardPre() != 0) {
				board.setNum(mapper.boardPre() + 1);
			} else {
				board.setNum(1);
			}
			System.out.println(board.getNum());
			mapper.boardReply(board);
			board.setRe_lev(re_lev+1);
			board.setRe_seq(re_seq+1);
			mapper.boardInsert(board);
			System.out.println("re_seq : " +board.getRe_seq());
		}catch(Exception e) {
			System.out.println("boardReply 에러 : "+e.getMessage());
		}
		
		return 0;
	}
	
	@Override
	public BoardVO boardModifyForm(int num) {
		BoardVO board = getDetail(num);
		return board;
	}
	
	@Override
	public boolean boardModify(BoardVO modifyboard) {
		int num = modifyboard.getNum();
		BoardVO board = new BoardVO();
		
		try {
		board = mapper.selectBoard(num);
		if(modifyboard.getId().equals(board.getId())) {
			mapper.boardModify(modifyboard);
		}
		}catch(Exception e) {
			System.out.println("글쓴이 & 수정 에러 :" + e.getMessage());
		}
		
		return true;
		//boolean res =  boardDAO.boardModify(modifyboard);
		//return res;
	}

	@Override
	public boolean boardDelete(int num, String id) {
		BoardVO board = new BoardVO();
		try {
			board = mapper.selectBoard(num);
			if(id.equals(board.getId())) {
				mapper.boardDelete(board);
			}
		}catch(Exception e) {
			System.out.println("글쓴이 & 삭제 에러 :" + e.getMessage());
		}
	
		return true;
	}
}
