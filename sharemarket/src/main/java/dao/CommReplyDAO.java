package dao;

import dto.CommReplyDTO;

public interface CommReplyDAO {
	//댓글 작성
	public boolean write(CommReplyDTO dto);
}
