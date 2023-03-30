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
	
	public UserReport(int reportNo, @NonNull String writer, int reasonNo, LocalDateTime regDate, 
			Status status, @NonNull String reportedMember) {
		super(reportNo, writer, reasonNo, regDate, status);
		this.reportedMember = reportedMember;
	}
	
	
	
}
