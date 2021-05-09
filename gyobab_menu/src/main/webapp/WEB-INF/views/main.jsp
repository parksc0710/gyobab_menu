<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<div class="content">
	<img src="https://www.gyobab.shop:8883/images/hello.jpg" style="width:100%;max-width:639px;"/><br>
	이미지가 보이지 않으면 아래 버튼을 눌러서 인증서 허용을 해주세요.<br>
	<a href="https://www.gyobab.shop:8883/images/hello.jpg" target="_blank" class="btn btn-primary btn-sm btn-block" style="width:150px;">
		<i class="fas fa-search"></i> 인증서 허용하기
	</a>
	<br><br>
	<security:authorize ifAnyGranted="ROLE_OPERATOR, ROLE_ADMIN, ROLE_USER">
	<security:authentication property="principal.member_pass" var="memberPass"/>
		<div class="row">
		    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-6">
		        <div class="card mb-3">
		            <div class="card-header">
		                <h3>내 온누리교회 바코드</h3>
		            </div>
		            <div class="card-body">
		            	<img src="${memberPass }" style="display: block; margin: 0px auto;"/>
		            </div>
		        </div>
		    </div>
		</div>
	</security:authorize>
</div>