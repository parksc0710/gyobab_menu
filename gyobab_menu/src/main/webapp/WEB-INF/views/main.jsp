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
	                                        	<span class="tit_span"><c:if test="${list.board_cate ne ''}"><span class="cate_span" style="float:left;margin-right:5px;font-size:13px;color:#7b7b7b;">[${list.board_cate}]</span></c:if>${list.board_tit}</span> 
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
	       <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-6"  style="max-width:450px;">
			    <security:authorize ifAnyGranted="ROLE_OPERATOR, ROLE_ADMIN, ROLE_USER">
				<security:authentication property="principal.member_pass" var="memberPass"/>
				<c:choose>
					<c:when test="${memberPass == '' || memberPass == null}">
				        <div class="card mb-3">
				            <div class="card-header">
				                <h3 style="display:inline;color:black;"><b>나의 온누리교회 바코드</b></h3><a href="${pageContext.request.contextPath}/user/main.do" class="btn btn-primary btn-sm btn-block" style="width:80px;display:inline;float: right;">
									<i class="fas fa-search"></i> 등록</a>
				            </div>
				            <div class="card-body">
				            	온누리 교회 바코드를 등록하시면 편리하게 볼 수 있습니다.
				            </div>
				        </div>
					</c:when>
					<c:otherwise>
				        <div class="card mb-3">
				            <div class="card-header">
				                <h3 style="display:inline;color:black;"><b>나의 온누리교회 바코드</b></h3>
				                	<a href="${pageContext.request.contextPath}/user/main.do" class="btn btn-primary btn-sm btn-block" style="width:80px;display:inline;float: right;">
										<i class="far fa-edit"></i> 변경
									</a>
				            </div>
				            <div class="card-body">
				            	<img src="${memberPass }" style="display: block; margin: 0px auto; width: 100%; max-width:900px;"/>
				            </div>
				        </div>
					</c:otherwise>
				</c:choose>
				</security:authorize>
				<security:authorize ifNotGranted="ROLE_OPERATOR, ROLE_ADMIN, ROLE_USER">
			        <div class="card mb-3">
			            <div class="card-header">
			                <h3 style="display:inline;color:black;"><b>나의 온누리교회 바코드</b></h3>
			            </div>
			            <div class="card-body">
			            	소셜 회원가입 후 온누리 교회 바코드를 등록하시면 편리하게 볼 수 있습니다.<br><br>
			            	<b>회원 가입 시 이메일을 제외한 어떠한 정보도 저장하지 않습니다</b>
			            </div>
			        </div>
				</security:authorize>
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
	                                        	<span class="tit_span"><c:if test="${list.board_cate ne ''}"><span class="cate_span" style="float:left;margin-right:5px;font-size:13px;color:#7b7b7b;">[${list.board_cate}]</span></c:if>${list.board_tit}</span> 
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
	                                        	<span class="tit_span"><c:if test="${list.board_cate ne ''}"><span class="cate_span" style="float:left;margin-right:5px;font-size:13px;color:#7b7b7b;">[${list.board_cate}]</span></c:if>${list.board_tit}</span> 
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
	                                        	<span class="tit_span"><c:if test="${list.board_cate ne ''}"><span class="cate_span" style="float:left;margin-right:5px;font-size:13px;color:#7b7b7b;">[${list.board_cate}]</span></c:if>${list.board_tit}</span> 
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
	                                        	<span class="tit_span"><c:if test="${list.board_cate ne ''}"><span class="cate_span" style="float:left;margin-right:5px;font-size:13px;color:#7b7b7b;">[${list.board_cate}]</span></c:if>${list.board_tit}</span> 
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