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
public class UserReport extends ReportEntity{

	@NonNull
	private String reportedMember;
	
	// 0331 예지 추가
	private ReportReason reportReason;
	
	public UserReport(int reportNo, @NonNull String writer, int reasonNo, LocalDateTime regDate, 
			Status status, @NonNull String reportedMember) {
		super(reportNo, writer, reasonNo, regDate, status);
		this.reportedMember = reportedMember;
	}
	
	
	
}
