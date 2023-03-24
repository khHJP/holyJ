package com.sh.oee.chat.model.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface ChatDao {

	@Select("select chatroom_id from craig_chat where member_id = #{memberId} and craig_no = #{craigNo})")
	String findCraigChatroomId(String memberId, int craigNo);

}
