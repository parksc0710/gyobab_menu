<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<security:authentication property="principal.member_id" var="memberId"/>
<div class="content">
	<div class="card mb-3" style="max-width:650px;">
	    <div class="card-header">
	        <h3><b>메뉴 등록</b></h3>
	    </div>
	
	    <div class="card-body">
	
            <div class="form-group">
                <label for="exampleInputEmail1"><b>제목</b></label>
                <input type="text" class="form-control" id="boardTit" >
            </div>
            <div class="form-group beforeSpan">
              <label for="exampleInputEmail1"><b>썸네일 (선택)</b></label>
              <input type="hidden" value="" id="boardThumb"/>
              <div id=preView style="width:80%;"></div>
              <div id=uploadForm>
             	 <form id="passForm" name="frm" method="post">
					<input type="file" id="imageUploadFile" name="file" />
					<a href="javascript:void(0);" class="button" onclick="fileUpload();"><span class="new">등록</span></a>	
				 </form>
		      </div>
            </div>
		    <div class="form-group beforeSpan">
                <label for="exampleInputEmail1"><b>본문</b></label>
                <textarea class="form-control" id="boardTxt"  style="margin-top: 0px; margin-bottom: 0px; height: 300px;"></textarea>
            </div>
            <br>
            <button type="submit" class="btn btn-primary" id="insertBtn">등록하기</button>
	
	    </div>
	</div>
</div>

<script>
	
	$("#insertBtn").click(function() {
		
		var boardType = "1";
		var boardTit = $("#boardTit").val();
		var boardThumb = $("#boardThumb").val();
		var boardTxt = $("#boardTxt").val().replace(/(?:\r\n|\r|\n)/g, '<br/>');
		var boardMember = "${memberId}";
		
		if(boardTit.length == 0) {
			alert("제목을 입력하여주세요!");
			return;
		} else {
			
			$.ajax({
		       type: "post", 
		       dataType: "text", 
		       contentType: "application/x-www-form-urlencoded;charset=utf-8",
		       url: "${pageContext.request.contextPath}/menu/insert.do",
		       data : {boardType : boardType, boardTit : boardTit, boardThumb : boardThumb, boardTxt : boardTxt, boardMember : boardMember},
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
		$("#boardThumb").val(filePath);
		$("#preView").html("<img src='"+filePath+"' style='width:100px;'/>");
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