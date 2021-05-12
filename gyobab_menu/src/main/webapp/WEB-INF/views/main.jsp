<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<div class="content">
	<div class="row">
	    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-6"  style="max-width:650px;">
		    <div class="card mb-3">
		    	<div class="card-body">
			        <img src="https://www.gyobab.shop/images/hello.jpg" style="width:100%;max-width:639px;"/><br>
					<security:authorize ifAnyGranted="ROLE_OPERATOR">
					<security:authentication property="principal.member_name" var="memberName"/>
						<h5><b>최고관리자</b></h5>
						<h4><b>${memberName}</b>님 안녕하세요!</h4><br>
					</security:authorize>
					<security:authorize ifAnyGranted="ROLE_ADMIN">
					<security:authentication property="principal.member_name" var="memberName"/>
						<h5><b>관리자</b></h5>
						<h4><b> ${memberName}</b>님 안녕하세요!</h4><br>
					</security:authorize>
					<security:authorize ifAnyGranted="ROLE_USER">
					<security:authentication property="principal.member_name" var="memberName"/>
						<h4><b>${memberName}</b>님 안녕하세요!</h4><br>
					</security:authorize>
				</div>
			</div>
	    </div>
	</div>
	<br>
	<security:authorize ifAnyGranted="ROLE_OPERATOR, ROLE_ADMIN, ROLE_USER">
	<security:authentication property="principal.member_pass" var="memberPass"/>
	<c:choose>
		<c:when test="${memberPass == '' || memberPass == null}">
			<div class="row">
			    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-6"  style="max-width:650px;">
			        <div class="card mb-3">
			            <div class="card-header">
			                <h3 style="display:inline"><b>내 온누리교회 바코드</b></h3><a href="${pageContext.request.contextPath}/user/main.do" class="btn btn-primary btn-sm btn-block" style="width:80px;display:inline;float: right;">
								<i class="fas fa-search"></i> 등록</a>
			            </div>
			            <div class="card-body">
			            	온누리 교회 바코드를 등록하시면 편리하게 볼 수 있습니다.
			            </div>
			        </div>
			    </div>
			</div>
		</c:when>
		<c:otherwise>
			<div class="row">
			    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-6" style="max-width:650px;">
			        <div class="card mb-3">
			            <div class="card-header">
			                <h3 style="display:inline"><b>내 온누리교회 바코드</b></h3>
			                	<a href="${pageContext.request.contextPath}/user/main.do" class="btn btn-primary btn-sm btn-block" style="width:80px;display:inline;float: right;">
									<i class="far fa-edit"></i> 변경
								</a>
			            </div>
			            <div class="card-body">
			            	<img src="${memberPass }" style="display: block; margin: 0px auto; width: 100%; max-width:639px;"/>
			            </div>
			        </div>
			    </div>
			</div>
			
		</c:otherwise>
	</c:choose>
	</security:authorize>
	<br>
		<div class="row">
	        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12" style="max-width:650px;">
	            <div class="card mb-3">
	                <div class="card-header">
	                    <span class="pull-right">
		                    <a href="${pageContext.request.contextPath}/menu/main.do" class="btn btn-primary btn-sm btn-block" style="width:180px;">
								<i class="fas fa-search"></i> 다른 메뉴 보러가기
							</a>
                    	</span>
	                    <h3><b>오늘의 점심 메뉴</b></h3>
	                </div>
	                <!-- end card-header -->
	
	                <div class="card-body">
	
	                    <div class="table-responsive">
	                        <table class="table table-bordered" >
	                            <tbody>
		                            <tr>
	                                    <td>
	                                        <div class="blog_list"></div>
	                                        <h4> ${topMenu.board_tit }</h4>
	                                        <p> <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${topMenu.update_date}" />
	                                        	<span style="float:right;"><b>${topMenu.memberVO.member_name }</b></span>
	                                        </p>
	                                        <p>
	                                        	<c:if test="${!empty topMenu.board_thumb}">
	                                        		<img src="${topMenu.board_thumb }" style="width:100%; max-width:639px;"/> <br><br>
	                                        	</c:if>
	                                        	${topMenu.board_txt}
	                                        </p>
	                                    </td>
	                                </tr>
	                            </tbody>
	                        </table>
	                    </div>
	                </div>
	                <!-- end card-body -->
	            </div>
	            <!-- end card -->
	        </div>
	        <!-- end col -->
	    </div>
</div>