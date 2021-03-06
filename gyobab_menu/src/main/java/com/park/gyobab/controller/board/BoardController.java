package com.park.gyobab.controller.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.park.gyobab.domain.BoardCommentVO;
import com.park.gyobab.domain.BoardLikeVO;
import com.park.gyobab.domain.BoardVO;
import com.park.gyobab.domain.Criteria;
import com.park.gyobab.domain.MemberVO;
import com.park.gyobab.service.BoardCommentService;
import com.park.gyobab.service.BoardLikeService;
import com.park.gyobab.service.BoardService;
import com.park.gyobab.service.MemberService;

@Controller
@RequestMapping(value = "/board")
public class BoardController {
	
	@Autowired
    private BoardService boardService;
	
	@Autowired
    private BoardLikeService boardLikeService;
	
	@Autowired
    private MemberService memberService;
	
	@Autowired
    private BoardCommentService boardCommentService;
	
	private static final String BOARD_TYPE_NOTICE = "notice";
	private static final String BOARD_TYPE_MENU = "menu";
	private static final String BOARD_TYPE_FREE = "free";
	private static final String BOARD_TYPE_HUMOR = "humor";
	private static final String BOARD_TYPE_RESTAURANT = "restaurant";
	
	private String checkBoardType(String inBoardType) {
		String rtn = "";
		if(inBoardType.equalsIgnoreCase(BOARD_TYPE_NOTICE)) {
			rtn = BOARD_TYPE_NOTICE;
		} else if(inBoardType.equalsIgnoreCase(BOARD_TYPE_FREE)) {
			rtn = BOARD_TYPE_FREE;
		} else if(inBoardType.equalsIgnoreCase(BOARD_TYPE_MENU)) {
			rtn = BOARD_TYPE_MENU;
		} else if(inBoardType.equalsIgnoreCase(BOARD_TYPE_HUMOR)) {
			rtn = BOARD_TYPE_HUMOR;
		} else if(inBoardType.equalsIgnoreCase(BOARD_TYPE_RESTAURANT)) {
			rtn = BOARD_TYPE_RESTAURANT;
		} else {
			rtn = BOARD_TYPE_FREE;
		}
		return rtn;
	}
	
	@RequestMapping(value = "/{boardType}", method = RequestMethod.GET)
	public String main(Model model,
			@PathVariable("boardType") String boardType,
			@RequestParam(value = "boardCate", required = false, defaultValue = "") String boardCate,
			@RequestParam(value = "pageSize", required = false, defaultValue = "10") int pageSize,
			@RequestParam(value = "pageNum", required = true, defaultValue = "1") int pageNum,
			@RequestParam(value = "bid", required = false, defaultValue = "0") int board_id
		) throws Exception {
		
		boardType = checkBoardType(boardType);
		
		if(pageNum == 0) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("board_type", boardType);
			map.put("board_cate", boardCate);
			map.put("board_id", board_id);
			
			HashMap<String, Object> tmpMap = boardService.selectBoardByIdWithOutPage(map);
			int rownum = Integer.parseInt(String.valueOf(tmpMap.get("ROWNUM")).split("\\.")[0]);
			pageNum = (rownum/10)+1;
		}
		
		Criteria cri = new Criteria(pageNum, pageSize);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("board_type", boardType);
		map.put("board_cate", boardCate);
		map.put("cri", cri);
		
		// ??? ?????? ?????????
		HashMap<String, Object> cntMap = new HashMap<String, Object>();
		cntMap.put("board_type", boardType);
		cntMap.put("board_cate", boardCate);
		int totalCnt = boardService.selectBoardCnt(cntMap);
		
		// ????????? ????????? ?????????
		List<BoardVO> list = boardService.selectBoards(map);
		
		// ????????? ????????? ?????????, ????????? ????????? ?????????
		Map<BoardVO, Integer> likes = new HashMap<BoardVO, Integer>();
		Map<BoardVO, Integer> comments = new HashMap<BoardVO, Integer>();
		
