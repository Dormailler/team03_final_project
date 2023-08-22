package shareboard;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import pagination.Pagination;
import pagination.PagingResponse;
import pagination.SearchDTO;

@Service
public class ShareBoardService {
	
	@Autowired
	ShareBoardDAO dao;
	
	public List<ShareBoardDTO> getShareBoardList(ShareBoardDTO dto){
		return dao.getShareBoardList(dto);
	}
	
	public PagingResponse<ShareBoardDTO> getAllBoardPaging(SearchDTO dto){
		int count = dao.getCount(dto);
		if (count < 1) {
			return new PagingResponse<>(Collections.emptyList(), null);
		}
		
		Pagination pagination = new Pagination(count, dto);
		dto.setPagination(pagination);
		
		List<ShareBoardDTO> list = dao.getAllBoardPaging(dto);
		return new PagingResponse<>(list, pagination);
    }

	public ShareBoardDTO getBoardDetail(int share_id) {
		return dao.getBoardDetail(share_id);
	}
	
	public List<CommentDTO> getComment(int share_id){
		return dao.getComment(share_id);
	}
	
	public int writeShareBoard(String user_id) {
		return dao.writeShareBoard(user_id);
	}
	
}
