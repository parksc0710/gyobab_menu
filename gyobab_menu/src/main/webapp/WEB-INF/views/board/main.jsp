<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<link href="${pageContext.request.contextPath}/assets/css/board.css" rel="stylesheet" type="text/css" />
<style>
.form-group {
	margin-bottom : 0.7rem
}
</style>
<div class="content">
	<div class="container-fluid">
	    <div class="row">
	        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12" style="max-width:650px;">
	            <div class="card mb-3">
	                <div class="card-header">
	                    <c:choose>
				    		<c:when test="${boardType eq 'notice' }">
				    			<span class="pull-right">
						       	</span>
						        <h4><i class="fa-2x mr-2 far fa-check-circle" style="font-size:25px;"></i><b>공지사항</b></h4>
				    		</c:when>
				    		<c:when test="${boardType eq 'free' }">
				    			<span class="pull-right">
						       	</span>
						        <h4><i class="fa-2x mr-2 far fa-smile" style="font-size:25px;"></i><b>자유게시판</b></h4>
				    		</c:when>
				    		<c:otherwise>
				    			<span class="pull-right">
						       	</span>
						        <h4><i class="fa-2x mr-2 far fa-check-circle"></i><b>공지사항</b></h4>
				    		</c:otherwise>
				    	</c:choose>
	                </div>
	                <!-- end card-header -->
					<c:choose>
			    		<c:when test="${boardType eq 'notice' }">
			    			 <div class="card-body">
			                    <div class="table-responsive" style="overflow-x:hidden;">
					    			<div class="row">
						               	<div class="col-sm-12 col-md-5">
						               		<div class="dataTables_info" id="dataTable_info" role="status" aria-live="polite">
						               			<em class="fa-2x mr-2 fas fa-exclamation-circle" style="font-size:20px;"> 준비중입니다.</em> 
						               		</div>
						               	</div>
					              	</div>
				              	</div>
		               		</div>
			    		</c:when>
	               
	              		<c:otherwise>
	              			<div class="card-body">
			                    <div class="table-responsive" style="overflow-x:hidden;">
					    			<div class="row">
						               	<div class="col-sm-12 col-md-5">
						               		<div class="dataTables_info" id="dataTable_info" role="status" aria-live="polite">
						               			<em class="fa-2x mr-2 fas fa-exclamation-circle" style="font-size:20px;"> 준비중입니다.</em> 
						               		</div>
						               	</div>
					              	</div>
				              	</div>
		               		</div>
					    </c:otherwise>
					</c:choose>
	                <!-- end card-body -->
	            </div>
	            <!-- end card -->
	        </div>
	        <!-- end col -->
	    </div>
	    <!-- end row -->
	</div>
</div>
