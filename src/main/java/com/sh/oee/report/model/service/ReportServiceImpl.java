package com.sh.oee.report.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.oee.report.model.dao.ReportDao;
import com.sh.oee.report.model.dto.BoardReport;
import com.sh.oee.report.model.dto.ReportReason;
import com.sh.oee.report.model.dto.UserReport;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional(rollbackFor = Exception.class)
public class ReportServiceImpl implements ReportService {
	
	@Autowired
	private ReportDao reportDao;

	@Override
	public List<ReportReason> getReportReason(String reportType) {
		return reportDao.getReportReason(reportType);
	}

	@Override
	public int boardReportEnroll(BoardReport boardReport) {
		return reportDao.boardReportEnroll(boardReport);
	}

	@Override
	public int userReportEnroll(UserReport userReport) {
		return reportDao.userReportEnroll(userReport);
	}

}
