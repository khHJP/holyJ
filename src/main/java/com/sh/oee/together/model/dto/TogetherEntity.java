package com.sh.oee.together.model.dto;

import java.time.LocalDateTime;

import com.sh.oee.member.model.dto.Dong;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
public class TogetherEntity {

	private int no;
	private String writer;
	private int categoryNo;
	private String title;
	private String content;
	private int joinCnt;
	private LocalDateTime dateTime;
	private String place;
	private Gender gender;
	private String age; // 20 30 40 .. 100
	private LocalDateTime regDate;
	private String status;
	private String reportYn;
	
}
