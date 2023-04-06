package com.sh.oee.craigMeeting.model.service;

import java.util.Map;

import com.sh.oee.craigMeeting.model.dto.CraigMeeting;

public interface MeetingService {

	int enrollMeeting(Map<String, Object> map);

	CraigMeeting findMeetingByCraigNo(int craigNo);

}
