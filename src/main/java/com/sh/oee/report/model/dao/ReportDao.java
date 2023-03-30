package com.sh.oee.report.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sh.oee.report.model.dto.BoardReport;
import com.sh.oee.report.model.dto.ReportReason;
import com.sh.oee.report.model.dto.UserReport;

@Mapper
public interface ReportDao {

	List<ReportReason> getReportReason(String reportType);

	int boardReportEnroll(BoardReport boardReport);

	int userReportEnroll(UserReport userReport);

}
