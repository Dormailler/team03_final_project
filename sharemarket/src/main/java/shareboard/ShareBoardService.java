package shareboard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ShareBoardService {
	
	@Autowired
	ShareBoardDAO dao;
	
	public List<ShareBoardDTO> getBoardList(ShareBoardDTO dto){
		return dao.getBoardList(dto);
	}
}
