<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>     
<security:authentication property="principal.member_id" var="memberId"/>
<script src="https://cdn.ckeditor.com/ckeditor5/27.1.0/classic/ckeditor.js"></script>
<div class="content">
	<div class="card mb-3" style="max-width:960px;">
	    <div class="card-header">
	        <h3><b>수정</b></h3>
	    </div>
	
	    <div class="card-body">
	
            <div class="form-group">
                <label for="exampleInputEmail1"><b>제목</b></label>
                <input type="text" class="form-control" id="boardTit" value="${inBoard.board_tit }">
            </div><br>
		    <div class="form-group beforeSpan">
		   		<label for="exampleInputEmail1"><b>내용</b></label>
               <div id="editor">${inBoard.board_txt }</div>
            </div>
	    
            <br>
            <button type="submit" class="btn btn-primary" id="insertBtn">수정하기</button>
	
	    </div>
	</div>
</div>

<script>
	var editor;
    ClassicEditor
	    .create( document.querySelector( '#editor' ),{
	    	language: 'ko', 
	    	ckfinder: {
				uploadUrl: '${pageContext.request.contextPath}/multiImageUploader.do',
			}
	    } )
	    .then( newEditor => {
	        editor = newEditor;
	    } )
	    .catch( error => {
	        console.error( error );
	    } );
</script>

<script>
	
	$("#insertBtn").click(function() {
		
		var boardTit = $("#boardTit").val();
		var boardId = "${inBoard.board_id}";
		var boardTxt = "";
		
		if(boardTit.length == 0) {
			alert("제목을 입력하여주세요!");
			return;
		} else {
			boardTxt = editor.getData();
			
			$.ajax({
		       type: "post", 
		       dataType: "text", 
		       contentType: "application/x-www-form-urlencoded;charset=utf-8",
		       url: "${pageContext.request.contextPath}/board/update.do",
		       data : {boardTit : boardTit, boardTxt : boardTxt, boardId : boardId},
		       success: function(rtn) {
	        	  window.location.href = '${pageContext.request.contextPath}/board/${boardType}.do?bid='+boardId+'&pageNum=${pageNum}';
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
		$("#boardThumb").val(filePath);
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