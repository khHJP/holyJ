package com.sh.oee.report.model.service;

import java.util.List;

import com.sh.oee.report.model.dto.BoardReport;
import com.sh.oee.report.model.dto.ReportReason;
import com.sh.oee.report.model.dto.UserReport;

public interface ReportService {
	
	List<ReportReason> getReportReason(String reportType);

	int boardReportEnroll(BoardReport boardReport);

	int userReportEnroll(UserReport userReport);

}
