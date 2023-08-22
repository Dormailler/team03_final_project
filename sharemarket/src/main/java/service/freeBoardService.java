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
	public void registerFreeBoard(String user_id,String title,String category,String location,String content,String img,String name) {
		dao.registerFreeBoard(user_id, title, category, location, content, img, name);
	}
	public void deleteFreeBoard(String share_id) {
		dao.deleteFreeBoard(share_id);
	}
	public void updateFreeBoard(String share_id,String title,String category,String location,String content,String img) {
		dao.updateFreeBoard(share_id, title, category, location, content, img);
	}
	public List<freeBoardDTO> searchFreeBoard(HashMap<String, String> map) {
		return dao.searchFreeBoard(map);
	}
	public int getTotalsearchFreeBoard(String category,String text,String select) {
		return dao.getTotalsearchFreeBoard(category, text, select);
	}
	public void SharedFreeBoard(String shared_id) {
		dao.SharedFreeBoard(shared_id);
	}
	public String getName(String user_id) {
		return dao.getName(user_id);
	}
}
