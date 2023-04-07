package com.sh.oee.local.model.dto;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

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
public class Local extends LocalEntity {
	
	private int attachCount;
	private List<LocalAttachment> attachments = new ArrayList<>();
	private Member member;
	private Dong dong;
	private LocalCategory localcategory;
	
	
	//기본생성자
	public Local(int no, int categoryNo, String writer, String title, String content, LocalDateTime regDate, int hits, int attachCount, String reportYn) {
		super(no, categoryNo, writer, title, content, regDate, hits, reportYn);
	}
	
	
	
	public void addAttachment(LocalAttachment attach) {
		this.attachments.add(attach);
		
	}



	public Local(int no, int categoryNo, String writer, String title, String content, LocalDateTime regDate, int hits, String reportYn,
			int attachCount, List<LocalAttachment> attachments, Member member, Dong dong, LocalCategory localcategory) {
		super(no, categoryNo, writer, title, content, regDate, hits, reportYn);
		this.attachCount = attachCount;
		this.attachments = attachments;
		this.member = member;
		this.dong = dong;
		this.localcategory = localcategory;
	}



	





	
	
	

	

}
