package com.sh.oee.craig.model.dto;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.sh.oee.member.model.dto.Dong;
import com.sh.oee.member.model.dto.DongRange;
import com.sh.oee.member.model.dto.Member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@ToString(callSuper=true)
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Craig extends CraigEntity {
	
	private int attachCount; //첨부파일개수
	private List<CraigAttachment> attachments = new ArrayList<>();
	private Member  member; // 작성자관련한 정보 가져올거야
	private DongRange dongrange; // 동찾을거야,,
	private Dong dong; //동테이블
	private int wish;
	
	
	
	
	
	

	
	public void addAttachment(CraigAttachment attach) {
		this.attachments.add(attach);		
	}





	public Craig(int no, int categoryNo, String writer, String title, String content, LocalDateTime regDate,
			Double latitude, Double longitude, String placeDetail, int price, int hits, State state, String buyer,
			Date completeDate, int attachCount) {
		super(no, categoryNo, writer, title, content, regDate, latitude, longitude, placeDetail, price, hits, state,
				buyer, completeDate);
		this.attachCount = attachCount;
	}





	public Craig(int no, int categoryNo, String writer, String title, String content, LocalDateTime regDate,
			Double latitude, Double longitude, String placeDetail, int price, int hits, State state, String buyer,
			Date completeDate, int attachCount, List<CraigAttachment> attachments, Member member, DongRange dongrange,
			Dong dong) {
		super(no, categoryNo, writer, title, content, regDate, latitude, longitude, placeDetail, price, hits, state,
				buyer, completeDate);
		this.attachCount = attachCount;
		this.attachments = attachments;
		this.member = member;
		this.dongrange = dongrange;
		this.dong = dong;
	}





	public Craig(int no, int categoryNo, String writer, String title, String content, LocalDateTime regDate,
			Double latitude, Double longitude, String placeDetail, int price, int hits, State state, String buyer,
			Date completeDate, List<CraigAttachment> attachments, Member member, DongRange dongrange, Dong dong) {
		super(no, categoryNo, writer, title, content, regDate, latitude, longitude, placeDetail, price, hits, state,
				buyer, completeDate);
		this.attachments = attachments;
		this.member = member;
		this.dongrange = dongrange;
		this.dong = dong;
	}

	
	
	
	public Craig(int no, int categoryNo, String writer, String title, String content, LocalDateTime regDate,
			Double latitude, Double longitude, String placeDetail, int price, int hits, State state, String buyer,
			Date completeDate, int attachCount, List<CraigAttachment> attachments, Member member, DongRange dongrange,
			Dong dong, int wish) {
		super(no, categoryNo, writer, title, content, regDate, latitude, longitude, placeDetail, price, hits, state,
				buyer, completeDate);
		this.attachCount = attachCount;
		this.attachments = attachments;
		this.member = member;
		this.dongrange = dongrange;
		this.dong = dong;
		this.wish = wish;
	}



}
