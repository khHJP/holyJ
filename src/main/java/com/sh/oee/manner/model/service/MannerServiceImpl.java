package com.sh.oee.manner.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.oee.manner.model.dao.MannerDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MannerServiceImpl implements MannerService {

	@Autowired
	private MannerDao mannerDao;
}
