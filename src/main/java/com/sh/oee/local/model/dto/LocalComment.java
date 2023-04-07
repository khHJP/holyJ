package com.sh.oee.local.model.dto;

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
@ToString(callSuper = true)
public class LocalComment extends LocalCommentEntity {
	private Member member;
	private Dong dong;
	
	//기본 생성자
	public LocalComment(int commentNo, int localNo, String writer, int refNo, int commentLevel, String content,
			LocalDateTime regDate, LocalEntity localEntity) {
		super(commentNo, localNo, writer, refNo, commentLevel, content, regDate, localEntity);
		// TODO Auto-generated constructor stub
	}

	//매개변수 생성자
	public LocalComment(int commentNo, int localNo, String writer, int refNo, int commentLevel, String content,
			LocalDateTime regDate, LocalEntity localEntity, Member member, Dong dong) {
		super(commentNo, localNo, writer, refNo, commentLevel, content, regDate, localEntity);
		this.member = member;
		this.dong = dong;
	}
	
	
}


