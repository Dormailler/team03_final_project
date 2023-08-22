package dao;

import java.util.ArrayList;

import commBoard.HelpCriteria;
import dto.HelpBoardDTO;

public interface HelpBoardDAO {
	//1:1 문의
	public void help(HelpBoardDTO dto);
	
	//1:1 문의 목록 설계
	public ArrayList<HelpBoardDTO> helplist(HelpCriteria cri);
	
	//1:1 문의 목록 건수 설계
	public int helpTotal(HelpCriteria cri);
}
