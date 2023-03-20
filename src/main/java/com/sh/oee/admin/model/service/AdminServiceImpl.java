package com.sh.oee.admin.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.oee.admin.model.dao.AdminDao;
import com.sh.oee.member.model.dto.Member;

@Service
@Transactional(rollbackFor = Exception.class)
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	private AdminDao adminDao;

}
