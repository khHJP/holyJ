package com.sh.oee.manner.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sh.oee.manner.model.service.MannerService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/manner")
public class MannerController {

	@Autowired
	private MannerService mannerService;
}
