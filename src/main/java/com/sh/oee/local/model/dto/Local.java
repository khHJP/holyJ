package com.sh.oee.local.model.dto;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.sh.oee.member.model.dto.Member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
public class Local extends LocalEntity {
	private int attachCount;
	private List<LocalAttachment> attachments = new ArrayList<>();
	private Member member;
	
	
	public Local(int no, int categoryNo, String writer, String title, String content, LocalDateTime regDate, int hits) {
		super(no, categoryNo, writer, title, content, regDate, hits);
		this.attachCount = attachCount;
	}
	
	
	
	public void addAttachment(LocalAttachment attach) {
		this.attachments.add(attach);
		
	}



	public Local(int no, int categoryNo, String writer, String title, String content, LocalDateTime regDate, int hits,
			int attachCount, List<LocalAttachment> attachments, Member member) {
		super(no, categoryNo, writer, title, content, regDate, hits);
		this.attachCount = attachCount;
		this.attachments = attachments;
		this.member = member;
	}



}
