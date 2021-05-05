package com.park.gyobab.controller.sign;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.JsonNode;
import com.park.gyobab.domain.MemberVO;
import com.park.gyobab.service.MemberService;
import com.park.gyobab.utils.GetOAuthResource;
import com.park.gyobab.utils.OauthResources;

@Controller
public class SignController {
	
	@Autowired
    private MemberService service;

	@Autowired 
	protected HttpServletRequest request;
	
	public boolean socialLoginDo(HttpServletRequest request, String type, String inEmail) throws Exception {
		
		boolean rtn = false;
		
		/*
		 *  소셜 로그인 프로레스
		 *  1. type 과 이메일을 가지고 DB에서 가입여부 확인
		 *  2. 값이 없으면 false 리턴, 값이 있으면 가입 처리 후 true 리턴
		 */
		
		if(!checkSocialUser(type, inEmail)) {
			return rtn;
		}
		
		UserDetails userInfo = getUserInfoSocial(type, inEmail); 
	    
	    Authentication authentication = new UsernamePasswordAuthenticationToken(userInfo, "OAUTH", userInfo.getAuthorities());
	    SecurityContext securityContext = SecurityContextHolder.getContext();
	    securityContext.setAuthentication(authentication);
	    
	    HttpSession session = request.getSession(true);
	    session.setAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY, securityContext);
	    
