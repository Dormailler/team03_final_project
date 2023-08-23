package controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import dto.CommReplyDTO;
import service.CommReplyService;

@RestController
public class CommReplyController {
	private static final Logger logger = LoggerFactory.getLogger(CommBoardController.class);

	@Autowired
	private CommReplyService service;
	
	//댓글 입력
	@PostMapping(value="/write", consumes = "application/json",
			produces = {MediaType.TEXT_EVENT_STREAM_VALUE})
	public ResponseEntity<String> write(@RequestBody CommReplyDTO dto) {
		logger.info("입력 댓글 : " + dto);
		return service.write(dto)
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
