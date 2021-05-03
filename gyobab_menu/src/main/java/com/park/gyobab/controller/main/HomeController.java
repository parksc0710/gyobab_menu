package com.park.gyobab.controller.main;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.park.gyobab.domain.MemberVO;

@Controller
public class HomeController{
	
	@RequestMapping(value = "/")
	public String gnb() throws Exception{
		
		return "redirect:main.do";
	}
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(auth != null) {
			MemberVO nowUser = (MemberVO) (SecurityContextHolder.getContext().getAuthentication().getPrincipal());
			System.out.println(nowUser.getMember_email() + " // " + nowUser.getMember_grant());
		} else {
			System.out.println("nowUser is null");
		}
		
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "main";
	}
	
}
