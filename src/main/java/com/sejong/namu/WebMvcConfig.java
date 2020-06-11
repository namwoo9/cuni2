package com.sejong.namu;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
	@Autowired
	@Qualifier("beforeActionInterceptor")
	HandlerInterceptor beforeActionInterceptor;

	@Autowired
	@Qualifier("needToLoginInterceptor")
	HandlerInterceptor needToLoginInterceptor;

	@Autowired
	@Qualifier("needToLogoutInterceptor")
	HandlerInterceptor needToLogoutInterceptor;

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		// beforeActionInterceptor 를 모든 액션(/**)에 연결합니다. 단 /resource 로 시작하는 액션은 제외
		registry.addInterceptor(beforeActionInterceptor).addPathPatterns("/**").excludePathPatterns("/resource/**");

		// 여기 추가 되는 건 로그인 안 해도 볼 수 있는 경로
		// /resouce로 시작하는 URL
		registry.addInterceptor(needToLoginInterceptor).addPathPatterns("/**").excludePathPatterns("/member/login")
				.excludePathPatterns("/member/doLogin").excludePathPatterns("/member/join")
				.excludePathPatterns("/member/doJoin").excludePathPatterns("/member/findInfo")
				.excludePathPatterns("/member/confirm").excludePathPatterns("/member/doSearchId")
				.excludePathPatterns("/member/doSearchPw").excludePathPatterns("/article/list")
				.excludePathPatterns("/article/getReplies").excludePathPatterns("/resource/**")
				.excludePathPatterns("/").excludePathPatterns("/user/idCheck").excludePathPatterns("/user/nameCheck");

		// 로그인, 로그인처리, 가입, 가입 처리는 로그인 상태일 때 접근할 수 없다.
		registry.addInterceptor(needToLogoutInterceptor).addPathPatterns("/member/login")
				.addPathPatterns("/member/doLogin").addPathPatterns("/member/join").addPathPatterns("/member/doJoin")
				.addPathPatterns("/member/findInfo");
	}

}