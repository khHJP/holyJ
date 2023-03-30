package com.sh.oee.admin.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.oee.admin.model.dao.AdminDao;
import com.sh.oee.craig.model.dto.Craig;
import com.sh.oee.local.model.dto.Local;
import com.sh.oee.member.model.dto.Member;
import com.sh.oee.report.model.dto.BoardReport;
import com.sh.oee.report.model.dto.UserReport;
import com.sh.oee.together.model.dto.Together;

@Service
@Transactional(rollbackFor = Exception.class)
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	private AdminDao adminDao;

	@Override
	public List<Member> selectAdminMemberList() {
		return adminDao.selectAdminMemberList();
	}
	
	@Override
	public List<Craig> selectAdminCraigList() {
		return adminDao.selectAdminCraigList();
	}

	@Override
	public List<Local> selectAdminLocalList() {
		return adminDao.selectAdminLocalList();
	}

	@Override
	public List<Together> selectAdminTogetherList() {
		return adminDao.selectAdminTogetherList();
	}

	@Override
	public List<BoardReport> selectAdminBoardReport() {
		return adminDao.selectAdminBoardReport();
	}

	@Override
	public List<UserReport> selectAdminUserReport() {
		return adminDao.selectAdminUserReport();
	}

}
