package com.sh.oee.local.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class LocalEntity {
	private int no;
	private int categoryNo;
	private String writer;
	private String title;
	private String content;
	private LocalDateTime regDate;
	private int hits;
	private String reportYn;

}
