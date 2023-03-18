package com.sh.oee.report.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@RequiredArgsConstructor
public class ReportEntity {

	@NonNull
	private int reportNo;
	@NonNull
	private String writer;
	private LocalDateTime regDate;
	private Status status;
}
