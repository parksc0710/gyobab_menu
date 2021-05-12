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
	                    		<a href="${pageContext.request.contextPath}/menu/insert.do" class="btn btn-primary btn-sm"><i class="fas fa-plus" aria-hidden="true"></i> 새 글 등록하기</a>
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
		                            <c:forEach var="list" items="${list}">
		                            
			                            <tr>
		                                    <td>
		                                        <div class="blog_list"></div>
		                                        <h4> ${list.board_tit }</h4>
		                                        <p> <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${list.update_date}" /></p>
		                                        <p>
		                                        	<c:if test="${!empty list.board_thumb}">
		                                        		<img src="${list.board_thumb }" style="width:100%"/> <br><br>
		                                        	</c:if>
		                                        	${list.board_txt}
		                                        </p>
		                                    </td>
		
		                                    <td>${list.memberVO.member_name }</td>
											<security:authorize ifAnyGranted="ROLE_OPERATOR">
			                                    <td>
			                                        <a href="${pageContext.request.contextPath}/menu/updateOperator.do?boardid=${list.board_id }" class="btn btn-primary btn-sm btn-block"><i class="far fa-edit"></i> Edit</a>                                                        
			                                        <a href="javascript:deleteBoard(${list.board_id }, '${list.board_tit }')" class="btn btn-danger btn-sm btn-block mt-2"><i class="fas fa-trash"></i> Delete</a>                                                        
			                                    </td>
		                                    </security:authorize>
		                                    <security:authorize ifAnyGranted="ROLE_ADMIN">
		                                   		<security:authentication property="principal.member_id" var="memberId"/>
												<c:if test="${list.memberVO.member_id == memberId}">
				                                    <td>
				                                        <a href="${pageContext.request.contextPath}/menu/update.do?boardid=${list.board_id }" class="btn btn-primary btn-sm btn-block"><i class="far fa-edit"></i> Edit</a>                                                        
				                                        <a href="javascript:deleteBoard(${list.board_id }, '${list.board_tit }')" class="btn btn-danger btn-sm btn-block mt-2"><i class="fas fa-trash"></i> Delete</a>                                                        
				                                    </td>
			                                    </c:if>
		                                    </security:authorize>
		                                </tr>
									</c:forEach>
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
<script>
	function deleteBoard(boardId, boardTit) {
		var inText = boardTit + "글을 삭제하시겠습니까?";
		var checkWithdraw = confirm(inText);
		if(checkWithdraw) {
			$.ajax({
		       type: "post", 
		       dataType: "text", 
		       contentType: "application/x-www-form-urlencoded;charset=utf-8",
		       url: "${pageContext.request.contextPath}/menu/deleteBoard.do",
		       data : {boardId : boardId},
		       success: function(rtn) {
		    	  alert("삭제가 완료되었습니다.");
	        	  window.location.href = '${pageContext.request.contextPath}/menu/main.do';
		       },
		       error:function(request,status,error){
		           alert("에러발생. 관리자에게 문의하세요.");
		       }
		    });
		}
	}
</script>
