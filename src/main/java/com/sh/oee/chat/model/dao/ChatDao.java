package com.sh.oee.chat.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sh.oee.chat.model.dto.CraigChat;
import com.sh.oee.chat.model.dto.CraigMsg;
import com.sh.oee.chat.model.dto.MsgAttach;
import com.sh.oee.chat.model.dto.TogetherChat;
import com.sh.oee.chat.model.dto.TogetherMsg;

@Mapper
public interface ChatDao {

	/* -------------------- 중고거래 채팅방 ----------------------- */
	@Select("SELECT chatroom_id FROM craig_chat WHERE member_id = #{memberId} AND craig_no = #{craigNo}")
	String findCraigChatroomId(Map<String, Object> craigChatMap);

	@Insert("insert into craig_chat (chatroom_id, member_id, craig_no) values(#{chatroomId}, #{memberId}, #{craigNo})")
	int insertCraigChatroom(CraigChat craigChat);

	@Select("select * from craig_msg where chatroom_id = #{chatroomId} order by msg_no")
	List<CraigMsg> findCraigMsgBychatroomId(String chatroomId);

	@Select("select member_id from craig_chat where chatroom_id = #{chatroomId} and member_id != #{memberId}")
	String findOtherFromCraigChat(Map<String, Object> startUser);

	@Select("select chatroom_id from craig_chat where member_id = #{memberId} and craig_no = #{craigNo}")
	List<String> findCraigChatList(Map<String, Object> craigChatMap);
 	
	int insertCraigMsg(CraigMsg craigMsg);

	CraigMsg findLastCraigMsgByChatroomId(String chatroomId);

	@Select("select * from craig_chat where member_id = #{memberId} and chatroom_id = #{chatroomId}")
	CraigChat findCraigChat(Map<String, Object> craigChatMap);

	@Select("select * from craig_msg where chatroom_id = #{chatroomId} and sent_time > #{regDate} order by msg_no")
	List<CraigMsg> findCraigMsgAfterReg(Map<String, Object> regDelMap);

	@Update("update craig_chat set del_date = #{delDate} where chatroom_id = #{chatroomId} and member_id = #{memberId}")
	int updateDel(Map<String, Object> delMap);

	// 채팅방 재입장
	@Update("update craig_chat set del_date = null, reg_date = sysdate where chatroom_id = #{chatroomId} and member_id = #{memberId}")
	int reJoinCraigChat(Map<String, Object> reJoinMap);
	
	
	int insertCraigMsgAttach(MsgAttach attach);

	@Select("select * from craig_msg_attach where re_filename = #{content}")
	MsgAttach findCraigMsgAttach(String content);

	@Update("update craig_msg_attach set msg_no = #{msgNo} where re_filename = #{reFilename}")
	int updateCraigAttachMsgNo(Map<String, Object> map);

	/** 같이해요 시작 ----- */
	@Insert("insert into together_chat values(#{togetherNo}, #{memberId}, 'M', sysdate, default)")
	int insertTogetherMember(Map<String, Object> map);

	@Select("select * from together_chat where together_no = #{togetherNo} and member_id = #{memberId}")
	TogetherChat findTogetherMember(Map<String, Object> map);

	@Select("select * from together_chat where together_no = #{togetherNo}")
	List<TogetherChat> findAllTogetherMembers(Map<String, Object> map);

	@Select("select * from together_msg where sent_time > #{regDate} and chatroom_no = #{togetherNo} order by msg_no")
	List<TogetherMsg> findTogetherMsgAfterReg(Map<String, Object> regMap);

	@Select("select * from together_msg_attach where re_filename = #{content}")
	MsgAttach findTogetherMsgAttach(String content);
	
	@Update("update together_msg_attach set msg_no = #{msgNo} where re_filename = #{reFilename}")
	int updateTogetherAttachMsgNo(Map<String, Object> map);

	int insertTogetherMsgAttach(MsgAttach attach);

	int insertTogetherMsg(TogetherMsg togetherMsg);

	@Delete("delete from together_chat where member_id = #{memberId} and together_no = #{chatroomNo}")
	int exitTogether(Map<String, Object> delMap);

	/** ------------- 나의 오이 --------------**/
	@Select("select * from craig_chat where member_id = #{memberId} and del_date is null")
	List<CraigChat> findAllCraigChatroom(String memberId);

	@Select("select * from together_chat where member_id = #{memberId}")
	List<TogetherChat> findAllTogetherChatroom(String memberId);

	TogetherMsg findLastTogetherMsgByTogetherNo(int togetherNo);
	
	@Select("select * from together_chat where member_id = #{memberId} and together_no = #{chatroomNo}")
	TogetherChat findTogetherChat(Map<String, Object> findChat);




}
