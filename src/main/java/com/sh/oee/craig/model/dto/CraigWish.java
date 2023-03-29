package com.sh.oee.craig.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CraigWish {
	
	private int wishNo;
	private int CraigNo;
	private String memberId;
	private LocalDateTime regDate;
	

}
