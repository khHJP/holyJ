package com.sh.oee.together.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.sh.oee.together.model.service.TogetherService;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class TogetherCron {

	@Autowired
	private TogetherService togetherService;
	
	@Scheduled(cron = "0 0 4 1/1 * ?")
	public void TimeOverDateTimeUpdate() {
		togetherService.TimeOverDateTimeUpdate();
	}
	
}
