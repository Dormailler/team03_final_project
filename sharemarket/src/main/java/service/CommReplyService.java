package service;

import dto.CommReplyDTO;

public interface CommReplyService {
	//댓글 작성
	public boolean write(CommReplyDTO dto);
}
