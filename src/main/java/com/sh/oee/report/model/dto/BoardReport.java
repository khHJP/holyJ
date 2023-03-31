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
	
	// 0331 예지 추가
	private ReportReason reportReason;
	
	public BoardReport(int reportNo, @NonNull String writer, int reasonNo, LocalDateTime regDate, 
			Status status, @NonNull ReportType reportType, @NonNull int reportPostNo) {
		super(reportNo, writer, reasonNo, regDate, status);
		this.reportType = reportType;
		this.reportPostNo = reportPostNo;
	}

	
	
	
}
