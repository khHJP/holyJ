package com.sh.oee.member.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member {
	
	private String memberId;
	private String password;
	private String nickname;
	private String phone;
	private int manner;
	private String profileImg;
	private int dongNo;
	private DongRange dongRange;
	private int reportCnt;
	private LocalDateTime enrollDate;
	private LocalDateTime deleteDate;
}
