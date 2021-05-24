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
    max-height: 600px;
}

</style>

<head>

	<c:set var="boardTypeKr" value="" />
	
	<c:choose>
		<c:when test="${boardType eq 'notice'}">
			<c:set var="boardTypeKr" value="공지사항"/>
  		</c:when>
  		<c:when test="${boardType eq 'free' }">
			<c:set var="boardTypeKr" value="자유게시판"/>
  		</c:when>
  		<c:when test="${boardType eq 'menu' }">
			<c:set var="boardTypeKr" value="오늘의 점심 메뉴"/>
  		</c:when>
  	</c:choose>
  	
	<c:choose>
  		<c:when test="${inBoard ne null }">
			<meta property="og:title"       content="${inBoard.board_tit } | ${boardTypeKr } | 오늘의 교밥" />
			<meta property="og:type"        content="website" />
			<meta property="og:image" content="https://www.gyobab.shop/images/hello.jpg">
			<script>
				document.title = "${inBoard.board_tit } | ${boardTypeKr } | 오늘의 교밥"; 
			</script>
  		</c:when>
  		<c:otherwise>
  			<meta property="og:title"       content="${boardTypeKr } | 오늘의 교밥" />
			<meta property="og:type"        content="website" />
			<meta property="og:image" content="https://www.gyobab.shop/images/hello.jpg">
			<script>
				document.title = "${boardTypeKr } | 오늘의 교밥"; 
			</script>
		</c:otherwise>
 	</c:choose> 
</head>

