<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="content">
	<div class="container-fluid">

	    <div class="row">
	
	        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12" style="max-width:960px;">
	
	            <div class="card mb-3">
					<div class="card-header">
						<h4><i class="fas fa-user"></i> <b>마이페이지</b></h4>
				        <span class="pull-right">
					        <a href="${pageContext.request.contextPath}/user/main.do" type="button" class="btn btn-outline-primary mb-2">내 정보</a>
				    		<a href="${pageContext.request.contextPath}/user/board.do" type="button" class="btn btn-outline-primary mb-2">작성 글</a>
			    			<a href="${pageContext.request.contextPath}/user/comment.do" type="button" class="btn btn-outline-primary mb-2 active">작성 댓글</a>
				       	</span>
				    </div>
				   
				   <div class="card-body" style="max-width:960px;">
					<div class="row">
                    	<div class="table-responsive" style="overflow-x:hidden;">
                    	 	<h6><b>총 :  ${totalCnt} 개</b></h6>
                    	 	<hr/>
			               	<table class="table">
							  <tbody>
								  <tr>
								  	<td>원글</td>
						  			<td>댓글</td>
						  		  </tr>
							  	<c:forEach var="list" items="${list}">
							  		<tr>
							  			<td>
							  				<a href="${pageContext.request.contextPath}/board/${list.boardVO.board_type}.do?bid=${list.boardVO.board_id}" target="_blank">${list.boardVO.board_tit}</a>
							  			</td>
							  			<td>
							  				<a href="${pageContext.request.contextPath}/board/${list.boardVO.board_type}.do?bid=${list.boardVO.board_id}#comment_${list.board_comment_id}" target="_blank">${list.board_comment_txt}</a>
							  			</td>
							  		</tr>
							    </c:forEach>
							  </tbody>
							</table>
		              	</div>
	              	</div>
              		</div>
              		<div class="row">
	               	<div class="col-sm-12 col-md-5">
	               		<div class="dataTables_info" id="dataTable_info" role="status" aria-live="polite"></div>
	               	</div>
	                <div class="col-sm-12 col-md-7">
						<div class="dataTables_paginate paging_simple_numbers"
							id="dataTable_paginate">
							<ul class="pagination">
							</ul>
						</div>
					</div>
               	</div>
				   </div>
			   </div>
		   </div>
	   </div>
   </div>
   
<script>
	var curPage = ${pageNum};
	var totCount = ${totalCnt};
	var maxSize = ${pageSize};
	
	//console.log("curPage : " + curPage + " // totCount : " + totCount + " // maxSize : " + maxSize)
	
	var tmpHtml = jsMakePage(curPage, totCount, maxSize);
	//console.log(tmpHtml);
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
			retVal += '<a href="${pageContext.request.contextPath}/user/comment.do" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link"><<</a></li>';
		}
		
		if (nPrev > 0) {
			retVal += '<li class="paginate_button page-item previous" id="dataTable_previous">';
			retVal += '<a href="${pageContext.request.contextPath}/user/comment.do?pageNum='+(nPrev+3)+'" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link"><</a></li>';
		} else {
			retVal = "&nbsp;";
		}
	
		var i = 1;
	
		do {
			if (pCurPage == nCur) {
				retVal += '<li class="paginate_button page-item active">';
				retVal += 	'<a href="${pageContext.request.contextPath}/user/comment.do?pageNum='+nCur+'" aria-controls="dataTable" data-dt-idx="'+nCur+'" tabindex="0" class="page-link">'+nCur+'</a>';
				retVal += '</li>';
			} else {
				retVal += '<li class="paginate_button page-item">';
				retVal += 	'<a href="${pageContext.request.contextPath}/user/comment.do?pageNum='+nCur+'" aria-controls="dataTable" data-dt-idx="'+nCur+'" tabindex="0" class="page-link">'+nCur+'</a>';
				retVal += '</li>';
			}
	
			nCur += 1;
			i += 1;
		} while (i < nPageRange + 1 && nCur <= nPageCount);
	
		if (nNext <= nPageCount) {
			retVal += '<li class="paginate_button page-item previous" id="dataTable_previous">';
			retVal += '<a href="${pageContext.request.contextPath}/user/comment.do?pageNum='+nNext+'" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">></a></li>';
			
			retVal += '<li class="paginate_button page-item previous" id="dataTable_previous">';
			retVal += '<a href="${pageContext.request.contextPath}/user/comment.do?pageNum='+nPageCount+'" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">>></a></li>';
	
		} else {
			
			retVal += "&nbsp;";
		}
		
		return retVal;
	}
</script>
   
