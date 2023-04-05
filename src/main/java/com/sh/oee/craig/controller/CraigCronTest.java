package com.sh.oee.craig.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.sh.oee.manner.model.dto.Manner;
import com.sh.oee.manner.model.service.MannerService;
import com.sh.oee.member.model.service.MemberService;

import lombok.extern.slf4j.Slf4j;
import net.javacrumbs.shedlock.core.SchedulerLock;
import net.javacrumbs.shedlock.spring.annotation.EnableSchedulerLock;

//@EnableScheduling
//@EnableSchedulerLock(defaultLockAtMostFor = "PT30S", defaultLockAtLeastFor = "PT30S") // (기본 세팅)30초동안 Lock
@Component
@Slf4j
public class CraigCronTest {
	
	private static final String TEN_MIN = "PT10M"; // 10분동안 Lock

	@Autowired
	private MannerService mannerService;
	
	@Scheduled(cron="0 54 10 * * *")
	@SchedulerLock(name = "craigCronSchedule", lockAtMostForString = TEN_MIN,  lockAtLeastForString = TEN_MIN)
	public void craigCronSchedule() {//매일 19시에 실행 -- 잘되면 오전 1시로 바꾸기 
	// 4/2일의 매너평가가 반영된 tigerhj의 매너온도는 36.5도 -> +0.2 +0.5  +0.1 +0.1 = 36.5 +0.9 = 37.4도가 되어야한다  
	// 새벽 4시에 한번 더 실행되는지체크하기  37.4+ 0.9 = 38.3 
		 
		log.debug("==========================   메소드 시작   =================================");
		 // 1) 전체 매너리스트 확인한다  
		 List<Manner> mannerList = mannerService.craigCronSchedule();
		 log.debug("스케줄링테스트 = {}" ,mannerList   );

		 // ** PREFER type
		 String preferType1 = "MA1";
		 String preferType2 = "MA2";
		 String preferType3 = "MA3";

		 Map<String, Object> param = new HashMap<>();
		 int result = 0;
		 for(int i =0; i< mannerList.size()  ; i++) {
	 
			 String prefer = mannerList.get(i).getPrefer().toString();
			 String memberId = mannerList.get(i).getWriter();
			 String compliment = mannerList.get(i).getCompliment().toString();
			 
			 param.put("prefer", prefer); //MA1, MA2, MA3
			 param.put("memberId", memberId);
			 log.debug(" ■ param = {}" , param  ); 
			 
			 if( prefer.equals(preferType1) ||  prefer.equals(preferType2) || prefer.equals(preferType3) ) {
				 // MA1 : -0.5 ||  MA2' : +0.2  ||  'MA3' :  +0.5 로 업데이트 시키기 
				 result = mannerService.updateMannerDegree(param);
				 log.debug(" ■ MA1 result " , result  ); 
			 }
			
			 //compliment 있을경우 +0.1
			 if( compliment.length() > 0) {
				 result += mannerService.updateComplimentDegree(param);
				 log.debug(" ■ compliment " , compliment  ); 
			 }
			 
			 log.debug(" ★★★ result = {}", result); //최대 2개여야됨 			
			 
		 }// end - for문 

		 log.debug("======================================================================");

	 }

}


/*

어제 4/2일 12시 ~ 23:59분까지 
반영된 매너온도를 오늘 새벽 1시에 작업하고 
오늘 꺼는 낼 새벽에 작업한다 
 
 */
