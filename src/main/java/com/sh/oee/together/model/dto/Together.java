package com.sh.oee.together.model.dto;

import java.time.LocalDateTime;

import com.sh.oee.member.model.dto.Dong;
import com.sh.oee.member.model.dto.Member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper=true)
public class Together extends TogetherEntity {
	
	private Member member;
	private Dong dong;
	
	// 기본생성자
	public Together(int no, String writer, int categoryNo, String title, String content, int joinCnt,
			LocalDateTime dateTime, String place, Gender gender, String age, LocalDateTime regDate, String status,
			String reportYn) {
		super(no, writer, categoryNo, title, content, joinCnt, dateTime, place, gender, age, regDate, status, reportYn);
	}

	// 매개변수생성자
	public Together(int no, String writer, int categoryNo, String title, String content, int joinCnt,
			LocalDateTime dateTime, String place, Gender gender, String age, LocalDateTime regDate, String status,
			String reportYn, Member member, Dong dong) {
		super(no, writer, categoryNo, title, content, joinCnt, dateTime, place, gender, age, regDate, status, reportYn);
		this.member = member;
		this.dong = dong;
	}
	

}