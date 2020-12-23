package com.spring.mb2replay.comment;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController //���ϰ��� �䰡 �ƴ� �����͸� �����Ѵ� >> ��� �����͸� �ٷ� �����ϰ��� �Ҷ� ��� // ��Ʈ�ѷ��� �Ϸ��Ҷ���  @ResponseBody ����ؾ� �����Ͱ����� ���� ����
public class CommentController {
	
	@Autowired
	CommentService commentservice;
	
	@RequestMapping(value="/comment_list.bo", produces="application/json;charset=utf-8") //��۸���Ʈ
	private List<CommentVO> CommentServiceList(@RequestParam int bno) throws Exception{
		List<CommentVO> comment_list = commentservice.commentList(bno);
		
		return comment_list;
	}
	//include�ؼ� @ResponseBody �� ����(ajax �ƴ�)
	
	@RequestMapping(value="/comment_insert.bo", produces="application/json;charset=utf-8") //��۸���Ʈ
	private int CommentInsert(CommentVO comment, HttpSession session) throws Exception{
		comment.setWriter((String)session.getAttribute("id"));
		
		return commentservice.commentInsert(comment);
	}
	@RequestMapping(value="/comment_update.bo", produces="application/json;charset=utf-8") //��۸���Ʈ
	private int CommentUpdate(CommentVO comment) throws Exception{
				
		return commentservice.commentUpdate(comment);
	}
	
	/*@RequestMapping(value="/comment_update.bo", produces="application/json;charset=utf-8") //��۸���Ʈ
	private int CommentUpdate(@RequestParam int cno, @RequestParam String content) throws Exception{
		CommentVO comment = new CommentVO();
		comment.setCno(cno);
		comment.setContent(content);
		
		return commentservice.commentUpdate(comment);
	}*/
	
	@RequestMapping(value="/comment_delete.bo", produces="application/json;charset=utf-8") //��۸���Ʈ
	private int CommentDelete(@RequestParam(value="cno") int cno) throws Exception{
		
		return commentservice.commentDelete(cno);
	}
}
