package login;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import login.MessageDAO;

@Controller
public class MessageController {

    @Autowired
    private MessageDAO messageDao;

    private static final int MESSAGES_PER_PAGE = 10; // Number of messages per page

    @RequestMapping(value = "/messagelist", method = RequestMethod.GET)
    public String messageList(
            @RequestParam(defaultValue = "1") int page,
            HttpSession session, Model model) {

        String nick = (String) session.getAttribute("nick");

        MessageTO to = new MessageTO();
        to.setNick(nick);

        // 데이터베이스에서 총 메시지 수 가져오기
        int totalMessages = messageDao.getTotalMessageCount(to);

        // 페이지 계산
        int totalPages = (int) Math.ceil((double) totalMessages / MESSAGES_PER_PAGE);
        int startIndex = (page - 1) * MESSAGES_PER_PAGE;

        // 페이지에 해당하는 메시지 목록 가져오기
        List<MessageTO> list = messageDao.getPagedMessageList(to, startIndex, MESSAGES_PER_PAGE);

        model.addAttribute("list", list);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);

        return "message/message_list";
    }

	
	@RequestMapping(value = "/sendMessage", method = RequestMethod.GET)
    public String sendMessagePage() {
        return "message/sendMessage"; // sendMessage.jsp로 이동
    }

	@RequestMapping(value = "/sendMessage", method = RequestMethod.POST)
	public String sendMessage(HttpServletRequest request, HttpSession session) {
	    String recv_nick = request.getParameter("recv_nick");
	    String content = request.getParameter("content");
	    String send_nick = (String) session.getAttribute("nick");

	    MessageTO to = new MessageTO();
	    to.setSend_nick(send_nick);
	    to.setRecv_nick(recv_nick);
	    to.setContent(content);

	    int flag = messageDao.messageSendInlist(to);

	    if (flag > 0) {
	        return "redirect:/success"; // 절대 경로로 성공 페이지로 리디렉트
	    } else {
	        return "redirect:fail"; // 절대 경로로 실패 페이지로 리디렉트
	    }
	}
	
	@GetMapping("/success")
    public String showSuccessPage() {
        return "/message/update_success";
    }
	
	@GetMapping("/fail")
    public String showFailPage() {
        return "/message/fail";
    }
}