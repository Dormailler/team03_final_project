package shareboard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ShareBoardController {

	@Autowired
	ShareBoardService service;
	
	@GetMapping("/shareboard")
	public ModelAndView shareBoard() {
		ModelAndView mv = new ModelAndView();
		ShareBoardDTO dto = new ShareBoardDTO();
		
		List<ShareBoardDTO> boardList = service.getBoardList(dto);
		mv.addObject("boardList" ,boardList);
		mv.setViewName("/shareBoard/shareBoard");
		return mv;
	}
}
