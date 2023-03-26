package com.sh.oee.admin.model.service;

import java.util.List;

import com.sh.oee.member.model.dto.Member;
import com.sh.oee.report.model.dto.BoardReport;
import com.sh.oee.report.model.dto.UserReport;

public interface AdminService {

	List<Member> selectAdminMemberList();

	List<BoardReport> selectAdminBoardReport();

	List<UserReport> selectAdminUserReport();

}
