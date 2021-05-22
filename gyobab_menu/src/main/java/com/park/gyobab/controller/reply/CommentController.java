package com.park.gyobab.controller.reply;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.park.gyobab.domain.BoardCommentVO;
import com.park.gyobab.domain.BoardVO;
import com.park.gyobab.domain.MemberVO;
import com.park.gyobab.service.BoardCommentService;

@Controller
@RequestMapping(value = "/comment")
public class CommentController {
	
	@Autowired
    private BoardCommentService boardCommentService;
	
	@Secured({"ROLE_OPERATOR", "ROLE_ADMIN", "ROLE_USER"})
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	@ResponseBody
	public String insert(Model model,
			@RequestParam(value = "boardId", required = true) int boardId,
			@RequestParam(value = "commentTxt", required = true) String commentTxt
			) throws Exception {
		
		String rtn = "";
		
		MemberVO nowUser = null; 
		
		try {
			nowUser = (MemberVO) (SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		} catch (Exception e) {
			System.out.println("비로그인 사용자가 코멘트 입력 클릭");
		}
		
		if(nowUser == null) {
			rtn = "fail";
		} else {
			int member_id = nowUser.getMember_id();
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("board_comment_member", member_id);
			map.put("board_comment_board", boardId);
			map.put("board_comment_txt", commentTxt);
			
			boardCommentService.insertBoardComment(map);
			
			rtn = "suc";
		}
		
		return rtn;
	}
	
	@Secured({"ROLE_OPERATOR", "ROLE_ADMIN", "ROLE_USER"})
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public String delete(Model model,
			@RequestParam(value = "commentId", required = true) int commentId
			) throws Exception {
		
		String rtn = "";
		
		MemberVO nowUser = null; 
		
		try {
			nowUser = (MemberVO) (SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		} catch (Exception e) {
			System.out.println("비로그인 사용자가 코멘트 삭제 클릭");
		}
		
		BoardCommentVO inBoardComment = boardCommentService.selectBoardCommentById(commentId);
		
		if(nowUser.getGrantVO().getGrant_name().equals("OPERATOR") || nowUser.getMember_id() == inBoardComment.getMemberVO().getMember_id()) {
			boardCommentService.deleteBoardComment(commentId);
			rtn = "suc";
		} else {
			rtn = "fail";
		}
		
		return rtn;
	}
	
	@Secured({"ROLE_OPERATOR", "ROLE_ADMIN", "ROLE_USER"})
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public String update(Model model,
			@RequestParam(value = "commentId", required = true) int commentId,
			@RequestParam(value = "commentTxt", required = true) String commentTxt
			) throws Exception {
		
		String rtn = "";
		
		MemberVO nowUser = null; 
		
		try {
			nowUser = (MemberVO) (SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		} catch (Exception e) {
			System.out.println("비로그인 사용자가 코멘트 수정 클릭");
		}
		
		BoardCommentVO inBoardComment = boardCommentService.selectBoardCommentById(commentId);
		
		if(nowUser.getMember_id() == inBoardComment.getMemberVO().getMember_id() || nowUser.getGrantVO().getGrant_name().equals("OPERATOR")) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("board_comment_id", commentId);
			map.put("board_comment_txt", commentTxt);
			boardCommentService.updateBoardComment(map);
			rtn = "suc";
		} else {
			rtn = "fail";
		}
		
		return rtn;
	}
	
	@Secured({"ROLE_OPERATOR", "ROLE_ADMIN", "ROLE_USER"})
	@RequestMapping(value = "/reply", method = RequestMethod.POST)
	@ResponseBody
	public String reply(Model model,
			@RequestParam(value = "board_comment_id", required = true) int board_comment_id,
			@RequestParam(value = "replyText", required = true) String replyText
			) throws Exception {
		
		String rtn = "";
		
		MemberVO nowUser = null; 
		
		try {
			nowUser = (MemberVO) (SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		} catch (Exception e) {
			System.out.println("비로그인 사용자가 코멘트 입력 클릭");
		}
		
		if(nowUser == null) {
			rtn = "fail";
		} else {
			int member_id = nowUser.getMember_id();
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("board_comment_member", member_id);
			map.put("board_comment_id", board_comment_id);
			map.put("board_comment_txt", replyText);
			
			boardCommentService.insertBoardCommentReply(map);
			
			rtn = "suc";
		}
		
		return rtn;
	}
}
