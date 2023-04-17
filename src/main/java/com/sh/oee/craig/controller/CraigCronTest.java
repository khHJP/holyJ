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
import com.sh.oee.manner.model.dto.Prefer;
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
	
/**	혜진만 주석풀고 메소드 실행합니다! -- 시연할때 그 노트북으로에서만 주석풀기  **/
	@Scheduled(cron="0 30 12 * * *")  // 11시 실행한다는 의미 
	public void craigCronSchedule() { // 매일 4시에 실행  

		// 1) 전체 매너리스트 확인한다  
		 List<Manner> mannerList = mannerService.craigCronSchedule();
		 log.debug("================================  매너온도 스케줄링  ======================================");
		 log.debug("스케줄링테스트 = {}" ,mannerList   );

		 // ** PREFER type - enum class 
		 String preferType1 = String.valueOf( Prefer.MA1 ) ;  
		 String preferType2 = String.valueOf( Prefer.MA2 ) ;
		 String preferType3 = String.valueOf( Prefer.MA3 ) ;

		 Map<String, Object> param = new HashMap<>();
		 
		 int result = 0;
		 int realResult = 0;
		 
		 // 2) for문 돌면서 각 사용자별 매너리스트의 매너온도 반영한다 
		 for(int i =0; i< mannerList.size()  ; i++) {
	 
			String prefer = mannerList.get(i).getPrefer().toString();
			String memberId = mannerList.get(i).getWriter();
			String compliment="";
			
			try {
				compliment = String.valueOf(mannerList.get(i).getCompliment()); //안쓰면 npe
				log.debug("compliment :  ", compliment);
				
			} catch (IllegalArgumentException  e) {
				log.error("IllegalArgumentException");
			}
		
			 param.put("prefer", prefer); //MA1, MA2, MA3
			 param.put("memberId", memberId);
			 param.put("compliment", compliment);
			 log.debug(" ■ param = {}" , param  ); 
			 
			// 매너온도 반영 
			 if( prefer.equals(preferType1) ||  prefer.equals(preferType2) || prefer.equals(preferType3) ) {
				 result = mannerService.updateMannerDegree(param); 	// MA1 : -0.5 ||  MA2' : +0.2  ||  'MA3' :  +0.5 로 업데이트 시키기 
				 log.debug(" ■ MA1 result " , result  ); 
			 }
			
			 log.debug(" ■■ result = {}", result); 
			 			 
			 int mannerNo = (int)mannerList.get(i).getMannerNo();
			 if( result > 0) {
				 realResult = mannerService.updateMannerDone(mannerNo); // done = 'Y' 시키기 
			 }
		 }// end - for문 
		 
		 log.debug(" ■■■ realResult(최종 잘 수행됐는지 확인) = {}", realResult);
		 log.debug("======================================================================");

	 }

}


/*
매일새벽1시에 실행하기 
@SchedulerLock(name = "craigCronSchedule", lockAtMostForString = TEN_MIN,  lockAtLeastForString = TEN_MIN)

 */
