package com.sh.oee.manner.model.service;

import java.util.List;
import java.util.Map;

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

	// ☏☏☏☏☏☏☏☏ 하나 추가 ☏☏☏☏☏☏☏☏ //

	@Override
	public List<Manner> selectMannerList(String memberId) {
		// TODO Auto-generated method stub
		return mannerDao.selectMannerList(memberId);
	}
	@Override
	public List<Manner> selectMannerList1(String memberId) {
		// TODO Auto-generated method stub
		return mannerDao.selectMannerList1(memberId);
	}
	@Override
	public List<Manner> selectSendMannerList(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return mannerDao.selectSendMannerList(param);
	}
	@Override
	public List<Manner> selectTakeMannerList(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return mannerDao.selectTakeMannerList(param);
	}
	// ☏☏☏☏☏☏☏☏ 하나 끝 ☏☏☏☏☏☏☏☏ //

	//혜진추가 - 0403 
	@Override
	public List<Manner> craigCronSchedule() {
		return mannerDao.craigCronSchedule();
	}

	//혜진추가 - 0403 매너온도 한사람씩 체크해서 업데이트 
	@Override
	public int updateMannerDegree(  Map<String, Object> param ) {
		return mannerDao.updateMannerDegree(param);
	}

	//혜진추가
	@Override
	public int updateComplimentDegree(Map<String, Object> param) {
		return mannerDao.updateComplimentDegree(param);
	}
	
	//혜진추가
	@Override
	public int updateMannerDone(int mannerNo) {
		return mannerDao.updateMannerDone( mannerNo );
	}

	
	// 혜진추가 
	@Override
	public int craigMannerEnroll(Manner manner) {
		return mannerDao.craigMannerEnroll(manner);
	}

	//혜진추가 - 내가 매너평가한거있냐 
	@Override
	public Manner selectMannerOne(Map<String, Object> mannerMap) {
		return mannerDao.selectMannerOne(mannerMap);
	}


}
