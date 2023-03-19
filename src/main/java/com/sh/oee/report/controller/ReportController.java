package com.sh.oee.report.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sh.oee.report.model.service.ReportService;

import lombok.extern.slf4j.Slf4j;


@RequestMapping("/report")
@Slf4j
@Controller
public class ReportController {

	@Autowired
	private ReportService reportService;
}
