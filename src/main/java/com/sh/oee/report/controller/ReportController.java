package com.sh.oee.report.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sh.oee.report.model.service.ReportService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/report")
@Slf4j
public class ReportController {

	@Autowired(required = false)
	private ReportService reportService;
}
