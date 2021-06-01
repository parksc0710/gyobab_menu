<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link href="${pageContext.request.contextPath}/assets/css/board.css" rel="stylesheet" type="text/css" />
<style>
.form-group {
	margin-bottom : 0.7rem
}
a {
	color: black;
}
.table td, .table th {
    padding: .75rem;
    vertical-align: top;
    border-bottom: 1px solid #dee2e6;
    border-top : 0px;
}
img {
	max-width: 100%;
}
em {
	font-size: 14px;
}
</style>
<div class="content">
	<div class="container-fluid">
		
		<!-- 공지사항 -->
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-6"  style="max-width:450px;">
			    <div class="card mb-3">
			    	<div class="card-body">
	 					<security:authorize ifAnyGranted="ROLE_OPERATOR">
						<security:authentication property="principal.member_name" var="memberName"/>
							<h6><b>최고관리자</b></h6>
							<h5><b>${memberName}</b>님 안녕하세요!</h5><br>
						</security:authorize>
						<security:authorize ifAnyGranted="ROLE_ADMIN">
						<security:authentication property="principal.member_name" var="memberName"/>
							<h6><b>관리자</b></h6>
							<h5><b>${memberName}</b>님 안녕하세요!</h5><br>
						</security:authorize>
						<security:authorize ifAnyGranted="ROLE_USER">
						<security:authentication property="principal.member_name" var="memberName"/>
							<h5><b>${memberName}</b>님 안녕하세요!</h5><br>
						</security:authorize>
			    		<h5><b>오늘의 교밥에 오신걸 환영합니다. <br>오늘도 맛점하세요!</b></h5>
			    		<%@ include file="/WEB-INF/views/main_img.jsp" %>
					</div>
				</div>
		    </div>
	       <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12" style="max-width:450px;">
	           <div class="card mb-3">
	          		<div class="card-header">
	                    <h3><b><a href="${pageContext.request.contextPath}/board/notice.do">공지사항</a></b></h3>
	                </div>
	               <div class="card-body" id="noticeTable">
	                   <div class="table-responsive">
	                       <table class="table">
							  <tbody>
							  	<c:forEach var="list" items="${noticeList}">
								  	<tr>
								      <td>
								      	<a href="${pageContext.request.contextPath}/board/notice.do?bid=${list.board_id}&pageNum=0&boardCate=">
									     	<div class="blog_list tit">
									     		<c:if test="${list.board_cate ne ''}"><span class="cate_span" style="float:left;margin-right:5px;font-size:13px;color:#7b7b7b;">[${list.board_cate}]</span></c:if> 
	                                        	<span class="tit_span">${list.board_tit}</span> 
	                                        	<span class="view_span">
	                                        		<span class="like_icon" style="float:right;">
	                                        			<em class="fa-2x mr-2 far fa-eye" style="font-size:12px;"></em>${list.board_view }
		                                        	</span>
	                                        	</span>
	                                        </div>
	                                        <div class="blog_list sub">
		                                        <fmt:formatDate pattern="yyyy-MM-dd" value="${list.update_date}" />
		                                        <span><b>${list.memberVO.member_name  }</b></span>
	                                        </div>
                                        </a>
								      </td>
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
	
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12" style="max-width:450px;">
	           <div class="card mb-3">
	          		<div class="card-header">
	                    <h3><b><a href="${pageContext.request.contextPath}/board/menu.do">오늘의 점심 메뉴</a></b></h3>
	                </div>
	               <div class="card-body" id="noticeTable">
	                   <div class="table-responsive">
	                       <table class="table">
							  <tbody>
							  	<c:forEach var="list" items="${menuList}">
								  	<tr>
								      <td>
								      	<a href="${pageContext.request.contextPath}/board/menu.do?bid=${list.board_id}&pageNum=0&boardCate=">
									     	<div class="blog_list tit">
									     		<c:if test="${list.board_cate ne ''}"><span class="cate_span" style="float:left;margin-right:5px;font-size:13px;color:#7b7b7b;">[${list.board_cate}]</span></c:if> 
	                                        	<span class="tit_span">${list.board_tit}</span> 
	                                        	<span class="view_span">
	                                        		<span class="like_icon" style="float:right;">
	                                        			<em class="fa-2x mr-2 far fa-eye" style="font-size:12px;"></em>${list.board_view }
		                                        	</span>
	                                        	</span>
	                                        </div>
	                                        <div class="blog_list sub">
		                                        <fmt:formatDate pattern="yyyy-MM-dd" value="${list.update_date}" />
		                                        <span><b>${list.memberVO.member_name  }</b></span>
	                                        </div>
                                        </a>
								      </td>
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
	       <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12" style="max-width:450px;">
	           <div class="card mb-3">
	          		<div class="card-header">
	                    <h3><b><a href="${pageContext.request.contextPath}/board/restaurant.do">주변 식당 정보</a></b></h3>
	                </div>
	               <div class="card-body" id="noticeTable">
	                   <div class="table-responsive">
	                       <table class="table">
							  <tbody>
							  	<c:forEach var="list" items="${restaurantList}">
								  	<tr>
								      <td>
								      	<a href="${pageContext.request.contextPath}/board/restaurant.do?bid=${list.board_id}&pageNum=0&boardCate=">
									     	<div class="blog_list tit">
									     		<c:if test="${list.board_cate ne ''}"><span class="cate_span" style="float:left;margin-right:5px;font-size:13px;color:#7b7b7b;">[${list.board_cate}]</span></c:if> 
	                                        	<span class="tit_span">${list.board_tit}</span> 
	                                        	<span class="view_span">
	                                        		<span class="like_icon" style="float:right;">
	                                        			<em class="fa-2x mr-2 far fa-eye" style="font-size:12px;"></em>${list.board_view }
		                                        	</span>
	                                        	</span>
	                                        </div>
	                                        <div class="blog_list sub">
		                                        <fmt:formatDate pattern="yyyy-MM-dd" value="${list.update_date}" />
		                                        <span><b>${list.memberVO.member_name  }</b></span>
	                                        </div>
                                        </a>
								      </td>
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
	
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12" style="max-width:450px;">
	           <div class="card mb-3">
	          		<div class="card-header">
	                    <h3><b><a href="${pageContext.request.contextPath}/board/humor.do">유머게시판</a></b></h3>
	                </div>
	               <div class="card-body" id="noticeTable">
	                   <div class="table-responsive">
	                       <table class="table">
							  <tbody>
							  	<c:forEach var="list" items="${humorList}">
								  	<tr>
								      <td>
								      	<a href="${pageContext.request.contextPath}/board/humor.do?bid=${list.board_id}&pageNum=0&boardCate=">
									     	<div class="blog_list tit">
									     		<c:if test="${list.board_cate ne ''}"><span class="cate_span" style="float:left;margin-right:5px;font-size:13px;color:#7b7b7b;">[${list.board_cate}]</span></c:if> 
	                                        	<span class="tit_span">${list.board_tit}</span> 
	                                        	<span class="view_span">
	                                        		<span class="like_icon" style="float:right;">
	                                        			<em class="fa-2x mr-2 far fa-eye" style="font-size:12px;"></em>${list.board_view }
		                                        	</span>
	                                        	</span>
	                                        </div>
	                                        <div class="blog_list sub">
		                                        <fmt:formatDate pattern="yyyy-MM-dd" value="${list.update_date}" />
		                                        <span><b>${list.memberVO.member_name  }</b></span>
	                                        </div>
                                        </a>
								      </td>
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
	       <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12" style="max-width:450px;">
	           <div class="card mb-3">
	          		<div class="card-header">
	                    <h3><b><a href="${pageContext.request.contextPath}/board/free.do">자유게시판</a></b></h3>
	                </div>
	               <div class="card-body" id="noticeTable">
	                   <div class="table-responsive">
	                       <table class="table">
							  <tbody>
							  	<c:forEach var="list" items="${freeList}">
								  	<tr>
								      <td>
								      	<a href="${pageContext.request.contextPath}/board/free.do?bid=${list.board_id}&pageNum=0&boardCate=">
									     	<div class="blog_list tit">
									     		<c:if test="${list.board_cate ne ''}"><span class="cate_span" style="float:left;margin-right:5px;font-size:13px;color:#7b7b7b;">[${list.board_cate}]</span></c:if> 
	                                        	<span class="tit_span">${list.board_tit}</span> 
	                                        	<span class="view_span">
	                                        		<span class="like_icon" style="float:right;">
	                                        			<em class="fa-2x mr-2 far fa-eye" style="font-size:12px;"></em>${list.board_view }
		                                        	</span>
	                                        	</span>
	                                        </div>
	                                        <div class="blog_list sub">
		                                        <fmt:formatDate pattern="yyyy-MM-dd" value="${list.update_date}" />
		                                        <span><b>${list.memberVO.member_name  }</b></span>
	                                        </div>
                                        </a>
								      </td>
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
	</div>
</div>

<script>
</script>