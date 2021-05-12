package com.park.gyobab.controller.menu;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.park.gyobab.domain.BoardVO;
import com.park.gyobab.domain.MemberVO;
import com.park.gyobab.service.BoardService;
import com.park.gyobab.service.MemberService;

@Controller
@RequestMapping(value = "/menu")
public class MenuController {
	
	@Autowired
    private BoardService boardService;
	
	@Autowired
    private MemberService memberService;
	
	String boardType = "1";
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main(Model model) throws Exception {
		
		List<BoardVO> list = boardService.selectBoards(boardType);
		
		model.addAttribute("list", list);
		
		return "menu/main";
	}
	
	@Secured({"ROLE_OPERATOR", "ROLE_ADMIN"})
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String insert(Model model) throws Exception {
		
		return "menu/insert";
	}
	
	@Secured({"ROLE_OPERATOR", "ROLE_ADMIN"})
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	@ResponseBody
	public String insert(Model model,
			@RequestParam(value = "boardType", required = true) String boardType,				
			@RequestParam(value = "boardTit", required = true) String boardTit,
			@RequestParam(value = "boardThumb", required = true) String boardThumb,
			@RequestParam(value = "boardTxt", required = true) String boardTxt,
			@RequestParam(value = "boardMember", required = true) int boardMember
			) throws Exception {
		
		String rtn = "";
		
		MemberVO tmpMember = memberService.selectMemberById(boardMember);
		BoardVO tmp = new BoardVO();
		tmp.setBoard_type(boardType);
		tmp.setBoard_tit(boardTit);
		tmp.setBoard_thumb(boardThumb);
		tmp.setBoard_txt(boardTxt);
		tmp.setMemberVO(tmpMember);
		boardService.insertBoard(tmp);
		
		return rtn;
	}
	
	@Secured({"ROLE_OPERATOR", "ROLE_ADMIN"})
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public String update(Model model, @RequestParam(value = "boardid", required = true) int boardId) throws Exception {
		
		MemberVO nowUser = (MemberVO) (SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		
		BoardVO inBoard = boardService.selectBoardById(boardId);
		
		if(nowUser.getMember_id() == inBoard.getMemberVO().getMember_id()) {
			String tmp = inBoard.getBoard_txt().replace("<br/>", "\r\n");
			inBoard.setBoard_txt(tmp);
			model.addAttribute("inBoard", inBoard);
			return "menu/update";
		} else {
			return "main";
		}
		
	}
	
	@Secured({"ROLE_OPERATOR"})
	@RequestMapping(value = "/updateOperator", method = RequestMethod.GET)
	public String updateOperator(Model model, @RequestParam(value = "boardid", required = true) int boardId) throws Exception {
		
		BoardVO inBoard = boardService.selectBoardById(boardId);
		
		String tmp = inBoard.getBoard_txt().replace("<br/>", "\r\n");
		inBoard.setBoard_txt(tmp);
		
		model.addAttribute("inBoard", inBoard);
		
		return "menu/update";
	}
	
	
	@Secured({"ROLE_OPERATOR", "ROLE_ADMIN"})
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public String update(Model model,
			@RequestParam(value = "boardTit", required = true) String boardTit,
			@RequestParam(value = "boardThumb", required = true) String boardThumb,
			@RequestParam(value = "boardTxt", required = true) String boardTxt,
			@RequestParam(value = "boardId", required = true) int boardId
			) throws Exception {
		
		String rtn = "";
		
		BoardVO tmp = boardService.selectBoardById(boardId);
		tmp.setBoard_tit(boardTit);
		tmp.setBoard_thumb(boardThumb);
		tmp.setBoard_txt(boardTxt);
		boardService.updateBoard(tmp);
		
		return rtn;
	}
	
	
	@Secured({"ROLE_OPERATOR", "ROLE_ADMIN"})
	@RequestMapping(value = "deleteBoard", produces = "application/json;charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public String deleteMember( 
			@RequestParam(value = "boardId", required = true) int board_id) throws Exception {
		
		String rtn = "";
		
		//System.out.println("email : " + email + " // nickname : " + nickname);
		//MemberVO tmp = memberService.selectMemberById(memberId);
		//memberService.deleteMember(tmp);
		boardService.deleteBoard(board_id);
		rtn = "success";
		
		return rtn;
	}

}