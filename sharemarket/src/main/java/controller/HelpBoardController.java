package controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttribute;

import commBoard.HelpCriteria;
import commBoard.HelpPage;
import dto.HelpBoardDTO;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.HelpBoardService;


@Controller
public class HelpBoardController {
	private static final Logger logger = LoggerFactory.getLogger(HelpBoardController.class);

	@Autowired
	private HelpBoardService service;
	
	//줄바꿈 처리 로직
	public String convertToHtmlFormat(String text) {
	    String htmlText = text.replace("\r\n", "<br>")
	                          .replace("\n", "<br>")
	                          .replace("\r", "<br>");
	    return htmlText;
	}
	
	//1:1문의
	@RequestMapping(value = "/help", method = RequestMethod.GET)
	public String help(HttpSession session, Model model) {
		logger.info("문의 작성 페이지");
		//비로그인 : 로그인 페이지로 연결
		if(session.getAttribute("session_id") == null) {
			return "/login/login_login";
		}
		//로그인된 상태는 바로 1:1로 연결
		return "/help";
	}
	
	//1:1문의 (insert)
	@RequestMapping(value = "/help", method = RequestMethod.POST)
	public String helpPost(HelpBoardDTO dto, HttpSession session, Model model,
	HelpCriteria cri) {
		logger.info("문의 작성");
	    Object session_id = session.getAttribute("session_id");
	    logger.info(session_id + "아이디");
	    dto.setH_id((String) session_id);
	    
	    //줄바꿈
		String content = convertToHtmlFormat(dto.getH_content());
		dto.setH_content(content);
		
		service.help(dto);
	    
		return "redirect:/helplist";
	}
	
	//1:1 문의 내역
	@RequestMapping(value = "/helplist", method = RequestMethod.GET)
	public String helplist(HelpBoardDTO dto, HttpSession session, Model model, 
			HelpCriteria cri) {
		
		logger.info("문의 내역 페이지");
	    // 로그인 상태 확인
	    Object session_id = session.getAttribute("session_id");
	    logger.info(session_id + "아이디");
	    cri.setId((String) session_id);
		//cri.setId("member1"); // 세션 대신 일단 고정된 값으로 설정
		model.addAttribute("helplist", service.helplist(cri));
		int total = service.helpTotal(cri);
		model.addAttribute("paging", new HelpPage(cri, total));
		return "/helplist";
	}
}
