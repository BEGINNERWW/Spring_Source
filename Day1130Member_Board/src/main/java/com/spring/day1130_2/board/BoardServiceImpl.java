package com.spring.day1130_2.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("boardService")
public class BoardServiceImpl implements BoardService {

	@Autowired(required=false) 
	private BoardDAO boardDAO=null;
	
	@Override
	public int getListCount() {
		int res = boardDAO.getListCount();
		return res;
	}

	@Override
	public List<BoardVO> getBoardList(int page, int limit) {
		List<BoardVO> boardlist = boardDAO.getBoardList(page, limit);
		return boardlist;
	}

	@Override
	public BoardVO getDetail(int num) {
		boardDAO.setReadCountUpdate(num);
		BoardVO board = boardDAO.getDetail(num);
		return board;
	}

	@Override
	public boolean boardInsert(BoardVO board) {
		boolean res = boardDAO.boardInsert(board);
		return res;
	}

	@Override
	public int boardReply(BoardVO board) {
		int res = boardDAO.boardReply(board);
		return res;
	}
	
	@Override
	public BoardVO boardModifyForm(int num) {
		BoardVO board = boardDAO.getDetail(num);
		return board;
	}
	
	@Override
	public boolean boardModify(BoardVO modifyboard) {
		boolean res =  boardDAO.isBoardWriter(modifyboard.getNum(), modifyboard.getId());
		if (res == true) {
			res =  boardDAO.boardModify(modifyboard);
		}
		return res;
		//boolean res =  boardDAO.boardModify(modifyboard);
		//return res;
	}

	@Override
	public boolean boardDelete(int num, String id) {
		boolean res =  boardDAO.isBoardWriter(num, id);
		if (res == true) {
			res =  boardDAO.boardDelete(num);
		}
		return res;
	}
}
