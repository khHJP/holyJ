package com.sh.oee.admin.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sh.oee.member.model.dto.Member;
import com.sh.oee.report.model.dto.BoardReport;
import com.sh.oee.report.model.dto.UserReport;

@Mapper
public interface AdminDao {

	List<Member> selectAdminMemberList();

	List<BoardReport> selectAdminBoardReport();

	List<UserReport> selectAdminUserReport();

}
