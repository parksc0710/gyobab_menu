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
	       <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12" style="max-width:900px;">
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
	           <!-- end card -->
	       </div>
	       <!-- end col -->
	   </div>
	   <div class="row">
       <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12" style="max-width:900px;">
           <div class="card mb-3">
          		<div class="card-header">
                    <span class="pull-right">
                    	<a role="button" href="javascript:noticeToggle()" class="btn btn-danger" id="noticeToggleBtn1" style="display:none;" >
	                        <span class="btn-label">
	                            <i class="fas fa-times"></i>
	                        </span>공지 닫기
                        </a>
                        <a role="button" href="javascript:noticeToggle()" class="btn btn-primary" id="noticeToggleBtn2">
	                        <span class="btn-label">
	                            <i class="fas fa-check"></i>
	                        </span>공지 열기
                        </a>
                   	</span>
                    <h3 style="color:black;"><b><a href="${pageContext.request.contextPath}/board/notice.do">공지사항</a></b></h3>
                </div>
               <div class="card-body" id="noticeTable" style="display:none;">
                   <div class="table-responsive">
                       <table class="table table-bordered">
                           <tbody>
	                            <tr>
                                    <td>
                                	    <div class="blog_list"></div>
                                        <h4 style="color:red;"> ${topNotice.board_tit }
                                        </h4>
                                        <p> <fmt:formatDate pattern="yyyy-MM-dd" value="${topNotice.update_date}" />
                                        	<span style="float:right;"><b>${topNotice.memberVO.member_name }</b></span>
                                        </p>
                                        <p>	
                                        	${topNotice.board_txt }
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
	    <div class="row">
	    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-6"  style="max-width:900px;">
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
				        </div>`
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
				            	<img src="${memberPass }" style="display: block; margin: 0px auto; width: 100%; max-width:450px;"/>
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
		</div>
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12" style="max-width:900px;">
			<div class="card mb-3">
	          		<div class="card-header">
	                    <h3><b><a href="${pageContext.request.contextPath}/board/menu.do">오늘의 점심 메뉴</a></b></h3>
	                </div>
	               <div class="card-body" id="noticeTable">
	                   <div class="table-responsive">
	                       <table class="table">
							  <tbody>
								  	<tr>
								      <td>
                                        <div class="blog_list" style="width:100%; height:100%;">
	                                        <span style="width:80%;float:left;padding-right:10px;"><c:if test="${inBoard.board_cate ne ''}"><span class="cate_span" style="float:left;margin-right:5px;font-size:13px;color:#7b7b7b;">[${topMenu.board_cate}]</span><br></c:if><h4>${topMenu.board_tit }</h4></span> 
	                                       	<span style="width:50px;float:right;">
	                                        	<span style="line-height:2;">
	                                        	<c:set var="contains" value="false" />
					                            <c:set var="boardLikeId" value="0" />
				                            
					                            <security:authorize ifAnyGranted="ROLE_OPERATOR, ROLE_USER, ROLE_ADMIN">
					                            	<security:authentication property="principal.member_id" var="memberId"/>
													<c:forEach var="item" items="${likelist}">
													  <c:if test="${item.memberVO.member_id eq memberId}">
													    <c:set var="contains" value="true" />
													    <c:set var="boardLikeId" value="${item.board_like_id }" />
													  </c:if>
													</c:forEach>
					                            </security:authorize>
	                                        	<c:choose>
		                                        	<c:when test="${contains}">
		                                        		<a href="javascript:deleteLike('${topMenu.board_id }', 'like${topMenu.board_id }')" style="color:red;" id="like${topMenu.board_id }">
		                                        			<em class="fa-2x mr-2 fas fa-heart" style="font-size:20px;"></em>
		                                        		</a>
		                                        	</c:when>
		                                        	<c:otherwise>
		                                        		<a href="javascript:insertLike('${topMenu.board_id }', 'like${topMenu.board_id }')" style="color:red;" id="like${topMenu.board_id }">
		                                        			<em class="fa-2x mr-2 far fa-heart" style="font-size:20px;"></em>
		                                        		</a>
		                                        	</c:otherwise>
	                                        	</c:choose>
	                                        	</span>
	                                        	<span style="float:right;" class="like_cnt"><c:out value="${fn:length(likelist)}"/></span>
	                                       	</span>
                                       	</div>
                                        <p> <fmt:formatDate pattern="yyyy-MM-dd" value="${topMenu.update_date}" />
                                        	<span style="float:right;"><b>${topMenu.memberVO.member_name }</b></span>
                                        </p>
                                        <p>
                                        	${topMenu.board_txt}
                                        </p>
                                        <hr/>
                                        <p>
                                        	<em class="fa-2x mr-2 fas fa-comments" style="font-size:20px;"> ${fn:length(commentlist)}개의 댓글</em>
                                        	<c:forEach var="item" items="${commentlist}">
                                        	
                                        	<security:authorize ifAnyGranted="ROLE_OPERATOR, ROLE_USER, ROLE_ADMIN">
				                            	<security:authentication property="principal.member_id" var="memberId"/>
				                            	<security:authentication property="principal.grantVO.grant_name" var="memberGrant"/>
				                            </security:authorize>
                                        		
                                        		<div class="form-group beforeSpan comment_list <c:if test="${item.board_comment_depth == 1}">reply</c:if>">
		                                        	<div class="form-group beforeSpan comment_tit <c:if test="${item.memberVO.member_id == memberId}">my_comment</c:if> <c:if test="${item.memberVO.member_id == topMenu.memberVO.member_id}">writer_comment</c:if>" style="<c:if test="${item.memberVO.member_id == 1}">color:red;</c:if>"> 
		                                        		<c:choose>
		                                        			<c:when test="${item.memberVO.member_name eq null }">
		                                        				<span style="float:left;color:#b1afaf;"><b>[탈퇴한사용자]</b></span>
		                                        			</c:when>
		                                        			<c:otherwise>
		                                        				<span style="float:left"><b>${item.memberVO.member_name}</b></span>
		                                        			</c:otherwise>
		                                        		</c:choose>
		                                        		<span style="float:right"><fmt:formatDate pattern="yyyy-MM-dd" value="${item.create_date}" /></span>
		                                        	</div>
		                                        	<div class="form-group beforeSpan comment_txt">
		                                        		<span <c:if test="${item.memberVO.member_name eq null }">style="color:#b1afaf;"</c:if> <c:if test="${item.view_flg }">style="color:#b1afaf;"</c:if>>
			                                        		<c:if test="${item.board_comment_depth == 1}">
				                                        		<c:choose>
				                                        			<c:when test="${item.parent_member_name eq null }">
				                                        				<span class="parent_name" style="color:#b1afaf;">@ [탈퇴한사용자]</span>
				                                        			</c:when>
				                                        			<c:otherwise>
				                                        				<span class="parent_name">@ ${item.parent_member_name }</span>
				                                        			</c:otherwise>
				                                        		</c:choose>
			                                        			
			                                        		</c:if>
			                                        		<c:choose>
			                                        			<c:when test="${item.memberVO.member_name eq null }">
			                                        				[삭제된  댓글입니다]
			                                        			</c:when>
			                                        			<c:when test="${item.view_flg}">
				                                        			[삭제된  댓글입니다]
			                                        			</c:when>
			                                        			<c:otherwise>
			                                        				${fn:replace(item.board_comment_txt, newLineChar, "<br/>")}
			                                        			</c:otherwise>
			                                        		</c:choose>
		                                        		</span>
		                                        		
		                                        	</div>
	                                        	</div>
                                        	</c:forEach>
                                        </p>
                                        </td>
                                       </tr>
                                       <tr>
								  		<c:forEach var="list" items="${menuList}" varStatus="status">
								 	 	<tr>
										  	<td <c:if test="${status.index eq 0}">style="background-color:#c3e6cb;"</c:if>>
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
								    </tr>
							  </tbody>
							</table>
	                   </div>
	               </div>
	               <!-- end card-body -->
	           </div>
	       </div>
	   </div>
		<div class="row">
		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12" style="max-width:900px;">
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
		</div>
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12" style="max-width:900px;">
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
	   </div>
	   <div class="row">
	  	 <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12" style="max-width:900px;">
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
	   </div>
	</div>
</div>

<script>

//신규 공지 등록 후 보이게 하려면 newNoticeTime을 수정 시간으로 설정
var newNoticeTime = new Date('<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${topNotice.update_date}" />');

var noticeCloseTime = new Date(getCookie("notice_close"));

if(noticeCloseTime < newNoticeTime || noticeCloseTime == '' || noticeCloseTime == null) {
	$("#noticeTable").slideDown(500);
	$("#noticeToggleBtn1").show();
	$("#noticeToggleBtn2").hide();
}

function noticeToggle() {
	if($("#noticeTable").is(':visible')) {
		$("#noticeTable").slideUp(500);
		$("#noticeToggleBtn1").hide();
		$("#noticeToggleBtn2").show();
		
		var closeTime = getKoreaTime();
		
		setCookie("notice_close", closeTime, 100);

	} else {
		$("#noticeTable").slideDown(500);
		$("#noticeToggleBtn1").show();
		$("#noticeToggleBtn2").hide();
		
		deleteCookie("notice_close");
	}
}

function getCookie(name) {
	var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
	return value? value[2] : null;
};

function setCookie(name, value, exp) {
	var date = new Date();
	date.setTime(date.getTime() + exp*24*60*60*1000);
	document.cookie = name + '=' + value + ';expires=' + date.toUTCString() + ';path=/';
};

function deleteCookie(name) {
	document.cookie = name + '=; expires=Thu, 01 Jan 1999 00:00:10 GMT;';
};

function getKoreaTime() {
	var curr = new Date();

	var utc = curr.getTime() + (curr.getTimezoneOffset() * 60 * 1000);

	var KR_TIME_DIFF = 9 * 60 * 60 * 1000;
	var kr_curr = new Date(utc + (KR_TIME_DIFF));

	return kr_curr;

}

function insertLike(boardId, aId) {
	var likeCnt = $("#"+aId).closest("span").siblings("span.like_cnt").text();
	$.ajax({
       type: "post", 
       dataType: "text", 
       contentType: "application/x-www-form-urlencoded;charset=utf-8",
       url: "${pageContext.request.contextPath}/board/insertLike.do",
       data : {boardId : boardId},
       success: function(rtn) {
    	  //alert("좋아요!.");
    	  if(rtn=="fail") {
    		  swal({title:"로그인이 필요합니다!", text:"좋아요를 누르시려면 로그인을 해 주세요.", icon:"error", timer:"2000"});
    	  } else {
    		  swal({title:"좋아요를 클릭하셨습니다!", text:"좋아요를 다시 눌러서 취소할 수 있어요.", icon:"success", timer:"2000"});
        	  $("#"+aId).closest("span").siblings("span.like_cnt").text(Number(likeCnt)+1);
        	  $("#"+aId).children("em").removeClass("far");
        	  $("#"+aId).children("em").addClass("fas");
        	  $("#"+aId).attr("href","javascript:deleteLike('"+boardId+"', 'like"+boardId+"')");
    	  }
       },
       error:function(request,status,error){
           alert("에러발생. 관리자에게 문의하세요.");
       }
    });
}

function deleteLike(boardId, aId) {
	var likeCnt = $("#"+aId).closest("span").siblings("span.like_cnt").text();
	$.ajax({
       type: "post", 
       dataType: "text", 
       contentType: "application/x-www-form-urlencoded;charset=utf-8",
       url: "${pageContext.request.contextPath}/board/deleteLike.do",
       data : {boardId : boardId},
       success: function(rtn) {
    	  //alert("좋아요!.");
    	  if(rtn=="fail") {
		  	alert("나의 좋아요만 취소할 수 있습니다!")		    		  
    	  } else {
    		swal({title:"좋아요를 취소하셨습니다!", text:"좋아요를 다시 누를 수 있어요.", icon:"success", timer:"2000"});
    	  	$("#"+aId).closest("span").siblings("span.like_cnt").text(Number(likeCnt)-1);
    	  	$("#"+aId).children("em").removeClass("fas");
        	$("#"+aId).children("em").addClass("far");
        	$("#"+aId).attr("href","javascript:insertLike('"+boardId+"', 'like"+boardId+"')");
    	  }
       },
       error:function(request,status,error){
           alert("에러발생. 관리자에게 문의하세요.");
       }
    });
}
</script>