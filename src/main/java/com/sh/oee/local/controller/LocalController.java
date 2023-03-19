package com.sh.oee.local.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.sh.oee.local.model.service.LocalService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j 
public class LocalController {
	
	@Autowired
	private LocalService localService;
	
}
