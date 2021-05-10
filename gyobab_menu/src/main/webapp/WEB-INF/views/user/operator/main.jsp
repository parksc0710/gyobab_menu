<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="content">
	<div class="card-header">
        <h3><b>회원 관리 페이지</b></h3>
    </div>
    <div class="col-12">
       <div class="card mb-3">
           <div class="card-header">
               <h3><i class="fas fa-user-friends"></i>회원 정보</h3>
           </div>
           
           <div class="card-body">
	           <div class="table-responsive">
	               <table class="table table-bordered">
	                   <thead>
	                       <tr>
	                           <th style="min-width:300px">회원 정보</th>
	                           <th style="width:120px">권한</th>
	                           <th style="min-width:110px;">Actions</th>
	                       </tr>
	                   </thead>
	                   <tbody>
	                   
		                   <c:forEach var="list" items="${list}">
		                   		<c:set var="memberGrant" value="${list.grantVO.grant_name }"/>
								<tr>
									<td>
										<h4>${list.member_name}</h4>
										<p>${list.member_email}</p>
										<p>가입일 : <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${list.create_date}" /></p>
									</td>
									<td>
									<c:choose>
			                            <c:when test="${memberGrant == 'OPERATOR'}">
			                            	OPERATOR
			                            </c:when>
			                            <c:otherwise>
				                            <select id="grantSelectBox${list.member_id}">
												<option <c:if test="${memberGrant eq 'ADMIN' }">selected="selected"</c:if> value="ADMIN">ADMIN</option>
												<option <c:if test="${memberGrant eq 'USER' }">selected="selected"</c:if> value="USER">USER</option>
											</select>
			                            </c:otherwise>
		                            </c:choose>
									</td>
		                            <td>
		                            <c:choose>
			                            <c:when test="${memberGrant == 'OPERATOR'}">
			                            </c:when>
			                            <c:otherwise>
			                            	<a href="javascript:updateUser(${list.member_id}, '${list.member_name}');" class="btn btn-primary btn-sm btn-block"><i class="far fa-edit"></i> 수정</a>
			                                <a href="javascript:deleteUser(${list.member_id}, '${list.member_name}');" class="btn btn-danger btn-sm btn-block mt-2"><i class="fas fa-trash"></i> 탈퇴</a>
			                            </c:otherwise>
		                            </c:choose>
		                            </td>
								</tr>
							</c:forEach>
	                   </tbody>
	               </table>
	           </div>
	       </div>
           <!-- end card-body-->
       </div>
       <!-- end card-->
   </div>
</div>
<script>
	function updateUser(inId, inName) {
		var newGrantName = $("#grantSelectBox"+inId + " option:selected").val();
		var inText = inName+" 님을 "+ newGrantName +" 권한으로 변경하겠습니까?";
		var checkWithdraw = confirm(inText);
		if(checkWithdraw) {
			$.ajax({
		       type: "post", 
		       dataType: "text", 
		       contentType: "application/x-www-form-urlencoded;charset=utf-8",
		       url: "${pageContext.request.contextPath}/ou/updateMember.do",
		       data : {memberId : inId, newGrantName : newGrantName},
		       success: function(rtn) {
		    	  alert("정보 수정이 완료되었습니다.");
	        	  window.location.href = '${pageContext.request.contextPath}/ou/main.do';
		       },
		       error:function(request,status,error){
		           alert("에러발생. 관리자에게 문의하세요.");
		       }
		    });
		}
	}
	function deleteUser(inId, inName) {
		var inText = inName+" 님을 탈퇴시키겠습니까? \n탈퇴하면 회원의 모든 데이터가 삭제됩니다.";
		var checkWithdraw = confirm(inText);
		if(checkWithdraw) {
			$.ajax({
		       type: "post", 
		       dataType: "text", 
		       contentType: "application/x-www-form-urlencoded;charset=utf-8",
		       url: "${pageContext.request.contextPath}/ou/deleteMember.do",
		       data : {memberId : inId},
		       success: function(rtn) {
		    	  alert("탈퇴가 완료되었습니다.");
	        	  window.location.href = '${pageContext.request.contextPath}/ou/main.do';
		       },
		       error:function(request,status,error){
		           alert("에러발생. 관리자에게 문의하세요.");
		       }
		    });
		}
	}
</script>