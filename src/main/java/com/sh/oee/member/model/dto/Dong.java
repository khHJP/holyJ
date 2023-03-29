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
	
	//혜진추가0329
	private Gu gu;

	public Dong(int dongNo, int guNo, String dongName, double latitude, double longitude) {
		super();
		this.dongNo = dongNo;
		this.guNo = guNo;
		this.dongName = dongName;
		this.latitude = latitude;
		this.longitude = longitude;
	}


	
	
}
