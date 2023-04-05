
package com.sh.oee.craig.controller;

import javax.sql.DataSource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Component;

import net.javacrumbs.shedlock.core.LockProvider;
import net.javacrumbs.shedlock.provider.jdbctemplate.JdbcTemplateLockProvider;
import net.javacrumbs.shedlock.spring.annotation.EnableSchedulerLock;

//@Configuration
//@EnableScheduling
//@EnableSchedulerLock(defaultLockAtMostFor = "PT30S", defaultLockAtLeastFor = "PT30S") // (기본 세팅)30초동안 Lock
public class SchedulerConfiguration {

/**
	@Bean
	  public LockProvider lockProvider(DataSource dataSource) {
	        return new JdbcTemplateLockProvider(dataSource);
	    }
**/
}
