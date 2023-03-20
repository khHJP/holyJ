package com.sh.oee.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.FlashMapManager;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.sh.oee.member.model.dto.Member;

import lombok.extern.slf4j.Slf4j;


@Slf4j
public class LoginInterceptor extends HandlerInterceptorAdapter{

	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// ★★★ preHandle : 전처리 -- 핸들러 호출 바로직전 그래서 얘는 항상 true인디 이걸 false하면 통과못해서 핸들러호출못하겟지 ?
		
		HttpSession session = request.getSession();
		Member loginMember = (Member) session.getAttribute("loginMember");
		log.debug(( loginMember != null ? "로그인한상태에서 요청!" : "비로그인 상태에서요청!!") );
		if(loginMember == null) {
			
			// 리다렉 하기전에 메세지 출력 ! 
			// 이 메소드 시그니처는 바꿀수없음 - RedirectAttributes 사용불가 ! 그래서 메세지 어떻게 출력할거야 ? 
			// FlashMap 이라는게있음 !  -
			FlashMap flashMap = new FlashMap();
			flashMap.put("msg", "로그인 후 이용가능합니다😣 ");
			FlashMapManager manager = RequestContextUtils.getFlashMapManager(request);
			manager.saveOutputFlashMap(flashMap, request, response);
			
			response.sendRedirect(request.getContextPath()+"/");
			return false; // ★★★ 여기서 t/f 설정하는거임 
		}
		
		return super.preHandle(request, response, handler);
	}
	
	
}
