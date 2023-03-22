package com.sh.oee.common.aop;

import java.util.List;
import java.util.Map;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;

import com.sh.oee.craig.model.dto.Craig;

import lombok.extern.slf4j.Slf4j;

@Component
@Aspect
@Slf4j
public class EscapeXmlAspect {

	@Pointcut("execution(* com.sh.oee.craig..*(..))")
	public void pointcut() {}
	
/** 앞에 list에서 걸려버릶
	@AfterReturning(pointcut = "pointcut()", returning = "returnObj")
	public void escapeXml(JoinPoint joinPoint, Object returnObj) {
		log.debug( "returnObj = {}" , returnObj);

		ModelAndView mav = (ModelAndView)returnObj;
		
		Map<String, Object> model = mav.getModel() ;
		List<Craig> craigList = (List<Craig>) model.get("craigList");
		
		for(Craig craig : craigList) {
			String maybeXss = craig.getContent();
			craig.setContent( escapeXml(maybeXss));
		}

	}
 **/

	private String escapeXml(String maybeXss) {
		
		return maybeXss.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
	}
	
}	
