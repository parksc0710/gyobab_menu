package com.park.gyobab.controller.menu;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "/menu")
public class MenuController{
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main() throws Exception {
		return "redirect:../main.do";
	}
	
}