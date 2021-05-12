<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>     
<security:authentication property="principal.member_id" var="memberId"/>
<div class="content">
	<div class="card mb-3">
	    <div class="card-header">
	        <h3><b>메뉴 수정</b></h3>
	    </div>
	
	    <div class="card-body">
	
            <div class="form-group">
                <label for="exampleInputEmail1"><b>제목</b></label>
                <input type="text" class="form-control" id="boardTit" value="${inBoard.board_tit }">
            </div>
            <div class="form-group beforeSpan">
              <label for="exampleInputEmail1"><b>썸네일 (선택)</b></label>
              
              <input type="hidden" value="${inBoard.board_thumb }" id="boardThumb"/>
              <c:if test="${empty inBoard.board_thumb  }">
              	 <div id=preView style="width:100px;"></div>
              	 <div id=uploadForm>
	             	 <form id="passForm" name="frm" method="post">
						<input type="file" id="imageUploadFile" name="file" />
						<a href="javascript:void(0);" class="btn btn-primary btn-sm btn-block" onclick="fileUpload();" style="width:80px;display:inline;float: right;">
							<i class="far fa-edit"></i> 등록
						</a>	
					 </form>
				 </div>
              </c:if>
              <c:if test="${!empty inBoard.board_thumb}">
             	 <div id=preView style="width:100px"><img src="${inBoard.board_thumb }" style="width:100%"></div>
             	 <div id=uploadForm>
				 	<a href="javascript:void(0);" class="btn btn-primary btn-sm btn-block" onclick="fileUpdate();" style="width:80px;display:inline;float: left;">
				 		<i class="far fa-edit"></i> 변경
				 	</a>
				 </div>	
              </c:if>
            </div>
		    <div class="form-group beforeSpan">
                <label for="exampleInputEmail1"><b>본문</b></label>
                <textarea class="form-control" id="boardTxt"  style="margin-top: 0px; margin-bottom: 0px; height: 144px;"><c:out escapeXml = "false" value = "${inBoard.board_txt}"></c:out>
                </textarea>
            </div>
            <br>
            <button type="submit" class="btn btn-primary" id="insertBtn">수정하기</button>
	
	    </div>
	</div>
</div>

<script>
	
	$("#insertBtn").click(function() {
		
		var boardTit = $("#boardTit").val();
		var boardThumb = $("#boardThumb").val();
		var boardTxt = $("#boardTxt").val().replace(/(?:\r\n|\r|\n)/g, '<br/>');
		var boardId = "${inBoard.board_id}";
		
		console.log("boardTit : " + boardTit);
		console.log("boardThumb : " + boardThumb);
		console.log("boardTxt : " + boardTxt);
		console.log("boardId : " + boardId);
		
		if(boardTit.length == 0) {
			alert("제목을 입력하여주세요!");
			return;
		} else {
			
			$.ajax({
		       type: "post", 
		       dataType: "text", 
		       contentType: "application/x-www-form-urlencoded;charset=utf-8",
		       url: "${pageContext.request.contextPath}/menu/update.do",
		       data : {boardTit : boardTit, boardThumb : boardThumb, boardTxt : boardTxt, boardId : boardId},
		       success: function(rtn) {
	        	  window.location.href = '${pageContext.request.contextPath}/menu/main.do';
		       },
		       error:function(request,status,error){
		           alert("게시글 등록에 실패했습니다. 관리자에게 문의하세요.");
		       }
		    });
		}
		
	});
	
	function fileUpload() {
		var form = jQuery("#passForm")[0];
		var formData = new FormData(form);

		jQuery.ajax({
			url : "${pageContext.request.contextPath}/fuploadBoard.do",
			type : "POST",
			processData : false,
			contentType : false,
			dataType: "text",
			data : formData,
			success : function(filename) {
				afterUpload(filename);
			},
			error:function(request,status,error){
		        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    }
		});
	}
	
	function afterUpload(filename) {
		var filePath = "https://www.gyobab.shop/images/board/" + filename;
		$("#memberPassVal").val(filePath);
		$("#preView").html("<img src='"+filePath+"' />");
		$("#uploadForm").empty();
		$("#uploadForm").html('<a href="javascript:void(0);" class="button" onclick="fileUpdate();"><span class="new">변경</span></a>');
	}
	
	function fileUpdate() {
		$("#preView").empty();
		$("#uploadForm").empty();
		$("#boardThumb").val("");
		
		var tmpHtml = '<form id="passForm" name="frm" method="post"><input type="file" id="imageUploadFile" name="file" />';
		tmpHtml += '<a href="javascript:void(0);" class="button" onclick="fileUpload();"><span class="new">등록</span></a></form>';
		
		$("#uploadForm").append(tmpHtml);
	}

</script>