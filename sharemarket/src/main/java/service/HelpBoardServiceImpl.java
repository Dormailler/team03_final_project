package service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import commBoard.HelpCriteria;
import dao.HelpBoardDAO;
import dto.HelpBoardDTO;

@Service
public class HelpBoardServiceImpl implements HelpBoardService {
	
	@Autowired
	private HelpBoardDAO dao;
	
	//1:1 문의
	public void help(HelpBoardDTO dto) {
		dao.help(dto);
        System.out.println("toString: " + dto.toString());

	}
	
	//1:1 문의 목록 설계
	public ArrayList<HelpBoardDTO> helplist(HelpCriteria cri) {
	    ArrayList<HelpBoardDTO> result = dao.helplist(cri);
	    
	    return result;
	}

	
	//1:1 문의 목록 건수 설계
	public int helpTotal(HelpCriteria cri) {
		return dao.helpTotal(cri);
	}
}
