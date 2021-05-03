package com.park.gyobab.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.park.gyobab.utils.OauthResources;

public class LoginIntercepter extends HandlerInterceptorAdapter{

	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
		
		String serverName = request.getServerName().equals("localhost") ? "https://" + request.getServerName() + ":8443" : "https://" + request.getServerName();
		
		// 소셜 로그인 URL 추가
		// 카카오 로그인 URL 생성
		String kakaoUrl = "https://kauth.kakao.com/oauth/authorize?"
		          + "client_id=" + OauthResources.KAKAO_CLIENT_ID
		          + "&redirect_uri=" + serverName + OauthResources.KAKAO_REDIRECT_URI
		          + "&response_type=code";
		
		// 구글 로그인 URL 생성
		String googleUrl = "https://accounts.google.com/o/oauth2/v2/auth?" 
				+ "scope=https://www.googleapis.com/auth/userinfo.email" 
				+ "&response_type=code" 
				+ "&state=security_token%3D138r5719ru3e1%26url%3Dhttps://oauth2.example.com/token" 
				+ "&client_id=" + OauthResources.GOOGLE_CLIENT_ID
				+ "&redirect_uri=" + serverName + OauthResources.GOOGLE_REDIRECT_URI
				+ "&access_type=offline";
		
		// 네이버 로그인 URL 생성
		String naverUrl = "https://nid.naver.com/oauth2.0/authorize?"
		          + "&client_id=" + OauthResources.NAVER_CLIENT_ID
		          + "&redirect_url=" + serverName + OauthResources.NAVER_REDIRECT_URI
		          + "&state=" + OauthResources.NAVER_STATE 
		          + "&response_type=code";
		
		request.setAttribute("kakaoUrl", kakaoUrl);
		request.setAttribute("googleUrl", googleUrl);
		request.setAttribute("naverUrl", naverUrl);
		
        return super.preHandle(request, response, handler);
    }
	
	
}
