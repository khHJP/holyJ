package com.sh.oee.craig.controller;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class CraigCronTest {
	
	 //scheduling - 0403
	 @Scheduled(cron = "0/5 * * * * *")
	 public void craigCronScheduleTest() {
		// log.debug("scheduling 실행 테스트 - 5초에 1번씩 console찍기 ");
	 }
	 
	 

}
