package com.park.gyobab.controller.user;

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

import com.park.gyobab.domain.MemberVO;
import com.park.gyobab.service.MemberService;

@Controller
@Secured({"ROLE_OPERATOR", "ROLE_ADMIN", "ROLE_USER"})
@RequestMapping(value = "/user")
public class UserController {
	
	@Autowired
    private MemberService service;
	
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
	
}
