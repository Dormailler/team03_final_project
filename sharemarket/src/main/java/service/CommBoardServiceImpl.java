package service;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import commBoard.CommCriteria;
import dao.CommBoardDAO;
import dto.CommBoardDTO;

@Service
public class CommBoardServiceImpl implements CommBoardService {
	private static final Logger logger = LoggerFactory.getLogger(CommBoardServiceImpl.class);

	@Autowired
	private CommBoardDAO dao;
	
	//게시글 작성
	public void commWrite(CommBoardDTO dto) {
		dao.commWrite(dto);
	}
	
	//게시글 조회
	public ArrayList<CommBoardDTO> commList(CommCriteria criteria) {
		return dao.commList(criteria);
	}
	
	//게시글 보기
	public CommBoardDTO commView(int no) {
		return dao.commView(no);
	}

	//게시글 수정
	public boolean commModify(CommBoardDTO dto) {
		return dao.commModify(dto);
	}

	//게시글 삭제
	public boolean commRemove(int no) {
		return dao.commRemove(no);
	}
	
	//게시글 개수
	public int getTotal(CommCriteria criteria) {
		return dao.getTotal(criteria);
	}
	
	//이전 게시글 보기
	public CommBoardDTO prevBoard(int no) {
		return dao.prevBoard(no);
	}

	//다음 게시글 보기
	public CommBoardDTO nextBoard(int no) {
		return dao.nextBoard(no);
	}
}


