package com.park.gyobab.controller.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
import com.park.gyobab.domain.Criteria;
import com.park.gyobab.domain.MemberVO;
import com.park.gyobab.service.BoardCommentService;
import com.park.gyobab.service.BoardLikeService;
import com.park.gyobab.service.BoardService;
import com.park.gyobab.service.MemberService;

@Controller
@Secured({"ROLE_OPERATOR", "ROLE_ADMIN", "ROLE_USER"})
@RequestMapping(value = "/user")
public class UserController {
	
	@Autowired
    private MemberService service;
	
	@Autowired
    private BoardService boardService;
	
	@Autowired
    private BoardLikeService boardLikeService;
	
	@Autowired
    private BoardCommentService boardCommentService;
	
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main(Model model) throws Exception {
		
		MemberVO nowUser = (MemberVO) (SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		
		model.addAttribute("nowUser", nowUser);
		
		return "user/main";
	}
	
	@RequestMapping(value = "update", produces = "application/json;charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public String update( 
			@RequestParam(value = "memberId", required = true) int memberId,				
			@RequestParam(value = "nickname", required = true) String nickname,
			@RequestParam(value = "memberpass", required = true) String memberpass,
			HttpServletRequest request
						) throws Exception {
		
		String rtn = "";
		
		MemberVO nowUser = (MemberVO) (SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		
		if(nowUser.getMember_id() != memberId) {
			return "false";
		}
		
		//System.out.println("email : " + email + " // nickname : " + nickname);
		MemberVO tmp = nowUser;
		tmp.setMember_name(nickname);
		tmp.setMember_pass(memberpass);
		
		service.updateMember(tmp);
		
		rtn = "success";
		return rtn;
	}
	
	@RequestMapping(value = "withdraw", produces = "application/json;charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public String withdraw( 
			@RequestParam(value = "memberId", required = true) int memberId) throws Exception {
		
		String rtn = "";
		
		MemberVO nowUser = (MemberVO) (SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		
		if(nowUser.getMember_id() != memberId) {
			return "false";
		}
		
		//System.out.println("email : " + email + " // nickname : " + nickname);
		MemberVO tmp = nowUser;
		SecurityContextHolder.clearContext();
		service.deleteMember(tmp);
		
		rtn = "success";
		return rtn;
	}
	
	@RequestMapping(value = "/board", method = RequestMethod.GET)
	public String board(Model model,
			@RequestParam(value = "pageNum", required = true, defaultValue = "1") int pageNum,
			@RequestParam(value = "pageSize", required = false, defaultValue = "10") int pageSize
		) throws Exception {
		
		MemberVO nowUser = (MemberVO) (SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		
		Criteria cri = new Criteria(pageNum, pageSize);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("member_id", nowUser.getMember_id());
		map.put("cri", cri);
		
		// 총 갯수 구하기
		HashMap<String, Object> cntMap = new HashMap<String, Object>();
		cntMap.put("member_id", nowUser.getMember_id());
		
		int totalCnt = boardService.selectBoardCntByMember(cntMap);
		
		// 게시판 리스트 구하기
		List<BoardVO> list = boardService.selectBoardsByMember(map);
		
		// 게시판 리스트 좋아요, 코멘트 카운트 구하기
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
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("totalCnt", totalCnt);
		
		model.addAttribute("nowUser", nowUser);
		
		model.addAttribute("list", list);
		model.addAttribute("likes", likes);
		model.addAttribute("comments", comments);
		
		return "user/board";
	}
	
	@RequestMapping(value = "/comment", method = RequestMethod.GET)
	public String comment(Model model,
			@RequestParam(value = "pageNum", required = true, defaultValue = "1") int pageNum,
			@RequestParam(value = "pageSize", required = false, defaultValue = "10") int pageSize
		) throws Exception {
		
		MemberVO nowUser = (MemberVO) (SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		
		Criteria cri = new Criteria(pageNum, pageSize);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("member_id", nowUser.getMember_id());
		map.put("cri", cri);
		
		// 총 갯수 구하기
		int totalCnt = boardCommentService.selectBoardCommentCntByMember(nowUser.getMember_id());
		
		// 게시판 리스트 구하기
		List<BoardCommentVO> list = boardCommentService.selectBoardCommentsByMember(map);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("totalCnt", totalCnt);
		
		model.addAttribute("nowUser", nowUser);
		
		model.addAttribute("list", list);
		
		return "user/comment";
	}
	
}
