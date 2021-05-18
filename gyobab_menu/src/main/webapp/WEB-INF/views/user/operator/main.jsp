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
	           <div>
	               <table class="table table-bordered">
	                   <thead>
	                       <tr>
	                           <th style="min-width:200px">회원 정보</th>
	                           <th style="min-width:100px;">Actions</th>
	                       </tr>
	                   </thead>
	                   <tbody>
	                   
		                   <c:forEach var="list" items="${list}">
		                   		<c:set var="memberGrant" value="${list.grantVO.grant_name }"/>
								<tr>
									<td>
										<h4>${list.member_name}</h4>
										<p>${list.member_email}</p>
										<p>가입일 : <fmt:formatDate pattern="yyyy-MM-dd" value="${list.create_date}" /></p>
										<p>권한 : 
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
										</p>
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
	               <div class="row">
		               	<div class="col-sm-12 col-md-5">
		               		<div class="dataTables_info" id="dataTable_info" role="status" aria-live="polite"></div>
		               	</div>
		                <div class="col-sm-12 col-md-7">
			               	<div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
			               		<ul class="pagination">
		               			</ul>
		               		</div>
		               	</div>
	               	</div>
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
	
	var curPage = ${pageNum};
	var totCount = ${totalCnt};
	var maxSize = ${pageSize};
	
	//console.log("curPage : " + curPage + " // totCount : " + totCount + " // maxSize : " + maxSize)
	
	var tmpHtml = jsMakePage(curPage, totCount, maxSize);
	console.log(tmpHtml);
	$(".pagination").html(tmpHtml);
	
	function jsMakePage(pCurPage, totCount, maxSize) {
		var nPageRange = 4; //페이지 범위

		var retVal = "";
		var nPageCount;

		if (pCurPage == 0)
			pCurPage = 1;

		if ((totCount % maxSize) > 0) {
			nPageCount = parseInt(totCount / maxSize) + 1;
		} else {
			nPageCount = parseInt(totCount / maxSize);
		}

		var nPrev = (parseInt((pCurPage - 1) / nPageRange) - 1)
				* nPageRange + 1;
		var nCur = parseInt((pCurPage - 1) / nPageRange) * nPageRange + 1;
		var nNext = (parseInt((pCurPage - 1) / nPageRange) + 1)
				* nPageRange + 1;

		if (nPageCount > nPageRange) {
			retVal += '<li class="paginate_button page-item previous" id="dataTable_previous">';
			retVal += '<a href="${pageContext.request.contextPath}/ou/main.do" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link"><<</a></li>';
		}
		
		if (nPrev > 0) {
			retVal += '<li class="paginate_button page-item previous" id="dataTable_previous">';
			retVal += '<a href="${pageContext.request.contextPath}/ou/main.do?pageNum='+(nPrev+3)+'" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link"><</a></li>';
		} else {
			retVal = "&nbsp;";
		}

		var i = 1;

		do {
			if (pCurPage == nCur) {
				retVal += '<li class="paginate_button page-item active">';
				retVal += 	'<a href="${pageContext.request.contextPath}/ou/main.do?pageNum='+nCur+'" aria-controls="dataTable" data-dt-idx="'+nCur+'" tabindex="0" class="page-link">'+nCur+'</a>';
				retVal += '</li>';
			} else {
				retVal += '<li class="paginate_button page-item">';
				retVal += 	'<a href="${pageContext.request.contextPath}/ou/main.do?pageNum='+nCur+'" aria-controls="dataTable" data-dt-idx="'+nCur+'" tabindex="0" class="page-link">'+nCur+'</a>';
				retVal += '</li>';
			}

			nCur += 1;
			i += 1;
		} while (i < nPageRange + 1 && nCur <= nPageCount);

		if (nNext <= nPageCount) {
			retVal += '<li class="paginate_button page-item previous" id="dataTable_previous">';
			retVal += '<a href="${pageContext.request.contextPath}/ou/main.do?pageNum='+nNext+'" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">></a></li>';
			
			retVal += '<li class="paginate_button page-item previous" id="dataTable_previous">';
			retVal += '<a href="${pageContext.request.contextPath}/ou/main.do?pageNum='+nPageCount+'" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">>></a></li>';

		} else {
			
			retVal += "&nbsp;";
		}
		
		return retVal;
	}
</script>