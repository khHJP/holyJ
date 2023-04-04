package com.sh.oee.together.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.sh.oee.together.model.service.TogetherService;

import lombok.extern.slf4j.Slf4j;
import net.javacrumbs.shedlock.core.SchedulerLock;
import net.javacrumbs.shedlock.spring.annotation.EnableSchedulerLock;

@EnableScheduling
@EnableSchedulerLock(defaultLockAtMostFor = "PT30S", defaultLockAtLeastFor = "PT30S") // (기본 세팅)30초동안 Lock
@Component
@Slf4j
public class TogetherCron {

	private static final String TEN_MIN = "PT10M";
	
	@Autowired
	private TogetherService togetherService;
	
	
	@Scheduled(cron = "0 0 0/1 1/1 * ?")
	@SchedulerLock(name = "togetherCron", lockAtMostForString = TEN_MIN,  lockAtLeastForString = TEN_MIN)
	public void TimeOverDateTimeUpdate() {
		togetherService.TimeOverDateTimeUpdate();
	}
	
}
