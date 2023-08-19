package controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import commBoard.CommCriteria;
import commBoard.CommPagination;
import dto.CommBoardDTO;
import service.CommBoardService;

@Controller
//@RequestMapping("/communityBoard")
public class CommBoardController {
	private static final Logger logger = LoggerFactory.getLogger(CommBoardController.class);

	@Autowired
	private CommBoardService service;
	
	//게시글 작성 get
	@GetMapping("/commWrite")
	public void commWrite()	{
		//로그 메시지 출력
		logger.info("게시글 작성 페이지");
	}
	
	//게시글 작성 post
	@PostMapping("/commWrite")
	public String commWrite(CommBoardDTO dto)	{
		//로그 메시지 출력
		logger.info("게시글 작성 수행");
		service.commWrite(dto);
		return "redirect:/commList";
	}
	
	//게시글 조회
	@GetMapping("/commList")
	public void commList(Model model, CommCriteria criteria) {
		logger.info("게시글 목록 조회");
		model.addAttribute("commList", service.commList(criteria));
		model.addAttribute("CommPagination", new CommPagination(criteria, service.getTotal(criteria)));
	}
	
	//게시글 보기
	@GetMapping("/commView")
	public void commView(@RequestParam("no") int no, Model model) {
		model.addAttribute("commView", service.commView(no));
		model.addAttribute("prev", service.prevBoard(no));
		model.addAttribute("next", service.nextBoard(no));
	}
	
	//게시글 수정 get
	@GetMapping("/commModify")
	public void commModify(@RequestParam("no") int no, Model model) {
		model.addAttribute("commModify", service.commView(no));
		logger.info("게시글 수정 페이지");
	}
	
	//게시글 수정 post
	@PostMapping("/commModify")
	public String commModify(CommBoardDTO dto) {
		logger.info("게시글 수정 수행");
		service.commModify(dto);
		return "redirect:/commView?no="+dto.getNo();
	}
	
	//게시글 삭제
	@GetMapping("/commRemove")
	public String commRemove(@RequestParam("no") int no) {
		service.commRemove(no);
		return "redirect:/commList";
	}
}
