package com.sh.oee.craig.controller;

import javax.sql.DataSource;

import org.springframework.context.annotation.Bean;

import net.javacrumbs.shedlock.core.LockProvider;
import net.javacrumbs.shedlock.provider.jdbctemplate.JdbcTemplateLockProvider;

public class ScheduleController {

	  @Bean
	  public LockProvider lockProvider(DataSource dataSource) {
	        return new JdbcTemplateLockProvider(dataSource);
	    }

}
