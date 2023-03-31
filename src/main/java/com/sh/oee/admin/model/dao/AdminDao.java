package com.sh.oee.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sh.oee.craig.model.dto.Craig;
import com.sh.oee.local.model.dto.Local;
import com.sh.oee.member.model.dto.Member;
import com.sh.oee.report.model.dto.BoardReport;
import com.sh.oee.report.model.dto.UserReport;
import com.sh.oee.together.model.dto.Together;

@Mapper
public interface AdminDao {

	List<Member> selectAdminMemberList();
	
	List<Craig> selectAdminCraigList();

	List<Local> selectAdminLocalList();

	List<Together> selectAdminTogetherList();

	List<BoardReport> selectAdminBoardReport();

	List<UserReport> selectAdminUserReport();
	
	int updateAdminMemberRole(Map<String, Object> adminMemberRoleUpdateMap);

	int updateAdminCraigCategory(String no, String categoryNo);

	int updateAdminLocalCategory(String no, String categoryNo);

	int updateAdminTogetherCategory(Map<String, Object> adminTogetherCategoryMap);

	int deleteAdminMember(String memberId);

}
