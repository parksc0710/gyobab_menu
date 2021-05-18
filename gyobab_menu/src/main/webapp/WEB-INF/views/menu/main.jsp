<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="content">
	<div class="container-fluid">
	
	    <div class="card-header">
	        <h3><b>오늘의 점심 메뉴</b></h3>
	    </div>
	    <!-- end row -->

	    <div class="row">
	
	        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12" style="max-width:650px;">
	
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
	
	                    <div class="table-responsive" style="overflow-x:hidden;">
	                        <table class="table table-bordered">
	                            <tbody>
		                            <c:forEach var="list" items="${list}">
		                            
			                            <tr>
		                                    <td>
		                                        <div class="blog_list"></div>
		                                        <h4> ${list.board_tit }
		                                        </h4>
		                                        <p> <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${list.update_date}" />
		                                        	<span style="float:right;"><b>${list.memberVO.member_name  }</b></span>
		                                        </p>
		                                        <p>
		                                        	<c:if test="${!empty list.board_thumb}">
		                                        		<img src="${list.board_thumb }" style="width:100%"/> <br><br>
		                                        	</c:if>
		                                        	${list.board_txt}
		                                        </p>
		                                        <p>
		                                        	<security:authorize ifAnyGranted="ROLE_OPERATOR">
				                                        <span style="width:100px;float:right;"><a href="${pageContext.request.contextPath}/menu/updateOperator.do?boardid=${list.board_id }" class="btn btn-primary btn-sm btn-block"><i class="far fa-edit"></i> Edit</a>                                                        
				                                        <a href="javascript:deleteBoard(${list.board_id }, '${list.board_tit }')" class="btn btn-danger btn-sm btn-block mt-2"><i class="fas fa-trash"></i> Delete</a></span>                                                        
				                                    </security:authorize>
				                                    <security:authorize ifAnyGranted="ROLE_ADMIN">
				                                   		<security:authentication property="principal.member_id" var="memberId"/>
														<c:if test="${list.memberVO.member_id == memberId}">
						                                        <span style="width:100px;float:right;"><a href="${pageContext.request.contextPath}/menu/update.do?boardid=${list.board_id }" class="btn btn-primary btn-sm btn-block"><i class="far fa-edit"></i> Edit</a>                                                        
						                                        <a href="javascript:deleteBoard(${list.board_id }, '${list.board_tit }')" class="btn btn-danger btn-sm btn-block mt-2"><i class="fas fa-trash"></i> Delete</a></span>                                                        
					                                    </c:if>
				                                    </security:authorize>
		                                        </p>
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
			retVal += '<a href="${pageContext.request.contextPath}/menu/main.do" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link"><<</a></li>';
		}
		
		if (nPrev > 0) {
			retVal += '<li class="paginate_button page-item previous" id="dataTable_previous">';
			retVal += '<a href="${pageContext.request.contextPath}/menu/main.do?pageNum='+(nPrev+3)+'" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link"><</a></li>';
		} else {
			retVal = "&nbsp;";
		}

		var i = 1;

		do {
			if (pCurPage == nCur) {
				retVal += '<li class="paginate_button page-item active">';
				retVal += 	'<a href="${pageContext.request.contextPath}/menu/main.do?pageNum='+nCur+'" aria-controls="dataTable" data-dt-idx="'+nCur+'" tabindex="0" class="page-link">'+nCur+'</a>';
				retVal += '</li>';
			} else {
				retVal += '<li class="paginate_button page-item">';
				retVal += 	'<a href="${pageContext.request.contextPath}/menu/main.do?pageNum='+nCur+'" aria-controls="dataTable" data-dt-idx="'+nCur+'" tabindex="0" class="page-link">'+nCur+'</a>';
				retVal += '</li>';
			}

			nCur += 1;
			i += 1;
		} while (i < nPageRange + 1 && nCur <= nPageCount);

		if (nNext <= nPageCount) {
			retVal += '<li class="paginate_button page-item previous" id="dataTable_previous">';
			retVal += '<a href="${pageContext.request.contextPath}/menu/main.do?pageNum='+nNext+'" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">></a></li>';
			
			retVal += '<li class="paginate_button page-item previous" id="dataTable_previous">';
			retVal += '<a href="${pageContext.request.contextPath}/menu/main.do?pageNum='+nPageCount+'" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">>></a></li>';

		} else {
			
			retVal += "&nbsp;";
		}
		
		return retVal;
	}
</script>
