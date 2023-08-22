package shareboard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import pagination.PagingResponse;
import pagination.SearchDTO;

@Controller
public class ShareBoardController {

	@Autowired
	ShareBoardService service;
	
	ModelAndView mv = new ModelAndView();
	ShareBoardDTO dto = new ShareBoardDTO();
	
	@GetMapping("/shareboardlist")
	public ModelAndView shareBoard(HttpSession session, @ModelAttribute SearchDTO searchdto, HttpServletRequest request) {
		session.setAttribute("user_id", "team3");
		searchdto.setRecordSize(10);
		
		PagingResponse<ShareBoardDTO> list = service.getAllBoardPaging(searchdto);
		mv.addObject("response", list);
		mv.setViewName("/shareBoard/shareBoardList");
		return mv;
	}
	
	@GetMapping("/sharedetail")
	public ModelAndView shareBoardDetail(int share_id) {
		ShareBoardDTO boardDetail = service.getBoardDetail(share_id);
		List<CommentDTO> commentList = service.getComment(share_id);
		mv.addObject("commentList", commentList);
		mv.addObject("boardDetail", boardDetail);
		mv.setViewName("/shareBoard/shareBoardDetail");
		return mv;
	}
	
	@GetMapping("/writingform")
	public String writingForm() {
		return "/shareBoard/shareBoardWrite";
	}
	
    @PostMapping("/boardwrite")
    @ResponseBody
    public String shareBoardWrite(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String user_id = (String) session.getAttribute("user_id");
        
        int result = service.writeShareBoard(user_id);
        return "{\"result\":\"" + result + "\"}";
    }
}
