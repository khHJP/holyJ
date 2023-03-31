package com.sh.oee.local.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class LocalLike {
	private int likeNo;
	private String memberId;
	private int localNo;
	private int likecheck;
}