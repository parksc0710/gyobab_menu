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
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="icon" type="image/png"  href="${pageContext.request.contextPath}/assets/images/favicon.ico"/>
	<%@ include file="/WEB-INF/views/decorators/commonDecorator/commonInclude.jsp" %>
	<!-- //공통 추가 -->
	
	<!-- Global site tag (gtag.js) - Google Analytics -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=G-RG4WG5H8X6"></script>
	<script>
	  window.dataLayer = window.dataLayer || [];
	  function gtag(){dataLayer.push(arguments);}
	  gtag('js', new Date());
	
	  gtag('config', 'G-RG4WG5H8X6');
	</script>
	
	<c:set var = "nowUrl" value="${pageContext.request.requestURL}" />
	
	<c:choose>
	
		<c:when test="${!fn:contains(nowUrl , 'board/')}">
			<title>오늘의 교밥</title>
			<meta property="og:title" content="오늘의 교밥" />
			<%-- <meta property="og:image" content="${pageContext.request.contextPath}/assets/images/common/img_meta_972x511.jpg" /> --%>
			<meta property="og:description"	content="오늘의 교밥은?" />
			<meta property="og:url" content="https://www.gyobab.shop/">
			<meta property="og:image" content="https://www.gyobab.shop/images/hello.jpg">
		</c:when>
		
	</c:choose>
	
	<decorator:head />
</head>
<body class="adminbody-void">
	<div id="main" class="enlarged forced">
		<!-- header -->
		<%@ include file="/WEB-INF/views/decorators/header.jsp" %>
		<!-- //header -->
		
		<!-- content -->
		<div class="content-page">
			<decorator:body />
		</div>
		<!-- //content -->
		
		<!-- footer -->
		<%@ include file="/WEB-INF/views/decorators/footer.jsp" %>
		<!-- //footer -->
	</div>
	<script src="${pageContext.request.contextPath}/assets/js/admin.js"></script>
</body>
</html>