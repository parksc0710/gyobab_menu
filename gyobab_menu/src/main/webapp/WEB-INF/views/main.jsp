<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="rand"><%= java.lang.Math.round(java.lang.Math.random() * 9) %></c:set>


<div class="content">
	<div class="row">
	    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-6"  style="max-width:650px;">
		    <div class="card mb-3">
		    	<div class="card-body">
 					<security:authorize ifAnyGranted="ROLE_OPERATOR">
					<security:authentication property="principal.member_name" var="memberName"/>
						<h6><b>최고관리자</b></h6>
						<h5><b>${memberName}</b>님 안녕하세요!</h5>
					</security:authorize>
					<security:authorize ifAnyGranted="ROLE_ADMIN">
					<security:authentication property="principal.member_name" var="memberName"/>
						<h6><b>관리자</b></h6>
						<h5><b> ${memberName}</b>님 안녕하세요!</h5>
					</security:authorize>
					<security:authorize ifAnyGranted="ROLE_USER">
					<security:authentication property="principal.member_name" var="memberName"/>
						<h5><b>${memberName}</b>님 안녕하세요!</h5>
					</security:authorize>
		    		<br>
		    		<h5><b>오늘도 맛점하세요!</b></h5>
		    		<c:choose>
		    			<c:when test="${rand eq 0}">
		    				<img src="https://www.gyobab.shop/images/main/r1.png" style="width:100%;max-width:639px;"/><br>
		    			</c:when>
		    			<c:when test="${rand eq 1}">
		    				<img src="https://www.gyobab.shop/images/main/r2.gif" style="width:100%;max-width:639px;"/><br>
		    			</c:when>
		    			<c:when test="${rand eq 2}">
		    				<img src="https://www.gyobab.shop/images/main/r3.png" style="width:100%;max-width:639px;"/><br>
		    			</c:when>
		    			<c:when test="${rand eq 3}">
		    				<img src="https://www.gyobab.shop/images/main/r4.gif" style="width:100%;max-width:639px;"/><br>
		    			</c:when>
		    			<c:when test="${rand eq 4}">
		    				<img src="https://www.gyobab.shop/images/main/r5.jpg" style="width:100%;max-width:639px;"/><br>
		    			</c:when>
		    			<c:when test="${rand eq 5}">
		    				<img src="https://www.gyobab.shop/images/main/r6.png" style="width:100%;max-width:639px;"/><br>
		    			</c:when>
		    			<c:when test="${rand eq 6}">
		    				<img src="https://www.gyobab.shop/images/main/r7.png" style="width:100%;max-width:639px;"/><br>
		    			</c:when>
		    			<c:when test="${rand eq 7}">
		    				<img src="https://www.gyobab.shop/images/main/r8.png" style="width:100%;max-width:639px;"/><br>
		    			</c:when>
		    			<c:when test="${rand eq 8}">
		    				<img src="https://www.gyobab.shop/images/main/r9.png" style="width:100%;max-width:639px;"/><br>
		    			</c:when>
		    			<c:when test="${rand eq 9}">
		    				<img src="https://www.gyobab.shop/images/main/r10.png" style="width:100%;max-width:639px;"/><br>
		    			</c:when>
		    			<c:otherwise>
		    				<img src="https://www.gyobab.shop/images/main/r1.png" style="width:100%;max-width:639px;"/><br>
		    			</c:otherwise>
		    		</c:choose>
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
                                        <h4> 안녕하세요!
                                        </h4>
                                        <p> 2021-05-18
                                        	<span style="float:right;"><b>개발팀박성철</b></span>
                                        </p>
                                        <p>
                                        	<img src="https://www.gyobab.shop/images/board/3ec7e4a2-a78e-4f9f-8a53-74b804b899b2.jpg" style="width:100%"> <br><br>
                                        	오늘의 교밥 사이트에 오신결 환영합니다!<br><br>
											오늘도 좋은 하루 보내세요!<br><br><br>
											
											<b>공지 닫기를 누르시면 공지가 열리지 않습니다. 새로운 공지가 올라오면 다시 열려요!</b>
                                        </p>
                                        <p>
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
	                    <a href="${pageContext.request.contextPath}/menu/main.do" class="btn btn-primary btn-sm btn-block" style="width:180px;">
							<i class="fas fa-search"></i> 메뉴 더 보기
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
<script>

	var noticeCloseFlag = getCookie("notice_close");
	
	if(noticeCloseFlag == false || noticeCloseFlag == null) {
		$("#noticeTable").slideDown(500);
		$("#noticeToggleBtn1").show();
		$("#noticeToggleBtn2").hide();
	}

	function noticeToggle() {
		if($("#noticeTable").is(':visible')) {
			$("#noticeTable").slideUp(500);
			$("#noticeToggleBtn1").hide();
			$("#noticeToggleBtn2").show();
			
			setCookie("notice_close", "true", 100);

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

</script>