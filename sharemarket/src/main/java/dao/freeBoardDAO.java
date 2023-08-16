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
}
