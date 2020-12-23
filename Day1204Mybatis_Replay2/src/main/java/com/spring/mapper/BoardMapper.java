package com.spring.mapper;

import java.util.HashMap;
import java.util.List;

import com.spring.mb2replay.board.BoardVO;
import com.spring.mb2replay.member.MemberVO;

public interface BoardMapper {
	public int getListCount();
	public List<BoardVO> getBoardList(HashMap<String, Integer>hashmap);
	public BoardVO getDetail(int num);
	public int boardInsert(BoardVO board);
	public int boardReplyupdate(BoardVO board);
	public int boardReply(BoardVO board);
	public int boardModify(BoardVO board);
	public int boardDelete(int num);
	public void setReadCountUpdate(int num);
	public int isBoardWriter(HashMap<String,String> hashmap);

}
