package com.spring.mb2replay.comment;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController //리턴값이 뷰가 아닌 데이터를 전달한다 >> 뷰로 데이터를 바로 전달하고자 할때 사용 // 컨트롤러로 하려할때는  @ResponseBody 사용해야 데이터값으로 전달 가능
public class CommentController {
	
	@Autowired
	CommentService commentservice;
	
	@RequestMapping(value="/comment_list.bo", produces="application/json;charset=utf-8") //댓글리스트
	private List<CommentVO> CommentServiceList(@RequestParam int bno) throws Exception{
		List<CommentVO> comment_list = commentservice.commentList(bno);
		
		return comment_list;
	}
	//include해서 @ResponseBody 가 없음(ajax 아님)
	
	@RequestMapping(value="/comment_insert.bo", produces="application/json;charset=utf-8") //댓글리스트
	private int CommentInsert(CommentVO comment, HttpSession session) throws Exception{
		comment.setWriter((String)session.getAttribute("id"));
		
		return commentservice.commentInsert(comment);
	}
	@RequestMapping(value="/comment_update.bo", produces="application/json;charset=utf-8") //댓글리스트
	private int CommentUpdate(CommentVO comment) throws Exception{
				
		return commentservice.commentUpdate(comment);
	}
	
	/*@RequestMapping(value="/comment_update.bo", produces="application/json;charset=utf-8") //댓글리스트
	private int CommentUpdate(@RequestParam int cno, @RequestParam String content) throws Exception{
		CommentVO comment = new CommentVO();
		comment.setCno(cno);
		comment.setContent(content);
		
		return commentservice.commentUpdate(comment);
	}*/
	
	@RequestMapping(value="/comment_delete.bo", produces="application/json;charset=utf-8") //댓글리스트
	private int CommentDelete(@RequestParam(value="cno") int cno) throws Exception{
		
		return commentservice.commentDelete(cno);
	}
}
