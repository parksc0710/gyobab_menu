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
	protected String mediaUpload(HttpServletRequest request) {
		
		String rtn = "false";
		
		UUID uuid = UUID.randomUUID();
		
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest)request;
		Iterator<String> fileIterator = mpRequest.getFileNames();
		
		List<String> fileNames = new ArrayList<String>();

		File dirname = new File("/home/parksc0710/serv/tc1/webapps/ROOT/assets/images/upload/");

		while(fileIterator.hasNext()) {
			
			MultipartFile file = mpRequest.getFile(fileIterator.next());
			
			if(file.getSize() <= 10*1024*1024) {
				if(!file.isEmpty() && file.getSize() > 0) {
	
					String filename = null;
					File storeFile = null;

					int fnum = 0;
						do {
							if(fnum == 0)
								filename = uuid + file.getOriginalFilename();
							else
								filename = Integer.toString(fnum) + uuid + file.getOriginalFilename();
								
							storeFile = new File(dirname, filename);
							fnum++;
						}
						while(storeFile.exists());
					
					try {
						FileUtils.copyInputStreamToFile(file.getInputStream(), storeFile);
						storeFile.setReadable(true, false);						
						
						fileNames.add("resources/upload/" + filename);
						rtn = "true";
					}
					catch(IOException e) {
						System.out.println(e.getMessage());
					}
				}
				else {
					fileNames.add("");
				}
			}
		}
		
		return rtn;
	}
	
}
