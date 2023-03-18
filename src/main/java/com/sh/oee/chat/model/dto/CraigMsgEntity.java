package com.sh.oee.chat.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CraigMsgEntity {
	private long msgNo; // 거래메시지 no
	private String chatroomId; // 거래대화방id
	private String writer; // 작성자id
	private String content; // 메시지내용
	private long sentTime; // 보낸시간
	private ChatLogType type; // 메시지타입
}
