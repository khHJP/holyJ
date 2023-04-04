package com.sh.oee.manner.model.service;

import java.util.List;
import java.util.Map;

import com.sh.oee.manner.model.dto.Manner;

public interface MannerService {

	
	List<Manner> selectMannerList(String memberId);

	//혜진추가 - 0403
	List<Manner> craigCronSchedule();

	//혜진추가 - 0403 매너온도 한사람씩 체크해서 업데이트 
	int updateMannerDegree(  Map<String, Object> param );
	
	//혜진추가 - 0403 매너온도 compli~
	int updateComplimentDegree(Map<String, Object> param);
	
}
