package dao;

import java.util.ArrayList;

import dto.CommBoardDTO;

public interface CommBoardDAO {
	//게시글 작성
	public void commWrite(CommBoardDTO dto);
	
	//게시글 조회
	public ArrayList<CommBoardDTO> commList();
	
	//게시글 보기
	public CommBoardDTO commView(int no);
	
	//게시글 수정
	public boolean commModify(CommBoardDTO dto);
	
	//게시글 삭제
	public boolean commRemove(int no);
}
