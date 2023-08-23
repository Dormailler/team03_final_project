package controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import commBoard.CommCriteria;
import commBoard.CommPagination;
import dto.CommBoardDTO;
import jakarta.servlet.http.HttpSession;
import service.CommBoardService;

@Controller
//@RequestMapping("/communityBoard")
public class CommBoardController {
	private static final Logger logger = LoggerFactory.getLogger(CommBoardController.class);

	@Autowired
	private CommBoardService service;
	
	//ModelAndView mv = new ModelAndView();
	
	//줄바꿈 처리 로직
	public String convertToHtmlFormat(String text) {
	    String htmlText = text.replace("\r\n", "<br>")
	                          .replace("\n", "<br>")
	                          .replace("\r", "<br>");
	    return htmlText;
	}
	
	// 게시글 작성 get
	@GetMapping("/commWrite")
	public String commWrite(Model model, HttpSession session) {
	    // 세션에 저장된 사용자 닉네임 가져오기
	    String sessionNick = (String) session.getAttribute("nick");
	    
	    // 세션 닉네임을 JSP 페이지로 전달
	    model.addAttribute("sessionNick", sessionNick);
	    
	    // 로그 메시지 출력
	    logger.info("게시글 작성 페이지");
	    
	    return "commWrite"; // 게시글 작성 페이지로 이동
	}

	
	//게시글 작성 post
	@PostMapping("/commWrite")
	public String commWrite(CommBoardDTO dto)	{
		//로그 메시지 출력
		logger.info("게시글 작성 수행");
		
	    //줄바꿈
		String content = convertToHtmlFormat(dto.getContent());
		dto.setContent(content);

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
		//List<ReplyDTO> commentList = service.getComment(no);
		//mv.addObject("commentList", commentList);
	}
	
	// 게시글 수정 get
	@GetMapping("/commModify")
	public String commModify(@RequestParam("no") int no, Model model, HttpSession session) {
	    CommBoardDTO commView = service.commView(no);
	    
	    // 세션에 저장된 사용자 아이디
	    String sessionUserId = (String) session.getAttribute("session_id");
	    
	    // 게시글 작성자 아이디
	    String writerUserId = commView.getUser_id();
	    
	    if (sessionUserId.equals(writerUserId)) {
	        model.addAttribute("commModify", commView);
	        logger.info("게시글 수정 페이지");
	        return "/commModify"; // 수정 페이지로 이동
	    } else {
	        return "redirect:/commView?no=" + commView.getNo(); // 본인이 아닌 경우 처리 
	    }
	}
	
	//게시글 수정 post
	@PostMapping("/commModify")
	public String commModify(CommBoardDTO dto) {
		logger.info("게시글 수정 수행");
		
	    //줄바꿈
		String content = convertToHtmlFormat(dto.getContent());
		dto.setContent(content);
		
		service.commModify(dto);
		return "redirect:/commView?no="+dto.getNo();
	}
	
	// 게시글 삭제
	@GetMapping("/commRemove")
	public String commRemove(@RequestParam("no") int no, HttpSession session) {
	    CommBoardDTO commView = service.commView(no);
	    
	    // 세션에 저장된 사용자 아이디
	    String sessionUserId = (String) session.getAttribute("session_id");
	    
	    // 게시글 작성자 아이디
	    String writerUserId = commView.getUser_id();
	    
	    if (sessionUserId.equals(writerUserId)) {
	        service.commRemove(no); // 삭제 작업 수행
	        return "redirect:/commList"; // 삭제 후 목록 페이지로 리다이렉트
	    } else {
	        return "redirect:/commView?no=" + commView.getNo(); // 본인이 아닌 경우 처리 
	    }
	}

}
