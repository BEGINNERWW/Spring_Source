package com.spring.mb2replay.board;

import java.util.ArrayList;
import java.util.List;

public interface BoardService {
	public int getListCount();
	public ArrayList<BoardVO> getBoardList(int page, int limit);
	public BoardVO getDetail(int num);
	public boolean boardInsert(BoardVO board);
	public int boardReply(BoardVO board);
	public BoardVO boardModifyForm(int num);
	public boolean boardModify(BoardVO modifyboard);
	public boolean boardDelete(int num, String id);
}
