<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var = "nowUrl" value="${pageContext.request.requestURL}" />

 <!-- top bar navigation -->
<div class="headerbar">

    <!-- LOGO -->
    <div class="headerbar-left">
        <a href="${pageContext.request.contextPath}/main.do" class="logo">
            <img alt="Logo" src="${pageContext.request.contextPath}/assets/images/favicon.ico" />
            <span>오늘의 교밥</span>
        </a>
    </div>

    <nav class="navbar-custom">
    
    	<security:authorize ifNotGranted="ROLE_OPERATOR, ROLE_ADMIN, ROLE_USER">
	    	<ul class="list-inline float-right mb-0">
	            <li class="list-inline-item dropdown notif">
	                <a class="nav-link dropdown-toggle nav-user" data-toggle="dropdown" href="#" aria-haspopup="false" aria-expanded="false">
	                    Login
	                </a>
	                <div class="dropdown-menu dropdown-menu-right profile-dropdown ">
	                    <div class="dropdown-item noti-title">
	                        <h5 class="text-overflow">
	                            <small>SNS Login</small>
	                        </h5>
	                    </div>
	                    
	                    <a href="${googleUrl }" class="dropdown-item notify-item">
	                        <img src="${pageContext.request.contextPath}/assets/images/login_icon/google.png">
	                        <span>Google</span>
	                    </a>
	                    
	                    <%-- <a href="${naverUrl }" class="dropdown-item notify-item">
	                         <img src="${pageContext.request.contextPath}/assets/images/login_icon/naver.png">
	                        <span>Naver</span>
	                    </a> --%>
	                    
	                    <a href="${kakaoUrl }" class="dropdown-item notify-item">
	                         <img src="${pageContext.request.contextPath}/assets/images/login_icon/kakao.png">
	                        <span>Kakao</span>
	                    </a>
	                    
	                </div>
	            </li>
	        </ul>
        </security:authorize>
        
        <security:authorize ifAnyGranted="ROLE_OPERATOR">
       		<security:authentication property="principal.member_name" var="memberName"/>
			<ul class="list-inline float-right mb-0">
	            <li class="list-inline-item dropdown notif">
	                <a class="nav-link dropdown-toggle nav-user" data-toggle="dropdown" href="#" aria-haspopup="false" aria-expanded="false">
	                    <img src="${pageContext.request.contextPath}/assets/images/avatars/admin.png" alt="Profile image" class="avatar-rounded">
	                </a>
	                <div class="dropdown-menu dropdown-menu-right profile-dropdown ">
	                    <div class="dropdown-item noti-title">
	                        <h5 class="text-overflow">
	                            <small>${memberName }</small>
	                        </h5>
	                    </div>
	
	                    <a href="${pageContext.request.contextPath}/ou/main.do" class="dropdown-item notify-item">
	                        <i class="fas fa-user"></i>
	                        <span>회원 관리</span>
	                    </a>
	                    
	                    <a href="${pageContext.request.contextPath}/user/main.do" class="dropdown-item notify-item">
	                        <i class="fas fa-user"></i>
	                        <span>내 정보</span>
	                    </a>
	
	                    <a href="${pageContext.request.contextPath}/logout" class="dropdown-item notify-item">
	                        <i class="fas fa-power-off"></i>
	                        <span>Logout</span>
	                    </a>
	                </div>
	            </li>
	        </ul>
	    </security:authorize>
    

		<security:authorize ifAnyGranted="ROLE_ADMIN, ROLE_USER">
			<security:authentication property="principal.member_name" var="memberName"/>
			<ul class="list-inline float-right mb-0">
	            <li class="list-inline-item dropdown notif">
	                <a class="nav-link dropdown-toggle nav-user" data-toggle="dropdown" href="#" aria-haspopup="false" aria-expanded="false">
	                    <img src="${pageContext.request.contextPath}/assets/images/avatars/admin.png" alt="Profile image" class="avatar-rounded">
	                </a>
	                <div class="dropdown-menu dropdown-menu-right profile-dropdown ">
	                    <div class="dropdown-item noti-title">
	                        <h5 class="text-overflow">
	                            <small>${memberName }</small>
	                        </h5>
	                    </div>
	
	                    <a href="${pageContext.request.contextPath}/user/main.do" class="dropdown-item notify-item">
	                        <i class="fas fa-user"></i>
	                        <span>내 정보</span>
	                    </a>
	
	                    <a href="${pageContext.request.contextPath}/logout" class="dropdown-item notify-item">
	                        <i class="fas fa-power-off"></i>
	                        <span>Logout</span>
	                    </a>
	                </div>
	            </li>
	        </ul>
        </security:authorize>

        <ul class="list-inline menu-left mb-0">
            <li class="float-left">
                <button class="button-menu-mobile open-left">
                    <i class="fas fa-bars"></i>
                </button>
            </li>
        </ul>

    </nav>

</div>
<!-- End Navigation -->

<!-- Left Sidebar -->
<div class="left main-sidebar">
    <div class="sidebar-inner leftscroll">
        <div id="sidebar-menu">
		
            <ul>
                <li class="submenu">
	
                    <a class='<c:if test="${fn:contains(nowUrl , 'menu/')}">active</c:if>' href="${pageContext.request.contextPath}/menu/main.do">
                        <i class="fas fa-star"></i>
                        <span> 오늘의 점심 메뉴 </span>
                    </a>
                </li>
				
				<security:authorize ifAnyGranted="ROLE_OPERATOR, ROLE_ADMIN, ROLE_USER">
                <li class="submenu">
                    <a class='<c:if test="${fn:contains(nowUrl , 'user/')}">active</c:if>' href="${pageContext.request.contextPath}/user/main.do">
                        <i class="fas fa-user"></i>
                        <span> 내 정보 </span>
                    </a>
                </li>
                </security:authorize>

            </ul>

            <div class="clearfix"></div>

        </div>
    </div>
</div>
<!-- End Sidebar -->