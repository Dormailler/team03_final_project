package service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.freeBoardDAO;
import dto.freeBoardDTO;

@Service("freeservice")
public class freeBoardService {
	
	@Autowired
	freeBoardDAO dao;
	
	public List<freeBoardDTO> freeList(HashMap<String, String> map){
		return dao.freeList(map);
	}
	public freeBoardDTO freeOne(String share_id){
		return dao.freeOne(share_id);
	}
	public int getTotalFreeBoard(String category) {
		return dao.getTotalFreeBoard(category);
	}
}
