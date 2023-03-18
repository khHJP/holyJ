package com.sh.oee.chat.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MsgAttach {
	private int attachNo; // 첨부파일no
	private long msgNo;// 메시지no
	private String originalFilename; // 원본파일명
	private String reFilename; // 서버파일명
	private LocalDateTime regDate;// 등록일
}
