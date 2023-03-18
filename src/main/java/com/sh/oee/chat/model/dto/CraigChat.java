package com.sh.oee.chat.model.dto;

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
public class CraigChat  {
	@NonNull
	private String chatroomId; // 대화방id
	@NonNull
	private String memberId; // 참여자id
	private int craigNo; // 게시글번호
	private LocalDateTime regDate; // 등록일
	private LocalDateTime delDate; // 퇴장일
	private long lastCheck; // 마지막확인시간

}
