package com.sh.oee.local.model.dto;

import java.time.LocalDateTime;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor	
public class LocalAttachment {
	private int attachNo;
	private int localNo;
	private String originalFilename;
	private String reFilename;
	private LocalDateTime regDate;
}