	    rtn = true;
    
		
		return rtn;
	}
	
	private boolean checkSocialUser(String type, String inEmail) throws Exception {
		// 가입 여부 확인		
		// email select 해서 있으면 true 없으면 false 리턴
		MemberVO tmpMember = service.selectMemberByEmail(inEmail);
		
		if(tmpMember == null) {
			return false;
		} else {
			return true;
		}
	}
	
	private UserDetails getUserInfoSocial(String type, String inEmail) throws Exception {

		//System.out.println("type : " + type + " // inEmail : " + inEmail);
		// 정보 조회 후 UserDetails 객체 리턴		
		UserDetails rtnUserDetails = getSocialUserDetail(type, inEmail);
		
		return rtnUserDetails;
	}
	
	// Oauth2.0으로 이메일 주소 불러오는 메소드
	public String getOAuthResource(String code, String resourceServer) throws UnsupportedEncodingException {
		
		String serverName = request.getServerName().equals("localhost") ? "https://" + request.getServerName() + ":8443" : "https://" + request.getServerName() + ":8444";
		
		//System.out.println("serverName : " + serverName);
		
		String clientId = "";
		String clientSecret = "";
		String myRedirectURI = "";
		String authorizationRequestURI = "";
		String resourceOwnerRequestURI = "";
		
		String resourceKey = "";
		String resourceValue = "";
		
		// 리소스 키 설정
		if(resourceServer.equals("kakao")) {
			clientId = OauthResources.KAKAO_CLIENT_ID;
			clientSecret = OauthResources.KAKAO_CLIENT_SECRET;
			myRedirectURI = serverName + OauthResources.KAKAO_REDIRECT_URI;
			authorizationRequestURI = OauthResources.KAKAO_AUTH_URL;
			resourceOwnerRequestURI = OauthResources.KAKAO_RESOURCE_URL;
			resourceKey = "email";
		} else if(resourceServer.equals("google")) {
			clientId = OauthResources.GOOGLE_CLIENT_ID;
			clientSecret = OauthResources.GOOGLE_CLIENT_SECRET;
			myRedirectURI = serverName + OauthResources.GOOGLE_REDIRECT_URI;
			authorizationRequestURI = OauthResources.GOOGLE_AUTH_URL;
			resourceOwnerRequestURI = OauthResources.GOOGLE_RESOURCE_URL;
			resourceKey = "email";
		} else if(resourceServer.equals("naver")) {
			clientId = OauthResources.NAVER_CLIENT_ID;
			clientSecret = OauthResources.NAVER_CLIENT_SECRET;
			myRedirectURI = serverName + OauthResources.NAVER_REDIRECT_URI;
			authorizationRequestURI = OauthResources.NAVER_AUTH_URL;
			resourceOwnerRequestURI = OauthResources.NAVER_RESOURCE_URL;
			resourceKey = "email";
		}
		
		GetOAuthResource getOAuthResource = new GetOAuthResource(clientId, clientSecret, myRedirectURI, authorizationRequestURI, resourceOwnerRequestURI);
		
		// 코드 발급
		//System.out.println("code : " + code);
		
		// Access Token // Refresh Token 발급
		JsonNode jsonToken = getOAuthResource.getAccessToken(code);
		String accessToken = jsonToken.get("access_token").toString();
		String refreshToken = "";
		if(jsonToken.has("refresh_token")) {
			refreshToken = jsonToken.get("refresh_token").toString();
		}
		String expiresTime = jsonToken.get("expires_in").toString();
		//System.out.println("Access Token : " + accessToken);
		//System.out.println("Refresh Token : " + refreshToken);
		//System.out.println("Expires Time : " + expiresTime);

		// Access Token으로 사용자 정보 반환
		JsonNode userInfo;
		if(resourceServer.equals("google")) {
			userInfo = getOAuthResource.getUserInfoGet(accessToken);
		} else {
			userInfo = getOAuthResource.getUserInfoPost(accessToken);
		}
		
		//System.out.println(userInfo.toString());
		
		if(resourceServer.equals("kakao")) {
			try {
				resourceValue = userInfo.get("kakao_account").get(resourceKey).asText();
			} catch (Exception e) {
				resourceValue = "";
			}
		} else if(resourceServer.equals("naver")) {
			try {
				resourceValue = userInfo.get("response").get(resourceKey).asText();
			} catch (Exception e) {
				resourceValue = "";
			}
		} else {
			try {
				resourceValue = userInfo.get(resourceKey).asText();
			} catch (Exception e) {
				resourceValue = "";
			}
		}
		
		return resourceValue;
		
	}
	
	
	// 카카오 로그인 콜백
	@RequestMapping(value = "/kakaoLogin")
	public String kakaoLogin(@RequestParam("code") String code, HttpSession session, HttpServletRequest request, Model model) throws Exception {

		String socialMail = getOAuthResource(code, "kakao");
		
		if(socialLoginDo(request, "kakao", socialMail)) {
			
			loginSuccessDo();
			
			return "redirect:/";
		}
		
		model.addAttribute("socialMail", socialMail);
		
		return "sign/snsup";
	}
	
	// 구글 로그인 콜백
	@RequestMapping(value = "/googleLogin")
	public String googleLogin(@RequestParam("code") String code, HttpSession session, HttpServletRequest request, Model model) throws Exception {

		String socialMail = getOAuthResource(code, "google");
		
		if(socialLoginDo(request, "google", socialMail)) {
			
			loginSuccessDo();
			
			return "redirect:/";
		}
		
		model.addAttribute("socialMail", socialMail);
		
		return "sign/snsup";
		
	}
	
	// 네이버 로그인 콜백
	@RequestMapping(value = "/naverLogin")
	public String naverLogin(@RequestParam("code") String code, HttpSession session, HttpServletRequest request, Model model) throws Exception {

		String socialMail = getOAuthResource(code, "naver");
		
		if(socialLoginDo(request, "naver", socialMail)) {
			
			loginSuccessDo();
			
			return "redirect:/";
		}
		
		model.addAttribute("socialMail", socialMail);
		
		return "sign/snsup";
		
	}
	
	@RequestMapping(value = "checkNick", produces = "application/json;charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public String checkNick( 
							@RequestParam(value = "nickname", required = true) String nickname
						) throws Exception {
		
		String rtn = "";
		
		int tmpMember = 0;
		
		tmpMember =	service.selectMemberIdByName(nickname);
		
		if(tmpMember > 0) {
			rtn = "fail";
		} else {
			rtn = "success";
		}
		
		return rtn;
	}
	
	@RequestMapping(value = "singup", produces = "application/json;charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public String singup( 
			@RequestParam(value = "email", required = true) String email,				
			@RequestParam(value = "nickname", required = true) String nickname,
			HttpServletRequest request
						) throws Exception {
		
		String rtn = "";
		
		//System.out.println("email : " + email + " // nickname : " + nickname);
		MemberVO tmp = new MemberVO();
		tmp.setMember_email(email);
		tmp.setMember_name(nickname);
		service.insertMember(tmp);
		service.insertMemberGrantUser(tmp);
		
		socialLoginDo(request, "", email);
		
		return rtn;
	}
	
	// 소셜 로그인 성공 후 처리할 작업 설정
	private void loginSuccessDo() {
		MemberVO nowUser = (MemberVO) (SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		if(nowUser != null) {
			System.out.println(nowUser.getMember_email() + " // " + nowUser.getMember_grant());
		} else {
			System.out.println("nowUser is null");
		}
	}
	
	private MemberVO getSocialUserDetail(String type, String inEmail) throws Exception {
		MemberVO tmpUser = service.selectMemberByEmail(inEmail);
		return tmpUser;
	}
}
