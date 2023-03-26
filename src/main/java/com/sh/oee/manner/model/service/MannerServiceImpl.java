package com.sh.oee.manner.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.oee.manner.model.dao.MannerDao;
import com.sh.oee.manner.model.dto.Manner;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MannerServiceImpl implements MannerService {

	@Autowired
	private MannerDao mannerDao;

	@Override
	public List<Manner> selectMannerList(String memberId) {
		// TODO Auto-generated method stub
		return mannerDao.selectMannerList(memberId);
	}
}
