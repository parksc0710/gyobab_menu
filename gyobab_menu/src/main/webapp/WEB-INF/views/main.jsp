<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<div class="content">
	<img src="https://www.gyobab.shop:8883/images/hello.jpg" style="width:100%;max-width:639px;"/><br>
	이미지가 보이지 않으면 아래 버튼을 눌러서 인증서 허용을 해주세요.<br>
	<a href="https://www.gyobab.shop:8883/images/hello.jpg" target="_blank" class="btn btn-primary btn-sm btn-block" style="width:150px;">
		<i class="fas fa-search"></i> 인증서 허용하기
	</a>
	<br><br>
	<security:authorize ifAnyGranted="ROLE_OPERATOR, ROLE_ADMIN, ROLE_USER">
	<security:authentication property="principal.member_pass" var="memberPass"/>
	<c:choose>
		<c:when test="${memberPass != null || memberPass != '' }">
			<div class="row">
			    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-6">
			        <div class="card mb-3">
			            <div class="card-header">
			                <h3 style="display:inline"><b>내 온누리교회 바코드</b></h3>
			                	<a href="${pageContext.request.contextPath}/user/main.do" class="btn btn-primary btn-sm btn-block" style="width:80px;display:inline;float: right;">
									<i class="far fa-edit"></i> 변경
								</a>
			            </div>
			            <div class="card-body">
			            	<img src="${memberPass }" style="display: block; margin: 0px auto; width: 100%"/>
			            </div>
			        </div>
			    </div>
			</div>
		</c:when>
		<c:otherwise>
			<div class="row">
			    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-6">
			        <div class="card mb-3">
			            <div class="card-header">
			                <h3>내 온누리교회 바코드</h3><a href="${pageContext.request.contextPath}/user/main.do" target="_blank" class="btn btn-primary btn-sm btn-block" style="width:150px;">
								<i class="fas fa-search"></i> 등록하러 가기</a>
			            </div>
			            <div class="card-body">
			            	온누리 교회 바코드를 등록하시면 편리하게 볼 수 있습니다.
			            </div>
			        </div>
			    </div>
			</div>
		</c:otherwise>
	</c:choose>
	</security:authorize>
</div>