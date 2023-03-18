package com.sh.oee.report.model.dto;


import java.time.LocalDateTime;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper=true)
@RequiredArgsConstructor
public class BoardReport extends ReportEntity{

	@NonNull
	private ReportType reportType;
	@NonNull
	private int reportPostNo;
	
	public BoardReport(@NonNull int reportNo, @NonNull String writer, LocalDateTime regDate, Status status,
			@NonNull ReportType reportType, @NonNull int reportPostNo) {
		super(reportNo, writer, regDate, status);
		this.reportType = reportType;
		this.reportPostNo = reportPostNo;
	}

	
	
	
}
