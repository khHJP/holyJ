package com.sh.oee.member.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Dong {

	private int dongNo;
	private int guNo;
	private String dongName;
	private double latitude;
	private double longitude;
	
}
