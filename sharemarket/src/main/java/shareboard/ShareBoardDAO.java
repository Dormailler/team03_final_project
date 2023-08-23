package shareboard;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import pagination.SearchDTO;

@Mapper
@Repository
public interface ShareBoardDAO {
	List<ShareBoardDTO> getAllBoardPaging(SearchDTO dto);
	List<ShareBoardDTO> getShareBoardList(ShareBoardDTO dto);
	int getCount(SearchDTO dto);
	ShareBoardDTO getBoardDetail(int share_id);
	List<CommentDTO> getComment(int share_id);
	int writeShareBoard(ShareBoardDTO dto);
	int deleteShareBoard(int share_id);
	int sharedConfirm(int share_id);
}
