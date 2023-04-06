package com.sh.oee.craigMeeting.model.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.oee.craigMeeting.model.dao.MeetingDao;
import com.sh.oee.craigMeeting.model.dto.CraigMeeting;
import com.sh.oee.craig.model.dao.CraigDao;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(rollbackFor = Exception.class)
@Slf4j
public class MeetingServiceImpl implements MeetingService {
	
	@Autowired
	private MeetingDao meetingDao;
	@Autowired
	private CraigDao craigDao;
	
	/**
	 * INSERT
	 * - CRAIG_MEETING 한행추가
	 * - CRAIG 해당 게시글 STATE 예약중으로 변경 (CR1)
	 * 		+ BUYER 업데이트
	 */
	@Override
	public int enrollMeeting(Map<String, Object> map) {
		// 1. CRAIG_MEETING 추가
		meetingDao.enrollMeeting(map);
		
		// 2. CRAIG update처리
		int result = craigDao.updateCraigMeeting(map);
	
		return result;
	}

	/**
	 * SELECT
	 * - CRAIG_MEETING에서 no로 한 행 가져오기
	 */
	@Override
	public CraigMeeting findMeetingByCraigNo(int craigNo) {
		return meetingDao.findMeetingByCraigNo(craigNo);
	}

	/**
	 * UPDATE
	 * - CRAIG_MEETING에서 no로 해당하는 행의 위/경도 update
	 */
	@Override
	public int enrollMeetingPlace(Map<String, Object> map) {
		return meetingDao.enrollMeetingPlace(map);
	}

}
