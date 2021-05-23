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
img {
	max-width: 100%;
    max-height: 100%;
}
</style>
<div class="content">
	<div class="row">
	    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-6"  style="max-width:650px;">
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
	</div>
	
	<div class="row">
       <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12" style="max-width:650px;">
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
                    <h3><b>공지사항</b></h3>
                </div>
               <div class="card-body" id="noticeTable" style="display:none;">
                   <div class="table-responsive">
                       <table class="table table-bordered">
                           <tbody>
	                            <tr>
                                    <td>
                                	    <div class="blog_list"></div>
                                        <h4 style="color:red;"> 공지사항입니다!
                                        </h4>
                                        <p> 2021-05-24
                                        	<span style="float:right;"><b>개발팀박성철</b></span>
                                        </p>
                                        <p>	
                                        	<div class="img_div">
                                        		<img src="https://www.gyobab.shop/images/board/3ec7e4a2-a78e-4f9f-8a53-74b804b899b2.jpg" style="max-width:100%;max-height:100%">
                                       		</div>
											<h4><b>&lt;업데이트 내역&gt;</b></h4><br>
											<b>- 2021. 05. 24 : 공지사항 게시판, 자유 게시판이 추가되었습니다. 그리고 게시판 템플릿이 변경되었어요! 혹시 사용중에 버그나 건의 사항 있으시면 자유 게시판이나 댓글로 남겨주세요!</b><br><br>
											<b>- 2021. 05. 22 : 메뉴 게시판에 댓글 기능이 추가되었습니다. 다양한 의견을 나눠주세요! (댓글 기능은 로그인을 해야 사용할 수 있습니다.)</b><br><br>
											<b>- 2021. 05. 19 : 메뉴 게시판에 좋아요 기능이 추가되었습니다. 내가 좋아하는 메뉴가 나오면 좋아요를 눌러주세요! (좋아요는 로그인을 해야 사용할 수 있습니다. 내가 누른 좋아요 내역은 공개되지 않습니다.)</b><br><br>
											
											<hr/>
											<h4><b>&lt;중요 공지&gt;</b></h4><br>
											<b>공지 닫기를 누르시면 새로운 공지가 등록되기 전까지는 공지가 열리지 않습니다. <br><br>그러다가 새로운 공지가 올라오면 다시 열려요! <br><br>만약, 공지가 열리면 내용을 꼭 확인해주세요.</b>
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
	<security:authorize ifNotGranted="ROLE_OPERATOR, ROLE_ADMIN, ROLE_USER">
		<div class="row">
		    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-6"  style="max-width:650px;">
		        <div class="card mb-3">
		            <div class="card-header">
		                <h3 style="display:inline"><b>내 온누리교회 바코드</b></h3>
		            </div>
		            <div class="card-body">
		            	소셜 회원가입 후 온누리 교회 바코드를 등록하시면 편리하게 볼 수 있습니다.<br><br>
		            	<b>회원 가입 시 이메일을 제외한 어떠한 정보도 저장하지 않습니다</b>
		            </div>
		        </div>
		    </div>
		</div>
	</security:authorize>
	<div class="row">
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12" style="max-width:650px;">
            <div class="card mb-3">
                <div class="card-header">
                    <span class="pull-right">
	                    <a href="${pageContext.request.contextPath}/board/menu.do" class="btn btn-primary btn-sm btn-block" style="width:180px;">
							<i class="fas fa-search"></i> 메뉴 더 보기
						</a>
                   	</span>
                    <h3><b>오늘의 점심 메뉴</b></h3>
                </div>
                <!-- end card-header -->

                <div class="card-body">

                    <div class="table-responsive">
                    
                    <security:authorize ifAnyGranted="ROLE_OPERATOR, ROLE_USER, ROLE_ADMIN">
                       	<security:authentication property="principal.member_id" var="memberId"/>
						<c:forEach var="item" items="${likelist}">
						  <c:if test="${item.memberVO.member_id eq memberId}">
						    <c:set var="contains" value="true" />
						    <c:set var="boardLikeId" value="${item.board_like_id }" />
						  </c:if>
						</c:forEach>
                    </security:authorize>
                            
                        <table class="table table-bordered" >
                            <tbody>
	                            <tr>
                                    <td>
                                        <div class="blog_list" style="width:100%; height:100%;">
	                                        <span style="width:80%;float:left;padding-right:10px;<c:if test="${topMenu.memberVO.member_id == 1}">color:red;</c:if>"><h4>${topMenu.board_tit }</h4></span> 
	                                       	<span style="width:50px;float:right;">
	                                        	<span style="line-height:2;">
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
                                        <p> <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${topMenu.update_date}" />
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
<script>
	
	// 신규 공지 등록 후 보이게 하려면 newNoticeTime을 수정 시간으로 설정
	var newNoticeTime = new Date("2021-05-24 04:05:00");
	
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