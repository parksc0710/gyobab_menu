<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.springframework.context.*" %>
<%@ page import="org.springframework.web.context.support.*" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE HTML>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	
	<!-- 공통 추가 -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<%@ include file="/WEB-INF/views/decorators/commonDecorator/commonInclude.jsp" %>
	<!-- //공통 추가 -->

	<title>오늘의 교밥</title>
	<meta property="og:title" content="오늘의 교밥" />
	<%-- <meta property="og:image" content="${pageContext.request.contextPath}/assets/images/common/img_meta_972x511.jpg" /> --%>
	<meta property="og:description"	content="오늘의 교밥은?" />

	
	<decorator:head />
</head>
<body>
	<div id="wrap">
		<!-- header -->
		<%@ include file="/WEB-INF/views/decorators/header.jsp" %>
		<!-- //header -->
		
		<!-- content -->
		<decorator:body />
		<!-- //content -->
		
		<!-- footer -->
		<%@ include file="/WEB-INF/views/decorators/footer.jsp" %>
		<!-- //footer -->
	</div>
</body>
</html>