package com.sh.oee.chat.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@RequiredArgsConstructor 
public class TogetherMsg{
	@NonNull
	private long msgNo; // 같이해요메시지 no
	@NonNull
	private int chatroomNo; // 같이해요 No
	@NonNull
	private String writer; // 작성자id
	private String content; // 메시지내용
	private long sentTime; // 보낸시간
	private ChatLogType type; // 메시지타입
}
