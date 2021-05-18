package com.park.gyobab.controller.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.park.gyobab.domain.Criteria;
import com.park.gyobab.domain.MemberVO;
import com.park.gyobab.service.GrantService;
import com.park.gyobab.service.MemberService;

@Controller
@Secured("ROLE_OPERATOR")
@RequestMapping(value = "/ou")
public class OperatorUserController {

	@Autowired
    private MemberService memberService;
	
	@Autowired
    private GrantService grantService;
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main(Model model, 
			@RequestParam(value = "pageSize", required = true, defaultValue = "10") int pageSize,
			@RequestParam(value = "pageNum", required = true, defaultValue = "1") int pageNum
		) throws Exception {
		
		Criteria cri = new Criteria(pageNum, pageSize);
		
		List<MemberVO> list = memberService.selectMembers(cri);
		
		int totalCnt = memberService.selectMemberCnt();
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("totalCnt", totalCnt);
		
		model.addAttribute("list", list);
		
		return "user/operator/main";
	}
	
	@RequestMapping(value = "updateMember", produces = "application/json;charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public String updateMember( 
			@RequestParam(value = "memberId", required = true) int memberId,
			@RequestParam(value = "newGrantName", required = true) String newGrantName
			) throws Exception {
		
		String rtn = "";
		
		//System.out.println("email : " + email + " // nickname : " + nickname);
		MemberVO tmp = memberService.selectMemberById(memberId);
		int newGrantId = grantService.selectGrantIdByName(newGrantName);
		tmp.getGrantVO().setGrant_id(newGrantId);
		tmp.getGrantVO().setGrant_name(newGrantName);
		
		memberService.updateMemberGrant(tmp);
		
		rtn = "success";
		return rtn;
	}
	
	@RequestMapping(value = "deleteMember", produces = "application/json;charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public String deleteMember( 
			@RequestParam(value = "memberId", required = true) int memberId) throws Exception {
		
		String rtn = "";
		
		//System.out.println("email : " + email + " // nickname : " + nickname);
		MemberVO tmp = memberService.selectMemberById(memberId);
		memberService.deleteMember(tmp);
		
		rtn = "success";
		return rtn;
	}
	
	
}
