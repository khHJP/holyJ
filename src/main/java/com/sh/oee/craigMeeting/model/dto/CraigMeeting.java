package com.sh.oee.craigMeeting.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
@Data
@NoArgsConstructor
@AllArgsConstructor
@RequiredArgsConstructor 
public class CraigMeeting {
	@NonNull
	private int no; 
	@NonNull
	private String chatroomId; // 대화방id
	@NonNull
	private String memberId; // 작성자id
	private LocalDateTime meetingDate; // 약속일
	private LocalDateTime regDate; // 등록일
	private long longitude;
	private long latitude;
}

