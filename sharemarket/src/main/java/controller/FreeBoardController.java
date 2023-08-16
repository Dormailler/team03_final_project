package controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import dto.freeBoardDTO;
import service.freeBoardService;


@Controller
public class FreeBoardController {
	
	@Autowired
	@Qualifier("freeservice")
	freeBoardService service;
	
	@RequestMapping("/free")
	public ModelAndView freeboard(@RequestParam(value="page", required=false, defaultValue="1") int page, @RequestParam(value="category", required=false, defaultValue="패션") String category) {
		int totalBoard = service.getTotalFreeBoard(category);
		//page번호 해당 게시물 8개 리스트 조회 
		int limitcount = 8;
		int limitindex = (page-1)*limitcount;
		HashMap<String, String> paramap = new HashMap<>();
		paramap.put("start", Integer.toString(limitindex));
		paramap.put("end", Integer.toString(limitcount));
		paramap.put("category", category);
		List<freeBoardDTO> list = service.freeList(paramap);
		ModelAndView mv = new ModelAndView();
		mv.addObject("totalBoard", totalBoard);
		mv.addObject("freelist",list);
		mv.addObject("page",page);
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
}
