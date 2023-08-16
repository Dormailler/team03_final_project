package service;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public ArrayList<CommBoardDTO> commList() {
		return dao.commList();
	}
	
	//게시글 보기
	public CommBoardDTO commView(int no) {
		return dao.commView(no);
	}

	public boolean commModify(CommBoardDTO dto) {
		return dao.commModify(dto);
	}

	public boolean commRemove(int no) {
		return dao.commRemove(no);
	}
}


