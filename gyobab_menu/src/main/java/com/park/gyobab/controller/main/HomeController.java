package com.park.gyobab.controller.main;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.mortennobel.imagescaling.AdvancedResizeOp;
import com.mortennobel.imagescaling.MultiStepRescaleOp;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.park.gyobab.domain.BoardCommentVO;
import com.park.gyobab.domain.BoardLikeVO;
import com.park.gyobab.domain.BoardVO;
import com.park.gyobab.service.BoardCommentService;
import com.park.gyobab.service.BoardLikeService;
import com.park.gyobab.service.BoardService;

@Controller
public class HomeController{
	
	@Autowired
    private BoardService boardService;
	
	@Autowired
    private BoardLikeService boardLikeService;
	
	@Autowired
    private BoardCommentService boardCommentService;
	
	@RequestMapping(value = "/")
	public String gnb() throws Exception{
		
		return "redirect:main.do";
	}
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String home(Locale locale, Model model) throws Exception {
		
		
		String board_type = "menu";
		BoardVO topMenu = boardService.selectTop1Board(board_type);
		List<BoardLikeVO> likelist = boardLikeService.selectBoardLikes(topMenu.getBoard_id());
		List<BoardCommentVO> commentlist = boardCommentService.selectBoardComments(topMenu.getBoard_id());
		
		model.addAttribute("topMenu", topMenu);
		model.addAttribute("likelist", likelist);
		model.addAttribute("commentlist", commentlist);
		
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
		String filePath = "/home/parksc0710/images/";
		
		file.transferTo(new File(filePath,stoName));
		
		//System.out.println(stoName);

		return stoName;
	}
	
	@RequestMapping(value = "fuploadBoard", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	protected String mediaUploadBoard(HttpServletRequest request, MultipartHttpServletRequest mtf) throws IllegalStateException, IOException {
		
		MultipartFile file = mtf.getFile("file");

		String oriName = file.getOriginalFilename();
		long fileSize = file.getSize();
		String ext = oriName.substring(oriName.lastIndexOf("."));
		String stoName = UUID.randomUUID()+ext;
		String filePath = "/home/parksc0710/images/board/";
		
		file.transferTo(new File(filePath,stoName));
		
		//System.out.println(stoName);

		return stoName;
	}
	
	// ckeditor5 이미지 업로드 용
	@RequestMapping(value = "multiImageUploader", method = RequestMethod.POST)
	public void file_uploader(HttpServletRequest request, HttpServletResponse response, MultipartHttpServletRequest mtf) throws IOException {
		
		MultipartFile mf = mtf.getFile("upload");
		
		int maxRequestSize = 1024 * 1024 * 50;
		
		request.setCharacterEncoding("UTF-8");
		
		String name = mf.getOriginalFilename().substring(mf.getOriginalFilename().lastIndexOf(File.separator) + 1);
		String filePath = "/home/parksc0710/images/board_new/";
		File file = new File(filePath);
		if (!file.exists()) {
			file.mkdirs();
		}
		String realFileNm = "";
		realFileNm = UUID.randomUUID().toString() + name.substring(name.lastIndexOf("."));
		String rlFileNm = filePath + realFileNm;
		String filename_ext = name.substring(name.lastIndexOf(".") + 1);
		///////////////// 서버에 파일쓰기 /////////////////
	
		mf.transferTo(new File(rlFileNm));
		
		// imgResize
		BufferedImage img = ImageIO.read(new File(rlFileNm));
		if(img.getWidth() > 1600 || img.getHeight() > 1600) {
			int beforeWidth = img.getWidth();
			int beforeHeight = img.getHeight();
			int afterWidth = 0;
			int afterHeight = 0;
			if(beforeWidth >= beforeWidth) {
				afterWidth = 1600;
				afterHeight = (afterWidth * beforeHeight) / beforeWidth;
			} else {
				afterWidth = (afterHeight * beforeWidth) / beforeHeight;
				afterHeight = 1600;
			}
			
			MultiStepRescaleOp rescale = new MultiStepRescaleOp(afterWidth, afterHeight);
		    rescale.setUnsharpenMask(AdvancedResizeOp.UnsharpenMask.Soft);
		    BufferedImage resizedImage = rescale.filter(img, null);
		    
		    ImageIO.write(resizedImage, filename_ext, new File(rlFileNm));
		}
		
		JSONObject outData = new JSONObject();
		outData.put("uploaded", true);
		outData.put("url", "https://www.gyobab.shop/images/board_new/"+realFileNm);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(outData.toString());
	}
}	