package com.park.gyobab.controller.main;

import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
public class HomeController{
	
	@RequestMapping(value = "/")
	public String gnb() throws Exception{
		
		return "redirect:main.do";
	}
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "main";
	}
	
	@RequestMapping(value = "fupload", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	protected String mediaUpload(HttpServletRequest request, MultipartHttpServletRequest mtf) throws IllegalStateException, IOException {
		
		MultipartFile file = mtf.getFile("file");

		String oriName = file.getOriginalFilename();
		long fileSize = file.getSize();
		String ext = oriName.substring(oriName.lastIndexOf("."));
		String stoName = UUID.randomUUID()+ext;
		String filePath = "/home/parksc0710/serv/image/webapps/ROOT/images/";
		
		file.transferTo(new File(filePath,stoName));
		
		System.out.println(stoName);

		return stoName;
	}
	
}
