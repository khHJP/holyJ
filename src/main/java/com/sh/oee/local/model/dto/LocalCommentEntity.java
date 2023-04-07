package com.sh.oee.local.model.dto;

import java.time.LocalDateTime;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class LocalCommentEntity extends LocalEntity{
	private int commentNo;
	private int localNo;
	private String writer;
	private int refNo;
	private int commentLevel;
	private String content;
	private LocalDateTime regDate;
	private LocalEntity localEntity;
	
	
	
}
