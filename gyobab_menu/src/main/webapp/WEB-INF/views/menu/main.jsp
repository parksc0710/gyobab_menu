<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<div class="content">
	<div class="container-fluid">
	
	    <div class="row">
	        <div class="col-xl-12">
	            <div class="breadcrumb-holder">
	                <h1 class="main-title float-left">오늘의 점심 메뉴</h1>
	                <ol class="breadcrumb float-right">
	                </ol>
	                <div class="clearfix"></div>
	            </div>
	        </div>
	    </div>
	    <!-- end row -->

	    <div class="row">
	
	        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12">
	
	            <div class="card mb-3">
	
	                <div class="card-header">
	                    <span class="pull-right">
	                    	<security:authorize ifAnyGranted="ROLE_OPERATOR, ROLE_ADMIN">
	                    		<a href="#" class="btn btn-primary btn-sm"><i class="fas fa-plus" aria-hidden="true"></i> 새 글 등록하기</a>
	                    	</security:authorize>
                    	</span>
	                    <h3><i class="far fa-file-alt"></i> 서빙고 온누리교회</h3>
	                </div>
	                <!-- end card-header -->
	
	                <div class="card-body">
	
	                    <div class="table-responsive">
	                        <table class="table table-bordered">
	                            <thead>
	                                <tr>
	                                    <th style="">메뉴</th>
	                                    <th style="width:110px">글쓴이</th>
	                                    <security:authorize ifAnyGranted="ROLE_OPERATOR, ROLE_ADMIN">
	                                    	<th style="min-width:110px">Actions</th>
	                                    </security:authorize>
	                                </tr>
	                            </thead>
	                            <tbody>
	
	                                <tr>
	                                    <td>
	                                        <div class="blog_list"></div>
	                                        <h4> 2021년 5월 10일</h4>
	                                        <p>2021-05-10 10:22:43</p>
	                                        <p>
	                                        	흰밥<br>
	                                        	제육볶음<br>
	                                        	셀러드<br>
	                                        	배추김치<br>
	                                        	미역국<br>
	                                        </p>
	                                    </td>
	
	                                    <td>박성철</td>
										<security:authorize ifAnyGranted="ROLE_OPERATOR, ROLE_ADMIN">
		                                    <td>
		                                        <a href="#" class="btn btn-primary btn-sm btn-block"><i class="far fa-edit"></i> Edit</a>                                                        
		                                        <a href="#" class="btn btn-danger btn-sm btn-block mt-2"><i class="fas fa-trash"></i> Delete</a>                                                        
		                                    </td>
	                                    </security:authorize>
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
	    <!-- end row -->
	</div>
</div>