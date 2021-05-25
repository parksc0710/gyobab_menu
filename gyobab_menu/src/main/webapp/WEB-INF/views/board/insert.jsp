<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<security:authentication property="principal.member_id" var="memberId"/>
<script src="https://cdn.ckeditor.com/ckeditor5/27.1.0/classic/ckeditor.js"></script>
<style>
.ck-editor__editable_inline {
    min-height: 400px;
}
</style>
<div class="content">
	<div class="card mb-3" style="max-width:960px;">
	    <div class="card-header">
	    	<c:choose>
	    		<c:when test="${boardType eq 'notice' }">
	    			<h3><b>공지사항 등록</b></h3>
	    		</c:when>
	    		<c:when test="${boardType eq 'free' }">
	    			<h3><b>자유게시판 등록</b></h3>
	    		</c:when>
	    		<c:otherwise>
	    			<h3><b>자유게시판 등록</b></h3>
	    		</c:otherwise>
	    	</c:choose>
	    </div>
	
	    <div class="card-body">
	
            <div class="form-group">
                <label for="exampleInputEmail1"><b>제목</b></label>
                <input type="text" class="form-control" id="boardTit" >
            </div><br>
		    <div class="form-group beforeSpan">
		   		<label for="exampleInputEmail1"><b>내용</b></label>
                <div id="editor"></div>
            </div>
            <br>
            <button type="submit" class="btn btn-primary" id="insertBtn">등록하기</button>
	
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
		
		var boardType = "${boardType}";
		var boardTit = $("#boardTit").val();
		var boardMember = "${memberId}";
		var boardTxt = "";
		
		if(boardTit.length == 0) {
			alert("제목을 입력하여주세요!");
			return;
		} else {
			boardTxt = editor.getData();
			//console.log("boardType : " + boardType + " // boardTit : " + boardTit + " // boardMember : " + boardMember);
			//console.log("boardTxt : " + boardTxt);
			
			$.ajax({
		       type: "post", 
		       dataType: "text", 
		       contentType: "application/x-www-form-urlencoded;charset=utf-8",
		       url: "${pageContext.request.contextPath}/board/insert.do",
		       data : {boardType : boardType, boardTit : boardTit, boardTxt : boardTxt, boardMember : boardMember},
		       success: function(rtn) {
	        	  window.location.href = '${pageContext.request.contextPath}/board/${boardType}.do';
		       },
		       error:function(request,status,error){
		           alert("게시글 등록에 실패했습니다. 관리자에게 문의하세요.");
		       }
		    });
		}
		
	});

</script>