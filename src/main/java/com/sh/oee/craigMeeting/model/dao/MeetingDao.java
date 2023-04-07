package com.sh.oee.craigMeeting.model.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sh.oee.craigMeeting.model.dto.CraigMeeting;

@Mapper
public interface MeetingDao {

	@Insert("insert into craig_meeting values(#{no}, #{chatroomId}, #{memberId}, #{date}, default, null, null)")
	int enrollMeeting(Map<String, Object> map);

	@Select("select * from craig_meeting where no = #{craigNo}")
	CraigMeeting findMeetingByCraigNo(int craigNo);

	@Update("update craig_meeting set longitude = #{meetingLon}, latitude = #{meetingLat} where no = #{no}")
	int enrollMeetingPlace(Map<String, Object> map);


}
