package com.sh.oee.chat.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sh.oee.chat.model.dto.CraigChat;
import com.sh.oee.chat.model.dto.CraigMsg;
import com.sh.oee.chat.model.dto.MsgAttach;

@Mapper
public interface ChatDao {

	@Select("select chatroom_id from craig_chat where member_id = #{memberId} and craig_no = #{craigNo}")
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

	@Update("update craig_chat set del_date = null, reg_date = #{regDate} where chatroom_id = #{chatroomId} and member_id = #{memberId}")
	int updateRegDel(Map<String, Object> regDelMap);

	int insertCraigMsgAttach(MsgAttach attach);

	@Select("select * from craig_msg_attach where re_filename = #{content}")
	MsgAttach findCraigMsgAttach(String content);

	@Update("update craig_msg_attach set msg_no = #{msgNo} where re_filename = #{reFilename}")
	int updateCraigAttachMsgNo(Map<String, Object> map);



}
