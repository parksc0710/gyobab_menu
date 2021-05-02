package com.park.gyobab.web.filter;

import java.io.IOException;
import java.util.Date;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

public class AccessLogFilter implements Filter {

	private final Logger logger = Logger.getLogger(getClass());
	
	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

	/**
	 * 접근 로그를 남긴다. 
	 */
	@Override
	public void doFilter(ServletRequest req, ServletResponse res,
			FilterChain chain) throws IOException, ServletException {
		
		Date startDate = new Date();
		
		HttpServletRequest request = (HttpServletRequest)req;
		String context = request.getContextPath();
		String relativeUrl = request.getRequestURI();
		String queryString = request.getQueryString();
		
		
		String userName = "anonymous";
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(auth != null) {
			userName = auth.getName();	
		}
		
		try {
			chain.doFilter(request, res);
		}
		catch(Exception e) {
//			logger.error(e.getMessage(), e);
			e.printStackTrace();
		}
		finally {
			Date endDate = new Date();
			long responseTime = endDate.getTime() - startDate.getTime();
			
			logger.info(userName+","+context+","+relativeUrl+","+queryString+","+responseTime);
		}

	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub

	}

}