<div class="content">
	<div class="container-fluid">
	    <div class="row">
	        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12" style="max-width:960px;">
	            <div class="card mb-3">
	                <div class="card-header">
	                    <c:choose>
				    		<c:when test="${boardType eq 'notice' }">
				    			<span class="pull-right">
					    			<security:authorize ifAnyGranted="ROLE_OPERATOR">
			                    		<a href="${pageContext.request.contextPath}/board/insert.do?boardType=${boardType}" class="btn btn-primary btn-sm"><i class="fas fa-plus" aria-hidden="true"></i> 새 글 등록하기</a>
			                    	</security:authorize>
						       	</span>
						        <a href="${pageContext.request.contextPath}/board/notice.do"><h5><i class="fa-2x mr-2 far fa-check-circle" style="font-size:20px;"></i><b>공지사항</b></h5></a>
				    		</c:when>
				    		<c:when test="${boardType eq 'free' }">
				    			<span class="pull-right">
				    				<security:authorize ifAnyGranted="ROLE_OPERATOR, ROLE_USER, ROLE_ADMIN">
			                    		<a href="${pageContext.request.contextPath}/board/insert.do?boardType=${boardType}" class="btn btn-primary btn-sm"><i class="fas fa-plus" aria-hidden="true"></i> 새 글 등록하기</a>
			                    	</security:authorize>
						       	</span>
						        <a href="${pageContext.request.contextPath}/board/free.do"><h5><i class="fa-2x mr-2 far fa-smile" style="font-size:20px;"></i><b>자유게시판</b></h5></a>
				    		</c:when>
				    		<c:when test="${boardType eq 'menu' }">
				    			<span class="pull-right">
				    				<security:authorize ifAnyGranted="ROLE_OPERATOR, ROLE_ADMIN">
			                    		<a href="${pageContext.request.contextPath}/board/insert.do?boardType=${boardType}" class="btn btn-primary btn-sm"><i class="fas fa-plus" aria-hidden="true"></i> 새 글 등록하기</a>
			                    	</security:authorize>
						       	</span>
						         <a href="${pageContext.request.contextPath}/board/menu.do"><h5><i class="fa-2x mr-2 fas fa-star" style="font-size:20px;"></i><b>오늘의 점심 메뉴</b></h5></a>
				    		</c:when>
				    		<c:otherwise>
				    			<span class="pull-right">
						       	</span>
						         <a href="${pageContext.request.contextPath}/board/notice.do"><h5><i class="fa-2x mr-2 far fa-check-circle" style="font-size:20px;"></i><b>공지사항</b></h5></a>
				    		</c:otherwise>
				    	</c:choose>
	                </div>
	                <!-- end card-header -->
		    			 <div class="card-body">
		    			 	<c:if test="${board_id > 0 }"> 
			    			<div class="row">
		    			 		<div class="table-responsive" style="overflow-x:hidden;">
			    			 		<table class="table table-bordered">
		                            <tbody>
			                            <c:set var="contains" value="false" />
			                            <c:set var="boardLikeId" value="0" />
			                            
				                            <security:authorize ifAnyGranted="ROLE_OPERATOR, ROLE_USER, ROLE_ADMIN">
				                            	<security:authentication property="principal.member_id" var="memberId"/>
												<c:forEach var="item" items="${inBoardLike}">
												  <c:if test="${item.memberVO.member_id eq memberId}">
												    <c:set var="contains" value="true" />
												    <c:set var="boardLikeId" value="${item.board_like_id }" />
												  </c:if>
												</c:forEach>
				                            </security:authorize>
				                    	
				                            <tr>
			                                    <td>
			                                        <div class="blog_list" style="width:100%; height:100%;">
			                                        	<span style="width:80%;float:left;padding-right:10px;<c:if test="${inBoard.memberVO.member_id == 1}">color:red;</c:if>"><h4>${inBoard.board_tit }</h4></span> 
			                                        	<span style="width:50px;float:right;">
				                                        	<span style="line-height:2;">
				                                        	<c:choose>
					                                        	<c:when test="${contains}">
					                                        		<a href="javascript:deleteLike('${inBoard.board_id }', 'like${inBoard.board_id }')" style="color:red;" id="like${inBoard.board_id }">
					                                        			<em class="fa-2x mr-2 fas fa-heart" style="font-size:20px;"></em>
					                                        		</a>
					                                        	</c:when>
					                                        	<c:otherwise>
					                                        		<a href="javascript:insertLike('${inBoard.board_id }', 'like${inBoard.board_id }')" style="color:red;" id="like${inBoard.board_id }">
					                                        			<em class="fa-2x mr-2 far fa-heart" style="font-size:20px;"></em>
					                                        		</a>
					                                        	</c:otherwise>
				                                        	</c:choose>
				                                        	</span>
				                                        	<span style="float:right;" class="like_cnt"><c:out value="${fn:length(inBoardLike)}"/></span>
			                                        	</span>
			                                        </div>
			                                        <br>
			                                        <p> <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${inBoard.update_date}" />
			                                        	<span style="float:right;"><b>${inBoard.memberVO.member_name  }</b></span>
			                                        </p>
			                                        <p>
			                                        	<div class="board_txt">
			                                      			${inBoard.board_txt}
			                                      		</div>
			                                        </p>
			                                        <p style="height:31px;">
			                                        	<security:authorize ifAnyGranted="ROLE_OPERATOR">
					                                        <span><a href="${pageContext.request.contextPath}/board/updateOperator.do?boardid=${inBoard.board_id }&boardType=${boardType}&pageNum=${pageNum}" style="float:right;width:100px;" class="btn btn-primary btn-sm btn-block"><i class="far fa-edit"></i> Edit</a>                                                        
					                                        <a href="javascript:deleteBoard(${inBoard.board_id }, '${inBoard.board_tit }')" class="btn btn-danger btn-sm btn-block mt-2" style="width:100px;"><i class="fas fa-trash"></i> Delete</a></span>                                                        
					                                    </security:authorize>
					                                    <security:authorize ifAnyGranted="ROLE_ADMIN, ROLE_USER">
					                                   		<security:authentication property="principal.member_id" var="memberId"/>
															<c:if test="${inBoard.memberVO.member_id == memberId}">
							                                        <span><a href="${pageContext.request.contextPath}/board/update.do?boardid=${inBoard.board_id }&boardType=${boardType}&pageNum=${pageNum}" style="float:right;width:100px;" class="btn btn-primary btn-sm btn-block"><i class="far fa-edit"></i> Edit</a>                                                        
							                                        <a href="javascript:deleteBoard(${inBoard.board_id }, '${inBoard.board_tit }')" class="btn btn-danger btn-sm btn-block mt-2" style="width:100px;"><i class="fas fa-trash"></i> Delete</a></span>                                                        
						                                    </c:if>
					                                    </security:authorize>
			                                        </p>
			                                        <hr/>
			                                        <p id="comment${inBoard.board_id }">
			                                        	<em class="fa-2x mr-2 fas fa-comments" style="font-size:20px;"> ${fn:length(inBoardComment)}개의 댓글</em>
			                                        	<c:forEach var="item" items="${inBoardComment}">
			                                        	
				                                        	<security:authorize ifAnyGranted="ROLE_OPERATOR, ROLE_USER, ROLE_ADMIN">
								                            	<security:authentication property="principal.member_id" var="memberId"/>
								                            	<security:authentication property="principal.grantVO.grant_name" var="memberGrant"/>
								                            </security:authorize>
			                                        		
			                                        		<div class="form-group beforeSpan comment_list <c:if test="${item.board_comment_depth == 1}">reply</c:if>">
					                                        	<div class="form-group beforeSpan comment_tit <c:if test="${item.memberVO.member_id == memberId}">my_comment</c:if> <c:if test="${item.memberVO.member_id == inBoard.memberVO.member_id}">writer_comment</c:if>" style="<c:if test="${item.memberVO.member_id == 1}">color:red;</c:if>"> 
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
					                                        		<span <c:if test="${item.memberVO.member_name eq null }">style="color:#b1afaf;"</c:if> <c:if test="${item.view_flg}">style="color:#b1afaf;"</c:if>>
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
					                                        	<div class="form-group beforeSpan comment_utils">
					                                        		<span style="float: right">
					                                        			<security:authorize ifAnyGranted="ROLE_OPERATOR, ROLE_USER, ROLE_ADMIN">
					                                        				<em class="fa-2x mr-2 fas fa-reply" style="font-size:10px;cursor:pointer;" onclick="replyComment(this);"></em> 
					                                        			</security:authorize>
					                                        			<c:choose>
					                                        				<c:when test="${memberGrant eq 'OPERATOR' }">
					                                        					<em class="fa-2x mr-2 fas fa-edit" style="font-size:10px;cursor:pointer;" onclick="editComment(${item.board_comment_id}, this);"></em> <em class="fa-2x mr-2 fas fa-trash-alt" style="font-size:10px;cursor:pointer;" onclick="deleteComment(${item.board_comment_id});"></em>
					                                        				</c:when>
					                                        				<c:otherwise>
					                                        					<c:if test="${item.memberVO.member_id eq memberId}">
							                                        				<em class="fa-2x mr-2 fas fa-edit" style="font-size:10px;cursor:pointer;" onclick="editComment(${item.board_comment_id}, this);"></em> <em class="fa-2x mr-2 fas fa-trash-alt" style="font-size:10px;cursor:pointer;" onclick="deleteComment(${item.board_comment_id});"></em>
																			 	</c:if>
					                                        				</c:otherwise>
					                                        			</c:choose>
					                                        		</span> 
					                                        	</div>
					                                        	<div class="form-group beforeSpan comment_txt_edit" style="display:none;">
					                                        		<textarea class="form-control"  maxlength="100"  style="margin-top: 0px; margin-bottom: 0px; height: 120px; font-size : 12px;">${item.board_comment_txt }</textarea>
					                                        		<button type="submit" class="btn btn-primary myCustomCommentBtn" style="background:#ff5d48;border-color:#ff5d48;float:left;margin-top:5px;" onclick="commentUpdateCancle(this)">취소</button>
					                                        		<button type="submit" class="btn btn-primary myCustomCommentBtn" onclick="commentUpdate(this, ${item.board_comment_id });" style="margin-top:5px;">내용 수정</button>
					                                        	</div>
					                                        	<div class="form-group beforeSpan comment_txt_reply" style="display:none;">
					                                        		<textarea class="form-control"  maxlength="100"  style="margin-top: 0px; margin-bottom: 0px; height: 80px; font-size : 12px;"></textarea>
					                                        		<button type="submit" class="btn btn-primary myCustomCommentBtn" style="background:#ff5d48;border-color:#ff5d48;float:left;margin-top:5px;" onclick="commentReplyCancle(this)">취소</button>
					                                        		<button type="submit" class="btn btn-primary myCustomCommentBtn" onclick="commentReply(this, '${item.board_comment_id}');" style="margin-top:5px;">답글 등록</button>
				                                        		</div>
				                                        	</div>
			                                        	</c:forEach>
			                                        	<security:authorize ifAnyGranted="ROLE_OPERATOR, ROLE_USER, ROLE_ADMIN">
				                                        	<div class="form-group beforeSpan comment_insert_div">
												                <textarea class="form-control comment_txt"  maxlength="100"  style="margin-top: 0px; margin-bottom: 0px; height: 80px; font-size : 12px;"></textarea>
												            </div>
												            <button type="submit" class="btn btn-primary myCustomCommentBtn" onclick="commentApply(this, ${inBoard.board_id });">등록</button>
											            </security:authorize>
				                                        </p>
				                                    </td>
				                                </tr>
			                            </tbody>
			                        </table>
		                        </div>
	                        </div>
	                        <br><br>
		    			 	</c:if>
			    			<div class="row">
		                    	<div class="table-responsive" style="overflow-x:hidden;">
		                    	 	<h6><b>목록</b></h6>
		                    	 	<hr/>
					               	<table class="table">
									  <tbody>
									  	<c:forEach var="list" items="${list}">
										  	<tr>
										      <td <c:if test="${list.board_id eq inBoard.board_id }">style="background-color:#c3e6cb;"</c:if>>
										      	<a href="${pageContext.request.contextPath}/board/${boardType}.do?bid=${list.board_id}&pageNum=${pageNum}">
											     	<div class="blog_list tit">
			                                        	<span class="tit_span" <c:if test="${list.memberVO.member_id == 1}">style="color:red;"</c:if>>${list.board_tit}</span> 
			                                        	<span class="view_span">
			                                        		<span class="like_icon">
			                                        			<em class="fa-2x mr-2 far fa-heart"></em>
				                                        	</span>
				                                        	<span class="like_cnt">${likes[list]}</span>
				                                        	<span class="like_icon">
			                                        			<em class="fa-2x mr-2 fas fa-comments"></em>
				                                        	</span>
				                                        	<span class="like_cnt">${comments[list]}</span>
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
		       url: "${pageContext.request.contextPath}/board/deleteBoard.do",
		       data : {boardId : boardId},
		       success: function(rtn) {
		    	  alert("삭제가 완료되었습니다.");
	        	  window.location.href = '${pageContext.request.contextPath}/board/${boardType}.do?pageNum=${pageNum}';
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
			retVal += '<a href="${pageContext.request.contextPath}/board/${boardType}.do" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link"><<</a></li>';
		}
		
		if (nPrev > 0) {
			retVal += '<li class="paginate_button page-item previous" id="dataTable_previous">';
			retVal += '<a href="${pageContext.request.contextPath}/board/${boardType}.do?pageNum='+(nPrev+3)+'" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link"><</a></li>';
		} else {
			retVal = "&nbsp;";
		}

		var i = 1;

		do {
			if (pCurPage == nCur) {
				retVal += '<li class="paginate_button page-item active">';
				retVal += 	'<a href="${pageContext.request.contextPath}/board/${boardType}.do?pageNum='+nCur+'" aria-controls="dataTable" data-dt-idx="'+nCur+'" tabindex="0" class="page-link">'+nCur+'</a>';
				retVal += '</li>';
			} else {
				retVal += '<li class="paginate_button page-item">';
				retVal += 	'<a href="${pageContext.request.contextPath}/board/${boardType}.do?pageNum='+nCur+'" aria-controls="dataTable" data-dt-idx="'+nCur+'" tabindex="0" class="page-link">'+nCur+'</a>';
				retVal += '</li>';
			}

			nCur += 1;
			i += 1;
		} while (i < nPageRange + 1 && nCur <= nPageCount);

		if (nNext <= nPageCount) {
			retVal += '<li class="paginate_button page-item previous" id="dataTable_previous">';
			retVal += '<a href="${pageContext.request.contextPath}/board/${boardType}.do?pageNum='+nNext+'" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">></a></li>';
			
			retVal += '<li class="paginate_button page-item previous" id="dataTable_previous">';
			retVal += '<a href="${pageContext.request.contextPath}/board/${boardType}.do?pageNum='+nPageCount+'" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">>></a></li>';

		} else {
			
			retVal += "&nbsp;";
		}
		
		return retVal;
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
	
	function commentApply(obj, boardId) {
		var commentTxt = $(obj).siblings("div.comment_insert_div").children("textarea.comment_txt").val();
		if(commentTxt == "" || commentTxt == null) {
			swal("내용을 입력해주세요!", "내용이 없으면 등록할 수 없습니다.", "error");
		} else {
			$.ajax({
			       type: "post", 
			       dataType: "text", 
			       contentType: "application/x-www-form-urlencoded;charset=utf-8",
			       url: "${pageContext.request.contextPath}/comment/insert.do",
			       data : {boardId : boardId, commentTxt : commentTxt},
			       success: function(rtn) {
			    	  //alert("좋아요!.");
			    	  if(rtn=="fail") {
					  	alert("댓글 등록에 실패했습니다. 관리자에게 문의하세요")		    		  
			    	  } else {
			    		refreshComment(boardId);
			    	  }
			       },
			       error:function(request,status,error){
			           alert("에러발생. 관리자에게 문의하세요.");
			       }
			    });
		}
		
	}
	
	function refreshComment(boardId) {
		location.reload();
	}
	
	function deleteComment(commentId) {
		swal({
		  title: "댓글을 삭제하시겠습니까?",
		  icon: "warning",
		  buttons: true,
		  dangerMode: true,
		})
		.then((willDelete) => {
			if (willDelete) {
				deleteCommentDo(commentId);
			}
		});
	}
	
	function deleteCommentDo(commentId) {
		$.ajax({
	       type: "post", 
	       dataType: "text", 
	       contentType: "application/x-www-form-urlencoded;charset=utf-8",
	       url: "${pageContext.request.contextPath}/comment/delete.do",
	       data : {commentId : commentId},
	       success: function(rtn) {
	    	  if(rtn=="fail") {
			  	alert("댓글 삭제에 실패했습니다. 관리자에게 문의하세요")		    		  
	    	  } else {
    			  swal("댓글이 삭제되었습니다.", {
			     	icon: "success",
			   	  }).then(() => {
			   		refreshComment();
			   	  });
	    	  }
	       },
	       error:function(request,status,error){
	           alert("에러발생. 관리자에게 문의하세요.");
	       }
	    });
	}
	
	function editComment(commentId, obj) {
		var commentListDiv = $(obj).parents("div.comment_list");
		commentListDiv.children("div.comment_txt").hide();
		commentListDiv.children("div.comment_utils").hide();
		commentListDiv.children("div.comment_txt_edit").show();
	}
	
	function commentUpdateCancle(obj) {
		var commentListDiv = $(obj).parents("div.comment_list");
		commentListDiv.children("div.comment_txt_edit").hide();
		commentListDiv.children("div.comment_txt").show();
		commentListDiv.children("div.comment_utils").show();
		var originTxt = commentListDiv.children("div.comment_txt").children("span").html();
		commentListDiv.children("div.comment_txt_edit").children("textarea").val(originTxt.replace(/<br>/g, '\n'));
	}
	
	function commentUpdate(obj, commentId) { 
		var commentTxt = $(obj).siblings("textarea").val();
		//console.log("commentId : " + commentId + " // commentTxt : " + commentTxt);
		swal({
		  title: "댓글을 수정하시겠습니까?",
		  icon: "warning",
		  buttons: true,
		  dangerMode: true,
		})
		.then((willDelete) => {
			if (willDelete) {
				updateCommentDo(commentId, commentTxt);
			}
		});
	}
	
	function updateCommentDo(commentId, commentTxt) {
		commentTxt = commentTxt.trim();
		if(commentTxt == "" || commentTxt == null) {
			swal("내용을 입력해주세요!", "내용이 없으면 수정할 수 없습니다.", "error");
		} else {
			$.ajax({
		       type: "post", 
		       dataType: "text", 
		       contentType: "application/x-www-form-urlencoded;charset=utf-8",
		       url: "${pageContext.request.contextPath}/comment/update.do",
		       data : {commentId : commentId, commentTxt : commentTxt},
		       success: function(rtn) {
		    	  if(rtn=="fail") {
				  	alert("댓글 수정에 실패했습니다. 관리자에게 문의하세요")		    		  
		    	  } else {
	    			  swal("댓글이 수정되었습니다.", {
				     	icon: "success",
				   	  }).then(() => {
				   		refreshComment();
				   	  });
		    	  }
		       },
		       error:function(request,status,error){
		           alert("에러발생. 관리자에게 문의하세요.");
		       }
		    });	
		}
		
	}
	
	function replyComment(obj) {
		$(obj).parent("span").parent("div.comment_utils").siblings("div.comment_txt_reply").show();
	}
	
	function commentReplyCancle(obj) {
		$(obj).parent("div.comment_txt_reply").hide();
		$(obj).siblings("textarea").val("");
	}
	
	function commentReply(obj, board_comment_id) {
		var replyText = $(obj).siblings("textarea").val();
		if(replyText == "" || replyText == null) {
			swal("내용을 입력해주세요!", "내용이 없으면 등록할 수 없습니다.", "error");
		} else {
			$.ajax({
		       type: "post", 
		       dataType: "text", 
		       contentType: "application/x-www-form-urlencoded;charset=utf-8",
		       url: "${pageContext.request.contextPath}/comment/reply.do",
		       data : {board_comment_id : board_comment_id, replyText : replyText},
		       success: function(rtn) {
		    	  if(rtn=="fail") {
				  	alert("답글 등록에 실패했습니다. 관리자에게 문의하세요")		    		  
		    	  } else {
				   	refreshComment();
		    	  }
		       },
		       error:function(request,status,error){
		           alert("에러발생. 관리자에게 문의하세요.");
		       }
		    });	
		}
	}
	
   document.querySelectorAll( 'oembed[url]' ).forEach( element => {
        // Create the <a href="..." class="embedly-card"></a> element that Embedly uses
        // to discover the media.
        const anchor = document.createElement( 'a' );

        anchor.setAttribute( 'href', element.getAttribute( 'url' ) );
        anchor.className = 'embedly-card';

        element.appendChild( anchor );
    } );
</script>