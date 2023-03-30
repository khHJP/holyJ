package com.sh.oee.admin.model.service;

import java.util.List;

import com.sh.oee.craig.model.dto.Craig;
import com.sh.oee.local.model.dto.Local;
import com.sh.oee.member.model.dto.Member;
import com.sh.oee.report.model.dto.BoardReport;
import com.sh.oee.report.model.dto.UserReport;
import com.sh.oee.together.model.dto.Together;

public interface AdminService {

	List<Member> selectAdminMemberList();
	
	List<Craig> selectAdminCraigList();

	List<Local> selectAdminLocalList();

	List<Together> selectAdminTogetherList();

	List<BoardReport> selectAdminBoardReport();

	List<UserReport> selectAdminUserReport();

}
