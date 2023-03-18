package com.sh.oee.manner.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data 
@NoArgsConstructor
@AllArgsConstructor
public class Manner {
	@NonNull
	private long mannerNo; // 매너평가no
	private int craigNo; // 중고거래게시글번호
	private Prefer prefer; // 거래선호도
	private Compliment compliment; // 칭찬
	private String writer; // 작성자
	private String recipient; // 대상자
	private LocalDateTime regDate; // 등록일
}
