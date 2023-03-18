package com.sh.oee.together.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Together {

	private int no;
	private String writer;
	private int categoryNo;
	private String title;
	private String content;
	private int joinCnt;
	private LocalDateTime dateTime;
	private String place;
	private Gender gender;
	private String age;
	private LocalDateTime regDate;
	private String status;
	
}
