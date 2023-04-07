package com.sh.oee.manner.model.dto;

import java.time.LocalDateTime;

import com.sh.oee.member.model.dto.Member;

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
	private String done;
	private Member  member; // manner 평가 당한 사람 
	
	//멤버없는 생성자 (manner테이블 고유)
	public Manner(@NonNull long mannerNo, int craigNo, Prefer prefer, Compliment compliment, String writer,
			String recipient, LocalDateTime regDate, String done) {
		super();
		this.mannerNo = mannerNo;
		this.craigNo = craigNo;
		this.prefer = prefer;
		this.compliment = compliment;
		this.writer = writer;
		this.recipient = recipient;
		this.regDate = regDate;
		this.done = done;
	}
	
	
	
	
	
	
}
