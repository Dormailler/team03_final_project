package login;

import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MessageDAO {

	@Autowired
	private SqlSession sqlSession;

	// 메세지 리스트
	public ArrayList<MessageTO> messageList(MessageTO to) {

		String nick = to.getNick();
		
		// 메세지 리스트에 나타낼 것들 가져오기 - 가장 최근 메세지, 보낸사람 profile 사진, 보낸사람 nick
		ArrayList<MessageTO> list = (ArrayList) sqlSession.selectList("message_list", to);

		for (MessageTO mto : list) {
			mto.setNick(nick);
			// 현재 사용자가 해당 room에서 안읽은 메세지의 갯수를 가져온다.
			int unread = sqlSession.selectOne("count_unread", mto);
			// 현재 사용자가 메세지를 주고받는 상대 profile을 가져온다.
			String profile = sqlSession.selectOne("get_other_profile",mto);
			// 안읽은 메세지 갯수를 mto에 set한다.
			mto.setUnread(unread);
			// 메세지 상대의 프로필사진을 mto에 set한다.
			mto.setProfile(profile);
			// 메세지 상대 nick을 세팅한다. other_nick
			if (nick.equals(mto.getSend_nick())) {
				mto.setOther_nick(mto.getRecv_nick());
			} else {
				mto.setOther_nick(mto.getSend_nick());
			}
		}

		return list;
	}


	// room 별 메세지 내용을 가져온다.
	public ArrayList<MessageTO> roomContentList(MessageTO to) {
		
		System.out.println("room : " + to.getRoom());
		System.out.println("recv_nick : " + to.getRecv_nick());
		System.out.println("nick : " + to.getNick());
		// 메세지 내역을 가져온다
		ArrayList<MessageTO> clist = (ArrayList) sqlSession.selectList("room_content_list", to);

		// 해당 방의 메세지들 중 받는 사람이 현재사용자의 nick인 메세지를 모두 읽음 처리한다
		sqlSession.update("message_read_chk", to);

		return clist;
	}
	
	// 메세지 list에서 메세지를 보낸다.
	public int messageSendInlist(MessageTO to) {
		
		System.out.println("메세지 변수 : " + to.toString());
	    try {
	        return sqlSession.insert("login.MessageDAO.messageSendInlist", to);
	    } catch (Exception e) {
	        e.printStackTrace();
	        return 0; // 실패 시 0 반환
	    }
	}
	
	// 사용자의 닉네임 설정
	public void setUserNickname(String nick, String userNickname) {
	    Map<String, String> params = new HashMap<>();
	    params.put("nick", nick);
	    params.put("userNickname", userNickname);
	    sqlSession.update("set_user_nickname", params);
	}
	
	// 사용자의 전체 메시지 수를 가져오는 메소드
    public int getTotalMessageCount(MessageTO to) {
        return sqlSession.selectOne("getTotalMessageCount", to);
    }

    // 페이지에 해당하는 메시지 목록을 가져오는 메소드
    public List<MessageTO> getPagedMessageList(MessageTO to, int startIndex, int messagesPerPage) {
        Map<String, Object> params = new HashMap<>();
        params.put("nick", to.getNick());
        params.put("startIndex", startIndex);
        params.put("messagesPerPage", messagesPerPage);
        return sqlSession.selectList("getPagedMessageList", params);
    }
}