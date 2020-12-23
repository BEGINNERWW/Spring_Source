package com.spring.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import com.spring.mb2replay.board.BoardVO;
import com.spring.mb2replay.member.MemberVO;

public interface Mapper {
	
	//BOARD 
	int getListCount();
	ArrayList<BoardVO> getBoardList(BoardVO board);
	BoardVO selectBoard(int num);
	int boardPre();
	int boardInsert(BoardVO board);
	void boardReply(BoardVO board);
	void boardModify(BoardVO board);
	void setReadCountUpdate(int num);
	void boardDelete(BoardVO board);
	
	//MEMBER
	ArrayList<MemberVO> getMemberlist();
	MemberVO selectMember(MemberVO memberVO);
	int insertMember(MemberVO member);
	int updateMember(MemberVO member);
	int deleteMember(String id);
}
