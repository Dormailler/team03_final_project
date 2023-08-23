package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.CommReplyDAO;
import dto.CommReplyDTO;

@Service
public class CommReplyServiceImpl implements CommReplyService {
	
	@Autowired
	private CommReplyDAO dao;
	
	//댓글 작성
	public boolean write(CommReplyDTO dto) {
		return dao.write(dto);
	}
}
