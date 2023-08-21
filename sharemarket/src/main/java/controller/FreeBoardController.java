package controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dto.freeBoardDTO;
import service.freeBoardService;


@Controller
public class FreeBoardController {
	
	@Autowired
	@Qualifier("freeservice")
	freeBoardService service;
	
	@RequestMapping("/free")
	public ModelAndView freeboard(@RequestParam(value="page", required=false, defaultValue="1") int page, 
									@RequestParam(value="category", required=false, defaultValue="fashion") String category,
									@RequestParam(value="select", required=false, defaultValue="title") String select,
									@RequestParam(value="text", required=false, defaultValue="") String text) {
		int totalBoard = service.getTotalsearchFreeBoard(category,text,select);
		
		//page번호 해당 게시물 8개 리스트 조회 
		int limitcount = 8;
		int limitindex = (page-1)*limitcount;
		System.out.println("토탈ㅋㅋ:"+totalBoard);
		HashMap<String, String> paramap = new HashMap<>();
		paramap.put("start", Integer.toString(limitindex));
		paramap.put("end", Integer.toString(limitcount));
		paramap.put("category", category);
		paramap.put("text", text);
		paramap.put("select", select);
		List<freeBoardDTO> list = service.searchFreeBoard(paramap);
		System.out.println("카테고리:" + category);
		System.out.println("검색어:" + text);
		System.out.println("선택:" + select);
		System.out.println(list);
		ModelAndView mv = new ModelAndView();
		mv.addObject("totalBoard", totalBoard);
		mv.addObject("freelist",list);
		mv.addObject("page",page);
		mv.addObject("text",text);
		mv.addObject("select",select);
		mv.addObject("category",category);
		mv.setViewName("free/free");
		return mv;
	}
	@RequestMapping("/free/{shareId}")
	public ModelAndView freeDetail(@PathVariable("shareId") String share_id){
		freeBoardDTO dto = service.freeOne(share_id); 
		ModelAndView mv = new ModelAndView();
		mv.addObject("dto",dto);
		mv.setViewName("free/free_detail");
		return mv;
		
	}
	@RequestMapping("/freew")
	public String freeWrite() {
		return "/free/free_write";
	}
	@RequestMapping("/freew/{shareId}")
	public ModelAndView freeUpdate(@PathVariable("shareId") String share_id){
		freeBoardDTO dto = service.freeOne(share_id); 
		ModelAndView mv = new ModelAndView();
		mv.addObject("dto",dto);
		mv.setViewName("/free/free_write");
		return mv;
		
	}
	
	@PostMapping("/upload")
    public String uploadFiles(@RequestParam("files") MultipartFile[] files, RedirectAttributes redirectAttributes) {
		
        for (MultipartFile file : files) {
            if (!file.isEmpty()) {
                try {
                	File savelocation = new File("src/main/resources/static/save/");
                	File saveFile = new File(savelocation.getAbsolutePath()+ "/" + file.getOriginalFilename());
                	System.out.println(savelocation.getAbsolutePath()+ "/" + file.getOriginalFilename());
                    file.transferTo(saveFile);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return "/free/free";
    }
	@RequestMapping("/register_free")
	@ResponseBody
	public void register_free(String user_id,String title,String category,String location,String content,String img) {
		service.registerFreeBoard(user_id, title, category, location, content, img);
	}
	@RequestMapping("/delete_free")
	@ResponseBody
	public void delete_free(String share_id) {
		service.deleteFreeBoard(share_id);
	}
	@RequestMapping("/update_free")
	@ResponseBody
	public void update_free(String share_id,String title,String category,String location,String content,String img) {
		service.updateFreeBoard(share_id, title, category, location, content, img);
	}
	@RequestMapping("/search_free")
	public ModelAndView search_free(@RequestParam(value="page", required=false, defaultValue="1") int page, String category,String text,String select) {
		
		int totalBoard = service.getTotalsearchFreeBoard(category,text,select);
		
		//page번호 해당 게시물 8개 리스트 조회 
		int limitcount = 8;
		int limitindex = (page-1)*limitcount;
		
		HashMap<String, String> paramap = new HashMap<>();
		paramap.put("start", Integer.toString(limitindex));
		paramap.put("end", Integer.toString(limitcount));
		paramap.put("category", category);
		paramap.put("text", text);
		paramap.put("select", select);
		List<freeBoardDTO> list = service.searchFreeBoard(paramap);
		ModelAndView mv = new ModelAndView();
		mv.addObject("totalBoard", totalBoard);
		mv.addObject("freelist",list);
		mv.addObject("page",page);
		mv.addObject("category",category);
		mv.setViewName("free/free");
		return mv;
	}
}
