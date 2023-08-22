package service;

import java.util.ArrayList;

import commBoard.CommCriteria;
import dto.CommBoardDTO;

public interface CommBoardService {

	//게시글 작성
	public void commWrite(CommBoardDTO dto);
	
	//게시글 조회
	public ArrayList<CommBoardDTO> commList(CommCriteria criteria);
	
	//게시글 보기
	public CommBoardDTO commView(int no);
	
	//게시글 수정
	public boolean commModify(CommBoardDTO dto);
	
	//게시글 삭제
	public boolean commRemove(int no);
	
	//게시글 개수
	public int getTotal(CommCriteria criteria);
	
	//이전 게시글 보기
	public CommBoardDTO prevBoard(int no);
	
	//다음 게시글 보기
	public CommBoardDTO nextBoard(int no);
}
