package com.itbank.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;



public class MemberLoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		if(session.getAttribute("login") == null) {
			if(request.getRequestURI().equals("/team/member/login")) {
				return true;
			}else {
				response.sendRedirect(request.getContextPath() + "/member/login");
				return false;
			}
		}
		if(session.getAttribute("login") != null && request.getRequestURI().equals("/team/member/login")) {
			response.sendRedirect(request.getContextPath() + "/");
			return false;	
		}
		
		return true;		
	}
	
}







