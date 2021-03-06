package com.park.gyobab.controller.main;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.imgscalr.Scalr;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.drew.imaging.ImageMetadataReader;
import com.drew.metadata.Directory;
import com.drew.metadata.Metadata;
import com.drew.metadata.exif.ExifIFD0Directory;
import com.drew.metadata.jpeg.JpegDirectory;
import com.park.gyobab.domain.BoardCommentVO;
import com.park.gyobab.domain.BoardLikeVO;
import com.park.gyobab.domain.BoardVO;
import com.park.gyobab.domain.Criteria;
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
		
		String boardType = "notice";
		Criteria cri = new Criteria(1, 5);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("board_type", boardType);
		map.put("board_cate", "");
		map.put("cri", new Criteria(1, 3));
		List<BoardVO> noticeList = boardService.selectBoards(map);
		
		map.put("cri", cri);
		
		boardType = "menu";
		map.put("board_type", boardType);
		List<BoardVO> menuList = boardService.selectBoards(map);
		
		boardType = "free";
		map.put("board_type", boardType);
		List<BoardVO> freeList = boardService.selectBoards(map);
		
		boardType = "humor";
		map.put("board_type", boardType);
		List<BoardVO> humorList = boardService.selectBoards(map);
		
		boardType = "restaurant";
		map.put("board_type", boardType);
		List<BoardVO> restaurantList = boardService.selectBoards(map);
		
		String board_type = "menu";
		BoardVO topMenu = boardService.selectTop1Board(board_type);
		List<BoardLikeVO> likelist = boardLikeService.selectBoardLikes(topMenu.getBoard_id());
		List<BoardCommentVO> commentlist = boardCommentService.selectBoardComments(topMenu.getBoard_id());
		
		BoardVO topNotice = boardService.selectTop1Board("notice");
		model.addAttribute("topNotice", topNotice);
		
		model.addAttribute("topMenu", topMenu);
		model.addAttribute("likelist", likelist);
		model.addAttribute("commentlist", commentlist);
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("menuList", menuList);
		model.addAttribute("freeList", freeList);
		model.addAttribute("humorList", humorList);
		model.addAttribute("restaurantList", restaurantList);
		
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
	
	// ckeditor5 ????????? ????????? ???
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
		
		File newFile = new File(rlFileNm);
		
		
		///////////////// ????????? ???????????? /////////////////
	
		mf.transferTo(newFile);
		
		int orientation = 1; // ????????????, 1. 0???, 3. 180???, 6. 270???, 8. 90??? ????????? ??????
		
		Metadata metadata; // ????????? ?????? ????????? ??????
		Directory directory; // ???????????? Exif ???????????? ?????? ?????? ??????
		JpegDirectory jpegDirectory; // JPG ????????? ????????? ?????? ?????? ??????
		
		try {
			metadata = ImageMetadataReader.readMetadata(newFile);
			directory = metadata.getFirstDirectoryOfType(ExifIFD0Directory.class);
			jpegDirectory = metadata.getFirstDirectoryOfType(JpegDirectory.class);
			if(directory != null){
				orientation = directory.getInt(ExifIFD0Directory.TAG_ORIENTATION); // ????????????
			}
	 
		}catch (Exception e) {
			e.printStackTrace();
			orientation=1;
		}
		
		// imgResize
		BufferedImage img = ImageIO.read(new File(rlFileNm));
		if(img.getWidth() > 1600) {
			
			BufferedImage thumbImage = Scalr.resize(img, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_WIDTH, 1600);
		    
			switch (orientation) {
			case 6:
				thumbImage = Scalr.rotate(thumbImage, Scalr.Rotation.CW_90, null); 
				break;
			case 1:
		 
				break;
			case 3:
				thumbImage = Scalr.rotate(thumbImage, Scalr.Rotation.CW_180, null);
				break;
			case 8:
				thumbImage = Scalr.rotate(thumbImage, Scalr.Rotation.CW_270, null);
				break;
		 
			default:
				orientation=1;
				break;
			}
			
		    ImageIO.write(thumbImage, filename_ext, new File(rlFileNm));
		}
		
		JSONObject outData = new JSONObject();
		outData.put("uploaded", true);
		outData.put("url", "https://www.gyobab.shop/images/board_new/"+realFileNm);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(outData.toString());
	}
}	