		for(int i = 0; i < list.size(); i++) {
			Integer likeCnt = boardLikeService.selectBoardLikeCnt(list.get(i).getBoard_id());
			likes.put(list.get(i), likeCnt);
		}
		
		for(int i = 0; i < list.size(); i++) {
			Integer commentCnt = boardCommentService.selectBoardCommentCntWithBoardId(list.get(i).getBoard_id());
			comments.put(list.get(i), commentCnt);
		}
		
		BoardVO inBoard = null;
		List<BoardLikeVO> inBoardLike = null;
		List<BoardCommentVO> inBoardComment = null;
		
		// bid ????????? DB ??????
		if(board_id > 0) {
			boardService.updateViewCnt(board_id);
			inBoard = boardService.selectBoardById(board_id);
			inBoardLike = boardLikeService.selectBoardLikes(board_id);
			inBoardComment = boardCommentService.selectBoardComments(board_id);
		}
				
		// ??????????????? ?????? ???????????? ??? ????????? ???????????? ?????????
		if(boardType.equalsIgnoreCase(BOARD_TYPE_MENU) && board_id == 0 && pageNum == 1) {
			inBoard = boardService.selectTop1Board(boardType);
			board_id = inBoard.getBoard_id();
			boardService.updateViewCnt(board_id);
			inBoardLike = boardLikeService.selectBoardLikes(board_id);
			inBoardComment = boardCommentService.selectBoardComments(board_id);
		}
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("totalCnt", totalCnt);
		
		model.addAttribute("board_id", board_id);
		model.addAttribute("board_cate", boardCate);
		
		model.addAttribute("inBoard", inBoard);
		model.addAttribute("inBoardLike", inBoardLike);
		model.addAttribute("inBoardComment", inBoardComment);
		
		model.addAttribute("list", list);
		model.addAttribute("likes", likes);
		model.addAttribute("comments", comments);
		
