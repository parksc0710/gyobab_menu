package com.park.gyobab.controller.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.park.gyobab.domain.MemberVO;
import com.park.gyobab.service.MemberService;

@Controller
@Secured("ROLE_OPERATOR")
@RequestMapping(value = "/ou")
public class OperatorUserController {

	@Autowired
    private MemberService service;
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main(Model model) throws Exception {
		List<MemberVO> list = service.selectMembers();
		
		model.addAttribute("list", list);
		
		return "user/operator/main";
	}
	
	
}
