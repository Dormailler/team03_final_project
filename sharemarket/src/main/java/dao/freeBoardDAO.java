package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import dto.freeBoardDTO;

@Mapper
@Repository
public interface freeBoardDAO {
	public List<freeBoardDTO> freeList(HashMap<String, String> map);
	public freeBoardDTO freeOne(String share_id);
	public int getTotalFreeBoard(String category);
	public void registerFreeBoard(String user_id,String title,String category,String location,String content,String img,String name);
	public void deleteFreeBoard(String share_id);
	public void updateFreeBoard(String share_id,String title,String category,String location,String content,String img);
	public List<freeBoardDTO> searchFreeBoard(HashMap<String, String> map);
	public int getTotalsearchFreeBoard(String category,String text,String select);
	public void SharedFreeBoard(String shared_id);
	public String getName(String user_id);
}