		return "board/main";
	}
	
	@Secured({"ROLE_OPERATOR", "ROLE_ADMIN", "ROLE_USER"})
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String insert(Model model, HttpServletRequest req, @RequestParam(value = "boardType", required = true) String boardType) throws Exception {
		
		boardType = checkBoardType(boardType);
		
		model.addAttribute("boardType", boardType);
		
		return "board/insert";
	}
	
	@Secured({"ROLE_OPERATOR", "ROLE_ADMIN", "ROLE_USER"})
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	@ResponseBody
	public String insert(Model model, HttpServletRequest req,
			@RequestParam(value = "boardType", required = true) String boardType,
			@RequestParam(value = "boardCate", required = true) String boardCate,
			@RequestParam(value = "boardTit", required = true) String boardTit,
			@RequestParam(value = "boardTxt", required = true) String boardTxt,
			@RequestParam(value = "boardMember", required = true) int boardMember
			) throws Exception {
		
		String rtn = "";
		
		// ???????????? ????????? ?????? ?????? ??????
		if(boardType.equalsIgnoreCase(BOARD_TYPE_NOTICE) && !req.isUserInRole("ROLE_OPERATOR")) {
			return rtn;
		} 
		
		MemberVO tmpMember = memberService.selectMemberById(boardMember);
		BoardVO tmp = new BoardVO();
		tmp.setBoard_type(boardType);
		tmp.setBoard_cate(boardCate);
		tmp.setBoard_tit(boardTit);
		tmp.setBoard_txt(boardTxt);
		tmp.setMemberVO(tmpMember);
		boardService.insertBoard(tmp);
		
		return rtn;
	}
	
	@Secured({"ROLE_OPERATOR", "ROLE_ADMIN", "ROLE_USER"})
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public String update(Model model, @RequestParam(value = "boardid", required = true) int boardId,
			@RequestParam(value = "pageNum", required = true, defaultValue = "1") int pageNum,
			@RequestParam(value = "boardType", required = true) String boardType
			) throws Exception {
		
		MemberVO nowUser = (MemberVO) (SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		
		BoardVO inBoard = boardService.selectBoardById(boardId);
		
		if(nowUser.getMember_id() == inBoard.getMemberVO().getMember_id()) {
			String tmp = inBoard.getBoard_txt().replace("<br/>", "\r\n");
			inBoard.setBoard_txt(tmp);
			String boardCate = inBoard.getBoard_cate();
			model.addAttribute("inBoard", inBoard);
			model.addAttribute("pageNum", pageNum);
			model.addAttribute("boardType", boardType);
			model.addAttribute("boardCate", boardCate);
			return "board/update";
		} else {
			return "board/main";
		}
		
	}
	
	@Secured({"ROLE_OPERATOR"})
	@RequestMapping(value = "/updateOperator", method = RequestMethod.GET)
	public String updateOperator(Model model, @RequestParam(value = "boardid", required = true) int boardId,
			@RequestParam(value = "pageNum", required = true, defaultValue = "1") int pageNum,
			@RequestParam(value = "boardType", required = true) String boardType) throws Exception {
		
		BoardVO inBoard = boardService.selectBoardById(boardId);
		
		String tmp = inBoard.getBoard_txt().replace("<br/>", "\r\n");
		inBoard.setBoard_txt(tmp);
		String boardCate = inBoard.getBoard_cate();
		
		model.addAttribute("inBoard", inBoard);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardCate", boardCate);
		
		return "board/update";
	}
	
	
	@Secured({"ROLE_OPERATOR", "ROLE_ADMIN", "ROLE_USER"})
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public String update(Model model,
			@RequestParam(value = "boardTit", required = true) String boardTit,
			@RequestParam(value = "boardTxt", required = true) String boardTxt,
			@RequestParam(value = "boardId", required = true) int boardId,
			@RequestParam(value = "boardCate", required = true) String boardCate
			) throws Exception {
		
		String rtn = "";
		
		BoardVO tmp = boardService.selectBoardById(boardId);
		tmp.setBoard_tit(boardTit);
		tmp.setBoard_txt(boardTxt);
		tmp.setBoard_cate(boardCate);
		boardService.updateBoard(tmp);
		
		return rtn;
	}
	
	
	@Secured({"ROLE_OPERATOR", "ROLE_ADMIN", "ROLE_USER"})
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

	@RequestMapping(value = "/insertLike", method = RequestMethod.POST)
	@ResponseBody
	public String insertLike(Model model,
			@RequestParam(value = "boardId", required = true) int boardId
			) throws Exception {
		
		String rtn = "";
		
		MemberVO nowUser = null; 
		
		try {
			nowUser = (MemberVO) (SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		} catch (Exception e) {
			System.out.println("???????????? ???????????? ????????? ??????");
		}
		
		if(nowUser == null) {
			rtn = "fail";
		} else {
			int member_id = nowUser.getMember_id();
			
			HashMap<String, Integer> map = new HashMap<String, Integer>();
			map.put("member_id", member_id);
			map.put("board_id", boardId);
			
			boardLikeService.insertBoardLike(map);
			
			rtn = "suc";
		}
		
		return rtn;
	}
	
	@RequestMapping(value = "/deleteLike", method = RequestMethod.POST)
	@ResponseBody
	public String deleteLike(Model model,
			@RequestParam(value = "boardId", required = true) int boardId
			) throws Exception {
		
		String rtn = "";
		
		MemberVO nowUser = null; 
		
		try {
			nowUser = (MemberVO) (SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		} catch (Exception e) {
			System.out.println("???????????? ???????????? ????????? ?????? ??????");
		}
		
		if(nowUser == null) {
			rtn = "fail";
		} else {
			int member_id = nowUser.getMember_id();
			
			HashMap<String, Integer> map = new HashMap<String, Integer>();
			map.put("member_id", member_id);
			map.put("board_id", boardId);
			
			boardLikeService.deleteBoardLike(map);
			
			rtn = "suc";
		}
		
		return rtn;
	}
	
}
