package com.sh.oee.notice.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NoticeKeyword {
	private int no;
	private String memberId;
	private String keyword;
	private LocalDateTime regDate;
}
