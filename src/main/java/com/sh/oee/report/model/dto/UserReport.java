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
	private int reasonNo;
	@NonNull
	private String reportedMember;
	
	public UserReport(@NonNull int reportNo, @NonNull String writer, LocalDateTime regDate, Status status,
			@NonNull int reasonNo, @NonNull String reportedMember) {
		super(reportNo, writer, regDate, status);
		this.reasonNo = reasonNo;
		this.reportedMember = reportedMember;
	}
	
	
	
}
