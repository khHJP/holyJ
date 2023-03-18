package com.sh.oee.report.model.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Data
@NoArgsConstructor
public class ReportReason {

	@NonNull
	private int reasonNo;
	@NonNull
	private ReportType reportType;
	@NonNull
	private String reasonName;
	
	
}
