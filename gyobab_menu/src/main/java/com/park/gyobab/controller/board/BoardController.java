package com.park.gyobab.controller.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
	private static final String BOARD_TYPE_FREE = "free";
	
	@RequestMapping(value = "/{type}", method = RequestMethod.GET)
	public String main(Model model,
			@PathVariable("type") String boardType, 
			@RequestParam(value = "pageSize", required = true, defaultValue = "10") int pageSize,
			@RequestParam(value = "pageNum", required = true, defaultValue = "1") int pageNum
		) throws Exception {
		
		if(boardType.equalsIgnoreCase(BOARD_TYPE_NOTICE)) {
			boardType = BOARD_TYPE_NOTICE;
		} else if(boardType.equalsIgnoreCase(BOARD_TYPE_FREE)) {
			boardType = BOARD_TYPE_FREE;
		} else {
			boardType = BOARD_TYPE_NOTICE;
		}
		
		model.addAttribute("boardType", boardType);
		
		return "board/main";
	}
	
}
