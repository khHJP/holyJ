package com.sh.oee.common.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Component  
@Aspect
@Slf4j
public class ErrorlogAspect {

	@Pointcut("execution(* com.sh.oee..*Controller.*(..))") 
	public void pc() {
		
	}

	//log를 위한 try-catch 작성역할을 해줌 - 예외를 어떻게 처리하는게 아님 
	@AfterThrowing(pointcut = "pc()", throwing="e")
	public void errorLog(JoinPoint joinPoint, Exception e) {
		log.error(e.getMessage(), e);
	}
	
}
