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
public class TogetherChat{

	@NonNull
	private int chatroomNo; // 대화방NO
	private int togetherNo; // 같이해요NO
	@NonNull
	private String memberId; // 참여자id
	@NonNull
	private Role role; // 역할
	private LocalDateTime regDate; // 등록일
	private long lastCheck; // 마지막확인시간

}
