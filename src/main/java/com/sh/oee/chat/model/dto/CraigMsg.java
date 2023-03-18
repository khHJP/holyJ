package com.sh.oee.chat.model.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class CraigMsg extends CraigMsgEntity {
	private MsgAttach attach = new MsgAttach(); // 메시지 첨부파일 객체
	// private Member member; // 메시지 작성자 객체

	public CraigMsg(long msgNo, String chatroomId, String writer, String content, long sentTime, ChatLogType type,
			MsgAttach attach) {
		super(msgNo, chatroomId, writer, content, sentTime, type);
		this.attach = attach;
	}
	
	// 필요할까? 모르겠음.. 
	public void addMsgAttach(MsgAttach attach) {
		this.attach = attach;
	}
	
	
}
