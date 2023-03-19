package com.sh.oee.member.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member {
	
	@NonNull
	private String memberId;
	@NonNull
	private String password;
	@NonNull
	private String nickname;
	@NonNull
	private String phone;
	private double manner;
	private String profileImg;
	private int dongNo;
	@NonNull
	private DongRange dongRange;
	private int reportCnt;
	private LocalDateTime enrollDate;
	private LocalDateTime deleteDate;
}
