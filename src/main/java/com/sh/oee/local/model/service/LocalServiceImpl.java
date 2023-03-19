package com.sh.oee.local.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.oee.local.model.dao.LocalDao;

@Service
public class LocalServiceImpl implements LocalService {
	
	@Autowired
	private LocalDao localDao;
}
