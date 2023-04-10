package com.sh.oee.common.interceptor;

import java.net.URLDecoder;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CookieInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		
		Cookie[] cookies = request.getCookies();
			if (cookies != null) {
				for (Cookie cookie : cookies) {
	                if (cookie.getName().equals("myDongList")) {
	                	String dongListStr = cookie.getValue(); // 쿠키값 스트링으로 변경
	                	String dongList = URLDecoder.decode(dongListStr);
	                    List<String> myDongList = Arrays.asList(dongList.split(":"));
	                    request.getSession().setAttribute("myDongList", myDongList);
	                    break;
	                }
				}
			}
		
		return HandlerInterceptor.super.preHandle(request, response, handler);
	}

}
